Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285058AbRLUTsD>; Fri, 21 Dec 2001 14:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285051AbRLUTrx>; Fri, 21 Dec 2001 14:47:53 -0500
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:517 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S285073AbRLUTrm>;
	Fri, 21 Dec 2001 14:47:42 -0500
Date: Fri, 21 Dec 2001 20:47:18 +0100 (CET)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Linux 2.4.17 - compile error in drivers/video/aty/aty_base.c
In-Reply-To: <Pine.LNX.4.21.0112211439390.7313-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0112212040190.15952-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2001, Marcelo Tosatti wrote:

> Well, 
> 
> Here it is... 

Argh... I knew I should have tried the -rc kernels.  Compiling
CONFIG_FB_ATY_GX as a module gives me the following error:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.17/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -DEXPORT_SYMTAB 
-c atyfb_base.c
atyfb_base.c:388: `ram_resv' undeclared here (not in a function)
atyfb_base.c:388: initializer element is not constant
atyfb_base.c:388: (near initialization for `aty_gx_ram[7]')
atyfb_base.c:250: warning: `curblink' defined but not used

The following patch fixes the error:

diff -ru linux-2.4.17.orig/drivers/video/aty/atyfb_base.c linux-2.4.17/drivers/video/aty/atyfb_base.c
--- linux-2.4.17.orig/drivers/video/aty/atyfb_base.c	Fri Dec 21 19:18:45 2001
+++ linux-2.4.17/drivers/video/aty/atyfb_base.c	Fri Dec 21 20:35:42 2001
@@ -366,6 +366,7 @@
 
 #if defined(CONFIG_FB_ATY_GX) || defined(CONFIG_FB_ATY_CT)
 static char ram_dram[] __initdata = "DRAM";
+static char ram_resv[] __initdata = "RESV";
 #endif /* CONFIG_FB_ATY_GX || CONFIG_FB_ATY_CT */
 
 #ifdef CONFIG_FB_ATY_GX
@@ -378,7 +379,6 @@
 static char ram_sgram[] __initdata = "SGRAM";
 static char ram_wram[] __initdata = "WRAM";
 static char ram_off[] __initdata = "OFF";
-static char ram_resv[] __initdata = "RESV";
 #endif /* CONFIG_FB_ATY_CT */
 
 #ifdef CONFIG_FB_ATY_GX

Better luck next time, Dave!  ;-)

/Tobias

