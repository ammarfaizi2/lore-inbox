Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269225AbTGUPJL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269559AbTGUPJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:09:11 -0400
Received: from ldap.somanetworks.com ([216.126.67.42]:15592 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id S269225AbTGUPJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:09:08 -0400
Date: Mon, 21 Jul 2003 11:24:05 -0400
From: Georg Nikodym <georgn@somanetworks.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH] compilation failure in kernel/suspend.c
Message-Id: <20030721112405.6be4f4e3.georgn@somanetworks.com>
Organization: SOMA Networks
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: #EE>^U0b8z^y>O0BZ>JJMGXyyxSP?<W-(g1&Yh;2p1'N6AeM]{Zfu(v>Uhe8ptGua4P}`QZ
 m%yb7CYwN^TiGQcP&mncyDrjAtLh7cB|m{$C,ww;yaYi*YvQllxb*vet
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.cyqcWiJuyFNYL?"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.cyqcWiJuyFNYL?
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Apologies if you've heard this one before.

>From the latest 2.5 (2.6.0-test1) bk, I get:

  CC      kernel/suspend.o
kernel/suspend.c:293: warning: #warning This might be broken. We need to somehow wait for data to reach the disk
kernel/suspend.c:86: conflicting types for `_text'
include/asm-generic/sections.h:6: previous declaration of `_text'
kernel/suspend.c:86: conflicting types for `_etext'
include/asm-generic/sections.h:6: previous declaration of `_etext'
kernel/suspend.c:86: conflicting types for `_edata'
include/asm-generic/sections.h:7: previous declaration of `_edata'
kernel/suspend.c:86: conflicting types for `__bss_start'
include/asm-generic/sections.h:8: previous declaration of `__bss_start'
make[1]: *** [kernel/suspend.o] Error 1
make: *** [kernel] Error 2

sections.h defines things like "extern char _text[]" whereas suspend.c
defines "extern char _text"

Since the _text, _etext, etc symbols are not even used in suspend.c,
removing them seems the correct thing to do.

--- 1.42/kernel/suspend.c	Fri May  2 14:16:11 2003
+++ edited/suspend.c	Mon Jul 21 11:20:14 2003
@@ -83,7 +83,6 @@
 #define ADDRESS2(x) __ADDRESS(__pa(x))		/* Needed for x86-64 where some pages are in memory twice */
 
 /* References to section boundaries */
-extern char _text, _etext, _edata, __bss_start, _end;
 extern char __nosave_begin, __nosave_end;
 
 extern int is_head_of_free_region(struct page *);

--=.cyqcWiJuyFNYL?
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/HAWWoJNnikTddkMRAmP2AKCLjRh4dUA3YbfJucxrBuRyri2WFgCeMAAi
WcwVF9Bcyal95QNb+g6Mt/Q=
=yIP4
-----END PGP SIGNATURE-----

--=.cyqcWiJuyFNYL?--
