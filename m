Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTDIWot (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263842AbTDIWos (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:44:48 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:13003
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263857AbTDIWoq (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 18:44:46 -0400
Message-ID: <3E94A4F8.8060304@redhat.com>
Date: Wed, 09 Apr 2003 15:55:52 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030407
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: fdavis@si.rr.com
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-english user messages
References: <3E93A958.80107@si.rr.com> <20030409080803.GC29167@mea-ext.zmailer.org> <20030409080803.GC29167@mea-ext.zmailer.org> <20030409190700.H19288@almesberger.net> <3E94A1B4.6020602@si.rr.com>
In-Reply-To: <3E94A1B4.6020602@si.rr.com>
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Frank Davis wrote:

> "My suggestion would be to add the required i18n support to klogd, so
> that kernel messages are translated as they are removed from dmesg into
> syslog. Then, like any i18n support,

This is _not_ like any i18n support.  The problem is that normal
translation support a la gettext or catgets() see the format strings and
not the results.  Translating format strings is easy, translating
results isn't since the translation part has to take the expansion of
the format elements into account.

For numeric format elements this might be possible.  But not without
major problems with %s.  Take hostnames or filenames, which could in
theory contain spaces <U0020>.  You'd have to match using complex
regular expressions.

Another problem is the explosion of messages.  Message lines are often
composed from different sources.  If you see only the end result you'll
have to account for all the different combinations.


I don't say this is impossible, but it is a lot more work, a much more
complex and slower translation mechanism, and (most critical) requires
very strict rules for the creation of messages in the kernel.  I think
the latter point is the killer.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+lKT42ijCOnn/RHQRAlvSAJ9etqgCfTjZ6jZ2M6N+hRY0Hx97AgCeLERp
nPqnFOWpR2s3PuUAuTYfN4E=
=tTfW
-----END PGP SIGNATURE-----

