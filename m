Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270206AbRHMNwT>; Mon, 13 Aug 2001 09:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270204AbRHMNwK>; Mon, 13 Aug 2001 09:52:10 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:29962 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S270205AbRHMNv6>;
	Mon, 13 Aug 2001 09:51:58 -0400
Date: Mon, 13 Aug 2001 15:52:10 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.4.8-ac2] Vaio picturebook framebuffer fix...
Message-ID: <20010813155210.G24523@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know if this patch was already posted, but the 2.4.8-ac2
kernel does not compile without this patch (due to name changes
in the aty framebuffer code).

Alan, please apply.

Stelian.

diff -uNr --exclude-from=dontdiff linux-2.4.8-ac2.orig/drivers/video/aty/atyfb_base.c linux-2.4.8-ac2/drivers/video/aty/atyfb_base.c
--- linux-2.4.8-ac2.orig/drivers/video/aty/atyfb_base.c	Mon Aug 13 15:27:33 2001
+++ linux-2.4.8-ac2/drivers/video/aty/atyfb_base.c	Mon Aug 13 13:55:28 2001
@@ -2086,17 +2086,17 @@
 	aty_st_le32(OVR_WID_LEFT_RIGHT, hs, info);
 	udelay(10);
 
-	/* LCD_CONFIG_PANEL */
-	hs=aty_ld_lcd(LCD_CONFIG_PANEL,info);
+	/* CONFIG_PANEL */
+	hs=aty_ld_lcd(CONFIG_PANEL,info);
 	hs|=DONT_SHADOW_HEND ;
-	aty_st_lcd(LCD_CONFIG_PANEL, hs, info);
+	aty_st_lcd(CONFIG_PANEL, hs, info);
 	udelay(10);
 
 #if defined(DEBUG)
 	printk("LCD_INDEX CONFIG_PANEL LCD_GEN_CTRL POWER_MANAGEMENT\n"
 	"%08x  %08x     %08x     %08x\n",
 	aty_ld_le32(LCD_INDEX, info), 
-	aty_ld_lcd(LCD_CONFIG_PANEL, info),
+	aty_ld_lcd(CONFIG_PANEL, info),
 	aty_ld_lcd(LCD_GEN_CTRL, info), 
 	aty_ld_lcd(POWER_MANAGEMENT, info),
 #endif /* DEBUG */	
diff -uNr --exclude-from=dontdiff linux-2.4.8-ac2.orig/drivers/video/aty/mach64.h linux-2.4.8-ac2/drivers/video/aty/mach64.h
--- linux-2.4.8-ac2.orig/drivers/video/aty/mach64.h	Mon Aug 13 15:26:40 2001
+++ linux-2.4.8-ac2/drivers/video/aty/mach64.h	Mon Aug 13 13:55:46 2001
@@ -1148,6 +1148,8 @@
 #define APC_LUT_MN		0x39
 #define APC_LUT_OP		0x3A
 
+/* Values in CONFIG_PANEL */
+#define DONT_SHADOW_HEND	0x00004000
 
 /* Values in LCD_MISC_CNTL */
 #define BIAS_MOD_LEVEL_MASK	0x0000ff00
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
