Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266480AbSKOTJG>; Fri, 15 Nov 2002 14:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266548AbSKOTJG>; Fri, 15 Nov 2002 14:09:06 -0500
Received: from hermes.domdv.de ([193.102.202.1]:56077 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S266480AbSKOTJE>;
	Fri, 15 Nov 2002 14:09:04 -0500
Message-ID: <3DD548AF.2000204@domdv.de>
Date: Fri, 15 Nov 2002 20:19:11 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.20-rc2 in2000.c and t128.c build fixes (resend)
References: <Pine.LNX.4.44L.0211151309400.11268-100000@freak.distro.conectiva>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060705060705040501020100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060705060705040501020100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo,
it seems the gcc 3.2 build fixes for in2000.c and t128.c got lost.

Please see:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103641735125372&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103641959127368&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103641876226674&w=2

Example error without the patch:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.20rc2/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -mcpu=i686 
-march=i686 -falign-loops -falign-jumps -falign-functions   -nostdinc 
-iwithprefix include -DKBUILD_BASENAME=in2000  -c -o in2000.o in2000.c
in2000.c:1919: base_tab causes a section type conflict
in2000.c:1926: int_tab causes a section type conflict
make[3]: *** [in2000.o] Error 1

The attached and combined patch is modified to reflect Alan's comment as 
referenced above.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--------------060705060705040501020100
Content-Type: text/plain;
 name="rc2-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rc2-fixes.patch"

diff -rNu old/drivers/scsi/in2000.c linux/drivers/scsi/in2000.c
--- old/drivers/scsi/in2000.c	2001-09-30 21:26:07.000000000 +0200
+++ linux/drivers/scsi/in2000.c	2002-11-04 14:18:58.000000000 +0100
@@ -1916,14 +1916,14 @@
    0
    };
 
-static const unsigned short base_tab[] in2000__INITDATA = {
+static unsigned short base_tab[] in2000__INITDATA = {
    0x220,
    0x200,
    0x110,
    0x100,
    };
 
-static const int int_tab[] in2000__INITDATA = {
+static int int_tab[] in2000__INITDATA = {
    15,
    14,
    11,
diff -rNu old/drivers/scsi/t128.c linux/drivers/scsi/t128.c
--- old/drivers/scsi/t128.c	2001-12-21 18:41:55.000000000 +0100
+++ kubux/drivers/scsi/t128.c	2002-11-04 14:21:47.000000000 +0100
@@ -142,7 +142,7 @@
 
 #define NO_BASES (sizeof (bases) / sizeof (struct base))
 
-static const struct signature {
+static struct signature {
 	const char *string;
 	int offset;
 } signatures[] __initdata = {
 

--------------060705060705040501020100--

