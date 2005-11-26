Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVKZVSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVKZVSA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 16:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVKZVSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 16:18:00 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:41333 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750752AbVKZVR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 16:17:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: mousedev parametes not visible in /sys
Date: Sat, 26 Nov 2005 16:17:56 -0500
User-Agent: KMail/1.8.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0511262102390.17231@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0511262102390.17231@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511261617.57597.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 November 2005 15:08, Jan Engelhardt wrote:
> Hello,
> 
> 
> linux-2.6.13/drivers/input/mousedev.c has some module_params, but they do 
> not show up in /sys, i.e. there is no /sys/modules/mousedev directory at 
> all. Even though it is a compiled-in 'module', I do know that even 
> compiled-ins can get a directory under /sys/modules/, as is the case with 
> a module_param in e.g. drivers/char/vt.c which shows as /sys/modules/vt.
> 
> Can anybody confirm this or know what's wrong?
>

Hi Jan,

They have 0 permission so corresponding attributes are not created.
Something like the patch below shoudl fix that. 

-- 
Dmitry

Input: mousedev - make module parameters visible in sysfs

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mousedev.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: work/drivers/input/mousedev.c
===================================================================
--- work.orig/drivers/input/mousedev.c
+++ work/drivers/input/mousedev.c
@@ -40,15 +40,15 @@ MODULE_LICENSE("GPL");
 #endif
 
 static int xres = CONFIG_INPUT_MOUSEDEV_SCREEN_X;
-module_param(xres, uint, 0);
+module_param(xres, uint, 0644);
 MODULE_PARM_DESC(xres, "Horizontal screen resolution");
 
 static int yres = CONFIG_INPUT_MOUSEDEV_SCREEN_Y;
-module_param(yres, uint, 0);
+module_param(yres, uint, 0644);
 MODULE_PARM_DESC(yres, "Vertical screen resolution");
 
 static unsigned tap_time = 200;
-module_param(tap_time, uint, 0);
+module_param(tap_time, uint, 0644);
 MODULE_PARM_DESC(tap_time, "Tap time for touchpads in absolute mode (msecs)");
 
 struct mousedev_hw_data {
