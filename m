Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTDYCye (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 22:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbTDYCye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 22:54:34 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:40148 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262884AbTDYCyc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 22:54:32 -0400
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Organization: Ozzmosis Corp.
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1
Date: Fri, 25 Apr 2003 00:06:53 -0300
User-Agent: KMail/1.5
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304250006.53769.lucasvr@gobolinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 April 2003 15:47, Marcelo Tosatti wrote:
> Here goes the first candidate for 2.4.21.
>
> Please test it extensively.

Hi,

I had some problems compiling the ramdisk driver:

gcc -D__KERNEL__ -I/Depot/Sources/2.4.21-rc1/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS 
-include /Depot/Sources/2.4.21-rc1/include/linux/modversions.h  -nostdinc 
-iwithprefix include -DKBUILD_BASENAME=rd  -c -o rd.o rd.c
rd.c:88: `CONFIG_BLK_DEV_RAM_SIZE' undeclared here (not in a function)
make[2]: *** [rd.o] Error 1
make[2]: Leaving directory `/Depot/Sources/2.4.21-rc1/drivers/block'
make[1]: *** [_modsubdir_block] Error 2
make[1]: Leaving directory `/Depot/Sources/2.4.21-rc1/drivers'
make: *** [_mod_drivers] Error 2


The simple patch below can fix it, though. Is it ok to check against 
CONFIG_BLK_DEV_RAM_SIZE definition and redefine it if not found?

Lucas



--- 2.4.21-rc1/drivers/block/rd.c.orig	2003-04-23 12:39:39.000000000 -0300
+++ 2.4.21-rc1/drivers/block/rd.c	2003-04-23 12:39:41.000000000 -0300
@@ -69,6 +69,10 @@
 int initrd_below_start_ok;
 #endif
 
+#ifndef CONFIG_BLK_DEV_RAM_SIZE
+#define CONFIG_BLK_DEV_RAM_SIZE	4096
+#endif
+
 /* Various static variables go here.  Most are used only in the RAM disk 
code.
  */
 

