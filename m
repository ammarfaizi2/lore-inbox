Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVCTUyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVCTUyE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 15:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVCTUyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 15:54:03 -0500
Received: from smtp-out.hotpop.com ([38.113.3.71]:11664 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261277AbVCTUxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 15:53:39 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Adrian Bunk <bunk@stusta.de>, adaplas@pol.net
Subject: Re: [-mm patch] kill include/video/edid.h
Date: Mon, 21 Mar 2005 04:53:43 +0800
User-Agent: KMail/1.5.4
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050320192915.GR4449@stusta.de>
In-Reply-To: <20050320192915.GR4449@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503210453.43894.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2005 03:29, Adrian Bunk wrote:
> This patch removes some completely unused code.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
>
>  arch/i386/boot/compressed/misc.c |    1 -
>  arch/i386/kernel/setup.c         |    4 ----
>  arch/x86_64/kernel/setup.c       |    3 ---
>  drivers/video/fbmon.c            |    1 -
>  drivers/video/vesafb.c           |    3 ---
>  include/asm-i386/setup.h         |    1 -
>  include/asm-x86_64/bootsetup.h   |    1 -
>  include/video/edid.h             |   27 ---------------------------
>  8 files changed, 41 deletions(-)
>
> --- linux-2.6.11-mm4-full/arch/i386/kernel/setup.c.old	2005-03-20
> 20:06:06.000000000 +0100 +++
> linux-2.6.11-mm4-full/arch/i386/kernel/setup.c	2005-03-20
> 20:06:45.000000000 +0100 @@ -43,8 +43,6 @@
>  #include <linux/nodemask.h>
>  #include <linux/kexec.h>
>
> -#include <video/edid.h>
> -
>  #include <asm/apic.h>
>  #include <asm/e820.h>
>  #include <asm/mpspec.h>
> @@ -118,7 +116,6 @@
>  	unsigned short length;
>  	unsigned char table[0];
>  };
> -struct edid_info edid_info;
>  struct ist_info ist_info;
>  struct e820map e820;
>
> @@ -1468,7 +1465,6 @@
>   	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
>   	drive_info = DRIVE_INFO;
>   	screen_info = SCREEN_INFO;
> -	edid_info = EDID_INFO;
>  	apm_info.bios = APM_BIOS_INFO;
>  	ist_info = IST_INFO;
>  	saved_videomode = VIDEO_MODE;
> --- linux-2.6.11-mm4-full/arch/x86_64/kernel/setup.c.old	2005-03-20
> 20:04:42.000000000 +0100 +++
> linux-2.6.11-mm4-full/arch/x86_64/kernel/setup.c	2005-03-20
> 20:07:11.000000000 +0100 @@ -48,7 +48,6 @@
>  #include <asm/smp.h>
>  #include <asm/msr.h>
>  #include <asm/desc.h>
> -#include <video/edid.h>
>  #include <asm/e820.h>
>  #include <asm/dma.h>
>  #include <asm/mpspec.h>
> @@ -100,7 +99,6 @@
>  	unsigned char table[0];
>  };
>
> -struct edid_info edid_info;
>  struct e820map e820;
>
>  extern int root_mountflags;
> @@ -523,7 +521,6 @@
>   	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
>   	drive_info = DRIVE_INFO;
>   	screen_info = SCREEN_INFO;
> -	edid_info = EDID_INFO;
>  	saved_video_mode = SAVED_VIDEO_MODE;
>  	bootloader_type = LOADER_TYPE;
>
> --- linux-2.6.11-mm4-full/drivers/video/fbmon.c.old	2005-03-20
> 20:03:56.000000000 +0100 +++
> linux-2.6.11-mm4-full/drivers/video/fbmon.c	2005-03-20 20:04:27.000000000
> +0100 @@ -34,7 +34,6 @@
>  #include <asm/prom.h>
>  #include <asm/pci-bridge.h>
>  #endif
> -#include <video/edid.h>
>  #include "edid.h"
>
>  /*
> --- linux-2.6.11-mm4-full/drivers/video/vesafb.c.old	2005-03-20
> 20:04:12.000000000 +0100 +++
> linux-2.6.11-mm4-full/drivers/video/vesafb.c	2005-03-20 20:04:18.000000000
> +0100 @@ -19,9 +19,6 @@
>  #include <linux/fb.h>
>  #include <linux/ioport.h>
>  #include <linux/init.h>
> -#ifdef __i386__
> -#include <video/edid.h>
> -#endif
>  #include <asm/io.h>
>  #include <asm/mtrr.h>
>
> --- linux-2.6.11-mm4-full/arch/i386/boot/compressed/misc.c.old	2005-03-20
> 20:05:55.000000000 +0100 +++
> linux-2.6.11-mm4-full/arch/i386/boot/compressed/misc.c	2005-03-20
> 20:05:58.000000000 +0100 @@ -12,7 +12,6 @@
>  #include <linux/linkage.h>
>  #include <linux/vmalloc.h>
>  #include <linux/tty.h>
> -#include <video/edid.h>
>  #include <asm/io.h>
>  #include <asm/page.h>
>
> --- linux-2.6.11-mm4-full/include/asm-x86_64/bootsetup.h.old	2005-03-20
> 20:07:33.000000000 +0100 +++
> linux-2.6.11-mm4-full/include/asm-x86_64/bootsetup.h	2005-03-20
> 20:07:44.000000000 +0100 @@ -25,7 +25,6 @@
>  #define KERNEL_START (*(unsigned int *) (PARAM+0x214))
>  #define INITRD_START (*(unsigned int *) (PARAM+0x218))
>  #define INITRD_SIZE (*(unsigned int *) (PARAM+0x21c))
> -#define EDID_INFO (*(struct edid_info *) (PARAM+0x140))
>  #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
>  #define EDD_MBR_SIG_NR (*(unsigned char *) (PARAM+EDD_MBR_SIG_NR_BUF))
>  #define EDD_MBR_SIGNATURE ((unsigned int *) (PARAM+EDD_MBR_SIG_BUF))
> --- linux-2.6.11-mm4-full/include/asm-i386/setup.h.old	2005-03-20
> 20:07:52.000000000 +0100 +++
> linux-2.6.11-mm4-full/include/asm-i386/setup.h	2005-03-20
> 20:07:55.000000000 +0100 @@ -55,7 +55,6 @@
>  #define KERNEL_START (*(unsigned long *) (PARAM+0x214))
>  #define INITRD_START (*(unsigned long *) (PARAM+0x218))
>  #define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
> -#define EDID_INFO   (*(struct edid_info *) (PARAM+0x140))
>  #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
>  #define EDD_MBR_SIG_NR (*(unsigned char *) (PARAM+EDD_MBR_SIG_NR_BUF))
>  #define EDD_MBR_SIGNATURE ((unsigned int *) (PARAM+EDD_MBR_SIG_BUF))

Not this one.  Code that grabs the EDID block using the video BIOS is in video.S.
Currently, there's no driver that uses this but it's an acceptable backup for drivers
that want the EDID block but has no i2c, or i2c probing fails.

Tony


