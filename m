Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbUACR3h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 12:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbUACR3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 12:29:37 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:36511 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263598AbUACR3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 12:29:32 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 3/7] psmouse option parsing
Date: Sat, 3 Jan 2004 12:29:23 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200401030350.43437.dtor_core@ameritech.net> <200401030400.55755.dtor_core@ameritech.net> <20040103100739.GB499@ucw.cz>
In-Reply-To: <20040103100739.GB499@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401031229.25315.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 January 2004 05:07 am, Vojtech Pavlik wrote:
> On Sat, Jan 03, 2004 at 04:00:54AM -0500, Dmitry Torokhov wrote:
> > +			[HW,MOUSE] Controls Logitech smartscroll autoreteat,
> > +			0 = disabled, 1 = enabled (default).
>
> Ha, a typo. :)

Darn! :)

Sorry about that. I uploaded hand-corrected patch to 

http://www.geocities.co/dt_or/input/2_6_0-rc1/ 

and also sending it here for your reference.

Dmitry

===================================================================


ChangeSet@1.1573, 2004-01-02 03:02:35-05:00, dtor_core@ameritech.net
  Input: With Vojtech's approval adjusted psmouse option names by
         dropping psmouse_ prefix.
  
         If psmouse is compiled as a module new option names are:
         proto, rate, resetafter, resolution, smartscroll
  
         If psmouse is built in the kernel the prefix "psmouse." is
         required in front of an option, like "psmouse.proto"

         Also, since we are changing all names, killed psmouse_noext
         completely

 Documentation/kernel-parameters.txt |   12 +++++++++---
 drivers/input/mouse/psmouse-base.c  |   30 ++++++++++--------------------
 2 files changed, 19 insertions(+), 23 deletions(-)


===================================================================



diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	Sat Jan  3 03:08:40 2004
+++ b/Documentation/kernel-parameters.txt	Sat Jan  3 03:08:40 2004
@@ -797,12 +797,18 @@
 			before loading.
 			See Documentation/ramdisk.txt.
 
-	psmouse_proto=  [HW,MOUSE] Highest PS2 mouse protocol extension to
+	psmouse.proto=  [HW,MOUSE] Highest PS2 mouse protocol extension to
 			probe for (bare|imps|exps).
-
-	psmouse_resetafter=
+	psmouse.rate=	[HW,MOUSE] Set desired mouse report rate, in reports
+			per second.
+	psmouse.resetafter=
 			[HW,MOUSE] Try to reset Synaptics Touchpad after so many
 			bad packets (0 = never).
+	psmouse.resolution=
+			[HW,MOUSE] Set desired mouse resolution, in dpi.
+	psmouse.smartscroll=
+			[HW,MOUSE] Controls Logitech smartscroll autorepeat,
+			0 = disabled, 1 = enabled (default). 
 
 	pss=		[HW,OSS] Personal Sound System (ECHO ESC614)
 			Format: <io>,<mss_io>,<mss_irq>,<mss_dma>,<mpu_io>,<mpu_irq>
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Sat Jan  3 03:08:40 2004
+++ b/drivers/input/mouse/psmouse-base.c	Sat Jan  3 03:08:40 2004
@@ -35,30 +35,26 @@
 MODULE_DESCRIPTION("PS/2 mouse driver");
 MODULE_LICENSE("GPL");
 
-static int psmouse_noext;
-module_param(psmouse_noext, int, 0);
-MODULE_PARM_DESC(psmouse_noext, "[DEPRECATED] Disable any protocol extensions. Useful for KVM switches.");
-
 static char *psmouse_proto;
 static unsigned int psmouse_max_proto = -1U;
-module_param(psmouse_proto, charp, 0);
-MODULE_PARM_DESC(psmouse_proto, "Highest protocol extension to probe (bare, imps, exps). Useful for KVM switches.");
+module_param_named(proto, psmouse_proto, charp, 0);
+MODULE_PARM_DESC(proto, "Highest protocol extension to probe (bare, imps, exps). Useful for KVM switches.");
 
 int psmouse_resolution = 200;
-module_param(psmouse_resolution, uint, 0);
-MODULE_PARM_DESC(psmouse_resolution, "Resolution, in dpi.");
+module_param_named(resolution, psmouse_resolution, uint, 0);
+MODULE_PARM_DESC(resolution, "Resolution, in dpi.");
 
 unsigned int psmouse_rate = 100;
-module_param(psmouse_rate, uint, 0);
-MODULE_PARM_DESC(psmouse_rate, "Report rate, in reports per second.");
+module_param_named(rate, psmouse_rate, uint, 0);
+MODULE_PARM_DESC(rate, "Report rate, in reports per second.");
 
 int psmouse_smartscroll = 1;
-module_param(psmouse_smartscroll, bool, 0);
-MODULE_PARM_DESC(psmouse_smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
+module_param_named(smartscroll, psmouse_smartscroll, bool, 0);
+MODULE_PARM_DESC(smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
 
 unsigned int psmouse_resetafter;
-module_param(psmouse_resetafter, uint, 0);
-MODULE_PARM_DESC(psmouse_resetafter, "Reset Synaptics Touchpad after so many bad packets (0 = never).");
+module_param_named(resetafter, psmouse_resetafter, uint, 0);
+MODULE_PARM_DESC(resetafter, "Reset Synaptics Touchpad after so many bad packets (0 = never).");
 
 static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};
 
@@ -674,12 +670,6 @@
 
 static inline void psmouse_parse_proto(void)
 {
-	if (psmouse_noext) {
-		printk(KERN_WARNING "psmouse: 'psmouse_noext' option is deprecated, please use 'psmouse_proto'\n");
-		psmouse_max_proto = PSMOUSE_PS2;
-	}
-
-	/* even is psmouse_noext is present psmouse_proto overrides it */
 	if (psmouse_proto) {
 		if (!strcmp(psmouse_proto, "bare"))
 			psmouse_max_proto = PSMOUSE_PS2;
