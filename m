Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318779AbSG0QAI>; Sat, 27 Jul 2002 12:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318778AbSG0QAI>; Sat, 27 Jul 2002 12:00:08 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:20646 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S318779AbSG0QAH>;
	Sat, 27 Jul 2002 12:00:07 -0400
Date: Sat, 27 Jul 2002 18:03:25 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: sisfb driver irq fixups
Message-ID: <20020727160325.GA29221@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Already sent to Thomas,

--- sis_main.c~	Thu Jul  4 17:58:26 2002
+++ sis_main.c	Sat Jul 27 17:40:48 2002
@@ -651,6 +651,7 @@
 	struct fb_fix_screeninfo fix;
 	struct display *display;
 	struct display_switch *sw;
+	static spinlock_t driver_lock = SPIN_LOCK_UNLOCKED;
 	long flags;
 
 	if (con >= 0)
@@ -674,7 +675,7 @@
 	display->inverse = sisfb_inverse;
 	display->var = *var;
 
-	save_flags(flags);
+	spin_lock_irqsave(&driver_lock, flags);
 	switch (ivideo.video_bpp) {
 #ifdef FBCON_HAS_CFB8
 	   case 8:
@@ -706,7 +707,7 @@
 	}
 	memcpy(&sisfb_sw, sw, sizeof(*sw));
 	display->dispsw = &sisfb_sw;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&driver_lock, flags);
 
 	display->scrollmode = SCROLL_YREDRAW;
 	sisfb_sw.bmove = fbcon_redraw_bmove;


-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
