Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265319AbUBAOfg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 09:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265320AbUBAOfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 09:35:36 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.135.30]:20236 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S265319AbUBAOe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 09:34:59 -0500
Date: Sun, 01 Feb 2004 23:35:44 +0900 (JST)
Message-Id: <20040201.233544.76262593.yoshfuji@linux-ipv6.org>
To: Philip.Blundell@pobox.com, tim@cyberelk.net, campbell@torque.net,
       andrea@e-mind.com
Cc: linux-parport@torque.net, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] PARPORT: C99 Initializers
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040201.225619.67854403.yoshfuji@linux-ipv6.org>
References: <20040201.224431.17604798.yoshfuji@linux-ipv6.org>
	<20040201.225619.67854403.yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040201.225619.67854403.yoshfuji@linux-ipv6.org> (at Sun, 01 Feb 2004 22:56:19 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:

> Please use this instead.

Hmm... take 3...
(I don't understand why I didn't get errors while compiling before...)

===== drivers/parport/procfs.c 1.2 vs edited =====
--- 1.2/drivers/parport/procfs.c	Tue Feb  5 16:37:25 2002
+++ edited/drivers/parport/procfs.c	Sun Feb  1 22:54:02 2004
@@ -232,12 +232,29 @@
 	return copy_to_user(result, buffer, len) ? -EFAULT : 0;
 }
 
-#define PARPORT_PORT_DIR(child) { 0, NULL, NULL, 0, 0555, child }
-#define PARPORT_PARPORT_DIR(child) { DEV_PARPORT, "parport", \
-                                     NULL, 0, 0555, child }
-#define PARPORT_DEV_DIR(child) { CTL_DEV, "dev", NULL, 0, 0555, child }
-#define PARPORT_DEVICES_ROOT_DIR  { DEV_PARPORT_DEVICES, "devices", \
-                                    NULL, 0, 0555, NULL }
+#define PARPORT_PORT_DIR(child) {	\
+	.mode		=	0555,	\
+	.child		=	child,	\
+}
+
+#define PARPORT_PARPORT_DIR(child) {		\
+	.ctl_name	=	DEV_PARPORT,	\
+	.procname	=	"parport",	\
+	.mode		=	0555,		\
+	.child		=	child,		\
+}
+
+#define PARPORT_DEV_DIR(child) {		\
+	.ctl_name	=	CTL_DEV,	\
+	.procname	=	"dev",		\
+	.mode		=	0555, 		\
+	.child		=	child,		\
+}
+
+#define PARPORT_DEVICES_ROOT_DIR  {			\
+	.ctl_name	=	DEV_PARPORT_DEVICES,	\
+	.procname	=	"devices",		\
+}
 
 static const unsigned long parport_min_timeslice_value =
 PARPORT_MIN_TIMESLICE_VALUE;
@@ -264,48 +281,105 @@
 static const struct parport_sysctl_table parport_sysctl_template = {
 	NULL,
         {
-		{ DEV_PARPORT_SPINTIME, "spintime",
-		  NULL, sizeof(int), 0644, NULL,
-		  &proc_dointvec_minmax, NULL, NULL,
-		  (void*) &parport_min_spintime_value,
-		  (void*) &parport_max_spintime_value },
-		{ DEV_PARPORT_BASE_ADDR, "base-addr",
-		  NULL, 0, 0444, NULL,
-		  &do_hardware_base_addr },
-		{ DEV_PARPORT_IRQ, "irq",
-		  NULL, 0, 0444, NULL,
-		  &do_hardware_irq },
-		{ DEV_PARPORT_DMA, "dma",
-		  NULL, 0, 0444, NULL,
-		  &do_hardware_dma },
-		{ DEV_PARPORT_MODES, "modes",
-		  NULL, 0, 0444, NULL,
-		  &do_hardware_modes },
+		{ 
+			.ctl_name	=	DEV_PARPORT_SPINTIME, 
+			.procname	=	"spintime",
+			.maxlen		=	sizeof(int), 
+			.mode		=	0644,
+		  	.proc_handler	=	&proc_dointvec_minmax, 
+			.extra1		=	(void *) &parport_min_spintime_value,
+		  	.extra2		=	(void *) &parport_max_spintime_value,
+		},
+		{ 
+			.ctl_name	=	DEV_PARPORT_BASE_ADDR, 
+			.procname	=	"base-addr",
+			.mode		=	0444,
+		  	.proc_handler	=	&do_hardware_base_addr,
+		},
+		{ 
+			.ctl_name	=	DEV_PARPORT_IRQ, 
+			.procname	=	"irq",
+			.mode		=	0444,
+			.proc_handler	=	&do_hardware_irq,
+		},
+		{
+			.ctl_name	=	DEV_PARPORT_DMA,
+			.procname	=	"dma",
+			.mode		=	0444,
+			.proc_handler	=	&do_hardware_dma,
+		},
+		{
+			.ctl_name	=	DEV_PARPORT_MODES, 
+			.procname	=	"modes",
+			.mode		=	0444,
+			.proc_handler	=	&do_hardware_modes,
+		},
 		PARPORT_DEVICES_ROOT_DIR,
 #ifdef CONFIG_PARPORT_1284
-		{ DEV_PARPORT_AUTOPROBE, "autoprobe",
-		  NULL, 0, 0444, NULL,
-		  &do_autoprobe },
-		{ DEV_PARPORT_AUTOPROBE + 1, "autoprobe0",
-		 NULL, 0, 0444, NULL,
-		 &do_autoprobe },
-		{ DEV_PARPORT_AUTOPROBE + 2, "autoprobe1",
-		  NULL, 0, 0444, NULL,
-		  &do_autoprobe },
-		{ DEV_PARPORT_AUTOPROBE + 3, "autoprobe2",
-		  NULL, 0, 0444, NULL,
-		  &do_autoprobe },
-		{ DEV_PARPORT_AUTOPROBE + 4, "autoprobe3",
-		  NULL, 0, 0444, NULL,
-		  &do_autoprobe },
+		{
+			.ctl_name	=	DEV_PARPORT_AUTOPROBE, 
+			.procname	=	"autoprobe",
+			.mode		=	0444,
+			.proc_handler	=	&do_autoprobe,
+		},
+		{
+			.ctl_name	=	DEV_PARPORT_AUTOPROBE + 1, 
+			.procname	=	"autoprobe0",
+			.mode		=	0444,
+			.proc_handler	=	&do_autoprobe,
+		},
+		{
+			.ctl_name	=	DEV_PARPORT_AUTOPROBE + 2, 
+			.procname	=	"autoprobe1",
+			.mode		=	0444,
+			.proc_handler	=	&do_autoprobe,
+		},
+		{ 
+			.ctl_name	=	DEV_PARPORT_AUTOPROBE + 3, 
+			.procname	=	"autoprobe2",
+			.mode		=	0444,
+			.proc_handler	=	&do_autoprobe,
+		},
+		{
+			.ctl_name	=	DEV_PARPORT_AUTOPROBE + 4, 
+			.procname	=	"autoprobe3",
+			.mode		=	0444,
+			.proc_handler	=	&do_autoprobe,
+		},
 #endif /* IEEE 1284 support */
-		{0}
+		{
+			.ctl_name	=	0,	/* sentinel */
+		}
 	},
-	{ {DEV_PARPORT_DEVICES_ACTIVE, "active", NULL, 0, 0444, NULL,
-	  &do_active_device }, {0}},
-	{ PARPORT_PORT_DIR(NULL), {0}},
-	{ PARPORT_PARPORT_DIR(NULL), {0}},
-	{ PARPORT_DEV_DIR(NULL), {0}}
+	{
+		{
+			.ctl_name	=	DEV_PARPORT_DEVICES_ACTIVE, 
+			.procname	=	"active", 
+			.mode		=	0444,
+			.proc_handler	=	&do_active_device,
+		},
+		{
+			.ctl_name	=	0,	/* sentinel */
+		}
+	},
+	{
+		PARPORT_PORT_DIR(NULL),
+		{
+			.ctl_name	=	0,	/* sentinel */
+		}
+	},
+	{
+		PARPORT_PARPORT_DIR(NULL),
+		{
+			.ctl_name	=	0,	/* sentinel */
+		}
+	},
+	{
+		PARPORT_DEV_DIR(NULL),
+		{
+			.ctl_name	=	0,	/* sentinel */
+		}
+	}
 };
 
 struct parport_device_sysctl_table
@@ -323,17 +397,51 @@
 parport_device_sysctl_template = {
 	NULL,
 	{
-		{ DEV_PARPORT_DEVICE_TIMESLICE, "timeslice",
-		  NULL, sizeof(int), 0644, NULL,
-		  &proc_doulongvec_ms_jiffies_minmax, NULL, NULL,
-		  (void*) &parport_min_timeslice_value,
-		  (void*) &parport_max_timeslice_value },
-	},
-	{ {0, NULL, NULL, 0, 0555, NULL}, {0}},
-	{ PARPORT_DEVICES_ROOT_DIR, {0}},
-	{ PARPORT_PORT_DIR(NULL), {0}},
-	{ PARPORT_PARPORT_DIR(NULL), {0}},
-	{ PARPORT_DEV_DIR(NULL), {0}}
+		{
+			.ctl_name	=	DEV_PARPORT_DEVICE_TIMESLICE, 
+			.procname	=	"timeslice",
+			.maxlen		=	sizeof(int), 
+			.mode		=	0644, 
+			.proc_handler	=	&proc_doulongvec_ms_jiffies_minmax,
+			.extra1		=	(void *) &parport_min_timeslice_value,
+			.extra2		=	(void *) &parport_max_timeslice_value
+		},
+		{
+			ctl_name	=	0,	/* sentinel */
+		}
+	},
+	{
+		{
+			.mode		=	0555,
+		},
+		{
+			.ctl_name	=	0,	/* sentinel */
+		}
+	},
+	{
+		PARPORT_DEVICES_ROOT_DIR, 
+		{
+			.ctl_name	=	0,	/* sentinel */
+		}
+	},
+	{
+		PARPORT_PORT_DIR(NULL), 
+		{
+			.ctl_name	=	0,	/* sentinel */
+		}
+	},
+	{
+		PARPORT_PARPORT_DIR(NULL), 
+		{
+			.ctl_name	=	0,	/* sentinel */
+		}
+	},
+	{
+		PARPORT_DEV_DIR(NULL),
+		{
+			.ctl_name	=	0,	/* sentinel */
+		}
+	}
 };
 
 struct parport_default_sysctl_table
@@ -352,26 +460,53 @@
 parport_default_sysctl_table = {
 	NULL,
 	{
-		{ DEV_PARPORT_DEFAULT_TIMESLICE, "timeslice",
-		  &parport_default_timeslice,
-		  sizeof(parport_default_timeslice), 0644, NULL,
-		  &proc_doulongvec_ms_jiffies_minmax, NULL, NULL,
-		  (void*) &parport_min_timeslice_value,
-		  (void*) &parport_max_timeslice_value },
-		{ DEV_PARPORT_DEFAULT_SPINTIME, "spintime",
-		  &parport_default_spintime,
-		  sizeof(parport_default_spintime), 0644, NULL,
-		  &proc_dointvec_minmax, NULL, NULL,
-		  (void*) &parport_min_spintime_value,
-		  (void*) &parport_max_spintime_value },
-		{0}
-	},
-	{ { DEV_PARPORT_DEFAULT, "default", NULL, 0, 0555,
-	    parport_default_sysctl_table.vars },{0}},
-	{
-	PARPORT_PARPORT_DIR(parport_default_sysctl_table.default_dir), 
-	{0}},
-	{ PARPORT_DEV_DIR(parport_default_sysctl_table.parport_dir), {0}}
+		{
+			.ctl_name	=	DEV_PARPORT_DEFAULT_TIMESLICE, 
+			.procname	=	"timeslice",
+			.data		-	&parport_default_timeslice,
+			.maxlen		=	sizeof(parport_default_timeslice), 
+			.mode		=	0644, 
+			.proc_handler	=	&proc_doulongvec_ms_jiffies_minmax,
+			.extra1		=	(void *) &parport_min_timeslice_value,
+			.extra2		=	(void *) &parport_max_timeslice_value,
+		},
+		{
+			.ctl_name	=	DEV_PARPORT_DEFAULT_SPINTIME, 
+			.procname	=	"spintime", 
+			.data		=	&parport_default_spintime, 
+			.maxlen		=	sizeof(parport_default_spintime), 
+			.mode		=	0644, 
+			.proc_handler	=	&proc_dointvec_minmax, 
+			.extra1		=	(void *) &parport_min_spintime_value, 
+			.extra2		=	(void *) &parport_max_spintime_value,
+		},
+		{
+			.ctl_name	=	0,	/* sentinel */
+		}
+	},
+	{
+		{
+			.ctl_name	=	DEV_PARPORT_DEFAULT, 
+			.procname	=	"default", 
+			.mode		=	0555,
+			.proc_handler	=	parport_default_sysctl_table.vars,
+		},
+		{
+			.ctl_name	=	0,	/* sentinel */
+		}
+	},
+	{
+		PARPORT_PARPORT_DIR(parport_default_sysctl_table.default_dir), 
+		{
+			.ctl_name	=	0,	/* sentinel */
+		}
+	},
+	{
+		PARPORT_DEV_DIR(parport_default_sysctl_table.parport_dir), 
+		{
+			.ctl_name	=	0,	/* sentinel */
+		}
+	}
 };
 
 


-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
