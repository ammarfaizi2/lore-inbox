Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752626AbWAHOOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbWAHOOd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 09:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbWAHOOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 09:14:33 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26123 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752626AbWAHOOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 09:14:32 -0500
Date: Sun, 8 Jan 2006 15:14:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: [2.6 patch] no longer mark MTD_OBSOLETE_CHIPS as BROKEN
Message-ID: <20060108141430.GJ3774@stusta.de>
References: <20060107220702.GZ3774@stusta.de> <1136678409.30348.26.camel@pmac.infradead.org> <20060108002457.GE3774@stusta.de> <1136680734.30348.34.camel@pmac.infradead.org> <20060107174523.460f1849.akpm@osdl.org> <1136724072.30348.66.camel@pmac.infradead.org> <20060108125700.GI3774@stusta.de> <1136725580.30348.69.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136725580.30348.69.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 01:06:20PM +0000, David Woodhouse wrote:
> On Sun, 2006-01-08 at 13:57 +0100, Adrian Bunk wrote:
> > What I want for 2.6.16 is to remove the wrong dependency of MTD_SHARP on 
> > BROKEN and the non-compiling drivers either still hidden under BROKEN or 
> > removed.
> > 
> > If there is any way I can submit a patch achieving this that would be 
> > acceptable for you simply tell how exactly you want this patch.
> 
> Remove the incorrect BROKEN dependency from MTD_OBSOLETE_CHIPS.
> 
> If you then want to add it again to any chip driver which really doesn't
> compile, feel free. But leave the map drivers alone. Those can be
> switched to use different chip back-ends. 

Patch below.

> dwmw2

cu
Adrian


<--  snip  -->


This patch removes the wrong dependency of MTD_OBSOLETE_CHIPS on BROKEN 
and marks the non-compiling MTD_AMDSTD and MTD_JEDEC drivers as BROKEN.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/mtd/chips/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.15-mm2-full/drivers/mtd/chips/Kconfig.old	2006-01-08 14:16:59.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/mtd/chips/Kconfig	2006-01-08 14:17:25.000000000 +0100
@@ -260,7 +260,7 @@
 	  with this driver will return -ENODEV upon access.
 
 config MTD_OBSOLETE_CHIPS
-	depends on MTD && BROKEN
+	depends on MTD
 	bool "Older (theoretically obsoleted now) drivers for non-CFI chips"
 	help
 	  This option does not enable any code directly, but will allow you to
@@ -273,7 +273,7 @@
 
 config MTD_AMDSTD
 	tristate "AMD compatible flash chip support (non-CFI)"
-	depends on MTD && MTD_OBSOLETE_CHIPS
+	depends on MTD && MTD_OBSOLETE_CHIPS && BROKEN
 	help
 	  This option enables support for flash chips using AMD-compatible
 	  commands, including some which are not CFI-compatible and hence
@@ -291,7 +291,7 @@
 
 config MTD_JEDEC
 	tristate "JEDEC device support"
-	depends on MTD && MTD_OBSOLETE_CHIPS
+	depends on MTD && MTD_OBSOLETE_CHIPS && BROKEN
 	help
 	  Enable older older JEDEC flash interface devices for self
 	  programming flash.  It is commonly used in older AMD chips.  It is

