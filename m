Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267940AbUGaK2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267940AbUGaK2P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 06:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267939AbUGaK2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 06:28:15 -0400
Received: from [38.113.3.51] ([38.113.3.51]:10401 "EHLO snickers.hotpop.com")
	by vger.kernel.org with ESMTP id S267936AbUGaK2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 06:28:13 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH 5/5] [I810FB]: i810fb fixes
Date: Sat, 31 Jul 2004 18:26:19 +0800
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <200407290955.29735.adaplas@hotpop.com> <20040731000754.GF2746@fs.tum.de>
In-Reply-To: <20040731000754.GF2746@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407311826.19970.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 July 2004 08:07, Adrian Bunk wrote:
>
> If you select something, you have to ensure that the dependencies of
> what you select are fulfilled.
>
> Since AGP_INTEL depends on X86 && !X86_64 , you must add this to the
> dependencies of FB_I810 if it selects AGP_INTEL.

Thanks.  Incremental patch included.

Tony

1. Make i810fb depend on X86 but not X86_64
2. Fixed typo in i810_init_monspecs(). Reported by Manuel Lauss <slauss@resi.at>.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/i810/i810_main.c linux-2.6.8-rc2-mm1/drivers/video/i810/i810_main.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/i810/i810_main.c	2004-07-31 16:52:12.341681400 +0800
+++ linux-2.6.8-rc2-mm1/drivers/video/i810/i810_main.c	2004-07-31 16:53:18.937557288 +0800
@@ -1656,7 +1656,7 @@ static void __devinit i810_init_monspecs
 		info->monspecs.hfmax = hsync2;
 	if (!info->monspecs.hfmin)
 		info->monspecs.hfmin = hsync1;
-	if (hsync1 < hsync2) 
+	if (hsync2 < hsync1) 
 		info->monspecs.hfmin = hsync2;
 
 	if (!vsync1)
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/Kconfig linux-2.6.8-rc2-mm1/drivers/video/Kconfig
--- linux-2.6.8-rc2-mm1-orig/drivers/video/Kconfig	2004-07-31 16:52:12.337682008 +0800
+++ linux-2.6.8-rc2-mm1/drivers/video/Kconfig	2004-07-31 16:53:21.306197200 +0800
@@ -457,7 +457,7 @@ config FB_RIVA_DEBUG
 
 config FB_I810
 	tristate "Intel 810/815 support (EXPERIMENTAL)"
-	depends on FB && EXPERIMENTAL && PCI	
+	depends on FB && EXPERIMENTAL && PCI && X86	
 	select AGP
 	select AGP_INTEL
 	help




