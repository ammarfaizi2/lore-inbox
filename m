Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpBRseqEiBirTT4yND6YVML0eOQ==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 09:18:04 +0000
Message-ID: <00d401c415a4$146c53c0$d100000a@sbs2003.local>
From: "Dmitry Torokhov" <dtor_core@ameritech.net>
X-Mailer: Microsoft CDO for Exchange 2000
To: <Administrator@osdl.org>
Subject: Re: [PATCH 3/7] psmouse option parsing
Date: Mon, 29 Mar 2004 16:39:53 +0100
User-Agent: KMail/1.5.4
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Content-Class: urn:content-classes:message
References: <200401030350.43437.dtor_core@ameritech.net> <200401030356.48071.dtor_core@ameritech.net> <200401030357.44852.dtor_core@ameritech.net>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
In-Reply-To: <200401030357.44852.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:53.0906 (UTC) FILETIME=[14AF2920:01C415A4]

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
+			[HW,MOUSE] Controls Logitech smartscroll autoreteat,
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
