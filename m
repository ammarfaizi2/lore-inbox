Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVC1MbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVC1MbF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 07:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVC1MbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 07:31:05 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:28678 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261638AbVC1May (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 07:30:54 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] print an explanation why i810 fb doesn't come up
Date: Mon, 28 Mar 2005 15:30:40 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wj/RCHO6QKARCL7"
Message-Id: <200503281530.40665.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_wj/RCHO6QKARCL7
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've spent silly amonunt of time trying to use i810 fb on my new spiffy
flat panel. This patch will hopefully help other poor souls.

Patch also fixes module parameter comments.
--
vda

--Boundary-00=_wj/RCHO6QKARCL7
Content-Type: text/x-diff;
  charset="koi8-r";
  name="i810_main.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="i810_main.c.diff"

--- linux-2.6.11.src/drivers/video/i810/i810_main.c.orig	Thu Mar  3 09:30:58 2005
+++ linux-2.6.11.src/drivers/video/i810/i810_main.c	Mon Mar 28 15:04:58 2005
@@ -999,8 +999,14 @@ static int i810_check_params(struct fb_v
 	info->monspecs.dclkmin = 15000000;
 
 	if (fb_validate_mode(var, info)) {
-		if (fb_get_mode(FB_MAXTIMINGS, 0, var, info))
+		if (fb_get_mode(FB_MAXTIMINGS, 0, var, info)) {
+			int default_sync = (hsync1-HFMIN)|(hsync2-HFMAX)
+					    |(vsync1-VFMIN)|(vsync2-VFMAX);
+			printk("i810fb: invalid video mode%s\n",
+			    default_sync ? "" : 
+			    ". Specifying vsyncN/hsyncN parameters may help");
 			return -EINVAL;
+		}
 	}
 	
 	var->xres = xres;
@@ -2020,10 +2026,10 @@ MODULE_PARM_DESC(vyres, "Virtual vertica
 		 " (default = 480)");
 module_param(hsync1, int, 0);
 MODULE_PARM_DESC(hsync1, "Minimum horizontal frequency of monitor in KHz"
-		 " (default = 31)");
+		 " (default = 29)");
 module_param(hsync2, int, 0);
 MODULE_PARM_DESC(hsync2, "Maximum horizontal frequency of monitor in KHz"
-		 " (default = 31)");
+		 " (default = 30)");
 module_param(vsync1, int, 0);
 MODULE_PARM_DESC(vsync1, "Minimum vertical frequency of monitor in Hz"
 		 " (default = 50)");

--Boundary-00=_wj/RCHO6QKARCL7--

