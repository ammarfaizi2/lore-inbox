Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266482AbUAOHrb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 02:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266501AbUAOHra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 02:47:30 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:10206
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S266482AbUAOHq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 02:46:56 -0500
Message-ID: <400644A8.4000602@redhat.com>
Date: Wed, 14 Jan 2004 23:43:36 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: Jakub Jelinek <jakub@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Eric Youngdale <eric@andante.org>
Subject: Re: [PATCH] stronger ELF sanity checks v2
References: <Pine.LNX.4.56.0401130228490.2265@jju_lnx.backbone.dif.dk> <20040113173509.GM31589@devserv.devel.redhat.com> <Pine.LNX.4.56.0401131915370.3148@jju_lnx.backbone.dif.dk>
In-Reply-To: <Pine.LNX.4.56.0401131915370.3148@jju_lnx.backbone.dif.dk>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jesper Juhl wrote:

> - Correctness. If it's invalid it /should/ fail, and as early as possible.
> [...]

A _lot_ of tests are possible, but you don't want to perform them in the
kernel.  The elflint tool I wrote and which Jakub mentioned gives you an
impression of what tests are possible.  You do not want to run all these
tests in the kernel to fulfill your "as early as possible" rule.

The kernel should restrict itself to testing the values which affect the
execution.  This was already (mostly) the case with the old loader which
is why I never bothered to send any changes.  Every additional check is
just extra overhead for 99.999% of all cases.

ld.so performs itself some tests, supplementing the tests in the kernel.
 This is enough to catch ill-formed programs which might cause problems.

If you want to have notification of changed files use tripwire or an
equivalent.  If you want to find invalid ELF files, use elflint.  The
right tool for the job.

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFABkSo2ijCOnn/RHQRAqJlAJ48KnZ/O3xHgKc3bDOPMF8cV9DGdQCgrBqA
A9t3cBQeO7o4IMWHd2MQNqs=
=KYJ7
-----END PGP SIGNATURE-----
