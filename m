Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbTEER0J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 13:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbTEER0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 13:26:09 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:4367 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261158AbTEER0E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 13:26:04 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Bug 663] New: "make modules" causes an error in mwavedd.h.
Date: Mon, 5 May 2003 19:37:58 +0200
User-Agent: KMail/1.5.1
References: <10610000.1052152626@[10.10.2.4]>
In-Reply-To: <10610000.1052152626@[10.10.2.4]>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305051938.12086.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 05 May 2003 18:37, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=663
>
>            Summary: "make modules" causes an error in mwavedd.h.
>     Kernel Version: 2.5.69
>             Status: NEW
>           Severity: blocking
>              Owner: jgarzik@pobox.com
>          Submitter: mdfairch@sfu.ca
>
>
> Distribution:  Redhat 9
> Hardware Environment:
> Athlon 800 on a Gigabyte 7ZX
> 384 megs PC100 RAM
> Ensoniq 1371 sound card
> NV25 video card
>
> Software Environment:
> GCC gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
> Using Kernel 2.4.20-9
> Problem Description:
>
> Steps to reproduce:
> 1) Setup kernel 2.4.20-9 build environment.
> 2) execute "make oldconfig", using default options throughout.
> 3) execute "make bzImage"
> 4) execute "make modules"
>
> Make produces the following error message:
>   gcc -Wp,-MD,drivers/char/mwave/.smapi.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon
> -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix
> include -DMODULE -DMW_TRACE  -DKBUILD_BASENAME=smapi -DKBUILD_MODNAME=mwave
> -c -o
> drivers/char/mwave/.tmp_smapi.o drivers/char/mwave/smapi.c
> In file included from drivers/char/mwave/smapi.c:53:
> drivers/char/mwave/mwavedd.h:129: parse error before "wait_queue_head_t"
> drivers/char/mwave/mwavedd.h:129: warning: no semicolon at end of struct or
> union drivers/char/mwave/mwavedd.h:130: warning: type defaults to `int' in
> declaration of `MWAVE_IPC'
> drivers/char/mwave/mwavedd.h:130: warning: data definition has no type or
> storage class
> drivers/char/mwave/mwavedd.h:140: parse error before "MWAVE_IPC"
> drivers/char/mwave/mwavedd.h:140: warning: no semicolon at end of struct or
> union drivers/char/mwave/mwavedd.h:146: parse error before '}' token
> drivers/char/mwave/mwavedd.h:146: warning: type defaults to `int' in
> declaration of `MWAVE_DEVICE_DATA'
> drivers/char/mwave/mwavedd.h:146: warning: type defaults to `int' in
> declaration of `pMWAVE_DEVICE_DATA'
> drivers/char/mwave/mwavedd.h:146: warning: data definition has no type or
> storage class
> make[3]: *** [drivers/char/mwave/smapi.o] Error 1
>
> Incidentally, this is my first ever bug report regarding the Kernel -- I
> have never built the kernel from a non-distribution supplied source.
> Hopefully I haven't just bothered everyone!


This patch fixes it:

diff -urN -X /home/mb/dontdiff linux-2.5.69.vanilla/drivers/char/mwave/mwavedd.h linux-2.5.69/drivers/char/mwave/mwavedd.h
- --- linux-2.5.69.vanilla/drivers/char/mwave/mwavedd.h	2003-05-05 17:15:47.000000000 +0200
+++ linux-2.5.69/drivers/char/mwave/mwavedd.h	2003-05-05 19:27:49.000000000 +0200
@@ -53,6 +53,7 @@
 #include "mwavepub.h"
 #include <linux/ioctl.h>
 #include <asm/uaccess.h>
+#include <linux/wait.h>

 extern int mwave_debug;
 extern int mwave_3780i_irq;


- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 19:33:37 up  1:58,  2 users,  load average: 1.64, 1.60, 1.33
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tqGEoxoigfggmSgRAsyHAJ4q37rhnHeyuAzP/acBEZ2r0Re2iQCgiOld
78xhgHS0l6bs3BJa3qpdt3Y=
=GwlX
-----END PGP SIGNATURE-----

