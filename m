Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbUBZWar (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbUBZWam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:30:42 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:939 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S261209AbUBZW3t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:29:49 -0500
Message-ID: <403E7348.60503@redhat.com>
Date: Thu, 26 Feb 2004 14:29:28 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add getdents32t syscall
References: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz> <Pine.LNX.4.58.0402261411420.7830@ppc970.osdl.org> <Pine.LNX.4.58.0402261415590.7830@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402261415590.7830@ppc970.osdl.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:

>  - pre-fill the dirent area with 0xff or something

fill whole temporary buffer allocated by opendir() for every call to
getdents(2)?


You are swapping a bit of additional kernel code for quite a bit of
overhead at every program's runtime.

Yes, you want to keep your code small and tidy, but getdents calls are
frequent and the wasted cycles spent on the memory operations far
outweigh the extra code.  In many cases we have to clear a 8k+ buffer
just because getdents fills in 200 bytes.


Plus, the old code, like all compatibility interface, can over time be
grouped together and moved to one side of the kernel so that they don't
disturb the icache.

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAPnNI2ijCOnn/RHQRAnynAKDH4GOGnF3ai/7UHdfc7siArOF7fwCePZZP
huZUMCSGIhAM5uw1zgpLSmM=
=YtUt
-----END PGP SIGNATURE-----
