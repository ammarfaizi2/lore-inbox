Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbTGLGY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 02:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267733AbTGLGY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 02:24:56 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:38596
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S266807AbTGLGYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 02:24:52 -0400
Message-ID: <3F0FACFF.3020403@redhat.com>
Date: Fri, 11 Jul 2003 23:38:55 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030710 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: utimes/futimes/lutimes syscalls
References: <3F0F9B0C.10604@redhat.com>	<3F0F9E9A.9050502@redhat.com> <16143.41797.797147.206845@napali.hpl.hp.com>
In-Reply-To: <16143.41797.797147.206845@napali.hpl.hp.com>
X-Enigmail-Version: 0.80.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090503010206040803070801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090503010206040803070801
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Mosberger wrote:

> Do you have this backwards?  ia64 has utimes(), but not utime().  The
> same should be true for Alpha.

Yes, it was meant to say "why not for archs *other than* ...".

I attach the x86 version of the change.

- --
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/D6z/2ijCOnn/RHQRAl8uAKClUPu1rNyaND4F90tZB1+y9+IfAgCfcs49
ihs1EesN3+egIbHHdE00H2c=
=HK+M
-----END PGP SIGNATURE-----

--------------090503010206040803070801
Content-Type: text/plain;
 name="d-kernel-utimes"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="d-kernel-utimes"

--- linux-2.5/arch/i386/kernel/entry.S-old	2003-07-07 15:56:22.000000000 -0700
+++ linux-2.5/arch/i386/kernel/entry.S	2003-07-11 22:46:02.000000000 -0700
@@ -876,6 +876,7 @@ ENTRY(sys_call_table)
  	.long sys_clock_nanosleep
 	.long sys_statfs64
 	.long sys_fstatfs64	
-	.long sys_tgkill
+	.long sys_tgkill	/* 270 */
+	.long sys_utimes
  
 nr_syscalls=(.-sys_call_table)/4
--- linux-2.5/include/asm-i386/unistd.h-old	2003-07-07 15:56:22.000000000 -0700
+++ linux-2.5/include/asm-i386/unistd.h	2003-07-11 22:45:21.000000000 -0700
@@ -276,8 +276,9 @@
 #define __NR_statfs64		268
 #define __NR_fstatfs64		269
 #define __NR_tgkill		270
+#define __NR_utimes		271
 
-#define NR_syscalls 271
+#define NR_syscalls 272
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 

--------------090503010206040803070801--

