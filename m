Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUAENM7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 08:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbUAENM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 08:12:59 -0500
Received: from ahriman.Bucharest.roedu.net ([141.85.128.71]:25776 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S264246AbUAENM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 08:12:57 -0500
Date: Mon, 5 Jan 2004 15:13:43 +0200 (EET)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: dizzy@ahriman.bucharest.roedu.net
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.24-rc1
In-Reply-To: <Pine.LNX.4.58L.0401051003341.1188@logos.cnet>
Message-ID: <Pine.LNX.4.58L0.0401051509100.24588@ahriman.bucharest.roedu.net>
References: <Pine.LNX.4.58L.0401051003341.1188@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

On Mon, 5 Jan 2004, Marcelo Tosatti wrote:

> 
> 
> This release fixes a few critical problems in 2.4.23, including fixes
> for two security bugs.
> 
> Upgrade is recommended.

Indeed!

I have noticed that 2.6.0 seems to have the same codes for mremap.c, 
shouldnt 2.6.1 merge the following patch before release ?

- --- linux-2.4.23/mm/mremap.c    2003-08-25 11:44:44.000000000 +0000
+++ linux-2.4.24-rc1/mm/mremap.c        2004-01-04 20:52:19.000000000 +0000
@@ -241,6 +241,13 @@
 
                if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
                        goto out;
+               /*
+                * Allow new_len == 0 only if new_addr == addr
+                * to preserve truncation in place (that was working
+                * safe and some app may depend on it).
+                */
+               if (unlikely(!new_len && new_addr != addr))
+                       goto out;
 
                /* Check if the location we're moving into overlaps the
                 * old location at all, and fail if it does.

PS: I have also downloaded 2.6.1 bk6 snapshot patch and I have not seen 
any diff for mremap.c.

- -- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+WMJPZzOzrZY/1QRAhv0AKDkgqimVpAMwBWavfKN+WjEU8SF+gCdHUiC
XBbcRzJA5zfsUboMK0N5jKs=
=eBik
-----END PGP SIGNATURE-----
