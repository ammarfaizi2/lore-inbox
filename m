Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTB0HRj>; Thu, 27 Feb 2003 02:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbTB0HRj>; Thu, 27 Feb 2003 02:17:39 -0500
Received: from coders.eu.org ([212.89.225.150]:61709 "HELO
	unreal.coders.eu.org") by vger.kernel.org with SMTP
	id <S261495AbTB0HRj>; Thu, 27 Feb 2003 02:17:39 -0500
Date: Thu, 27 Feb 2003 08:34:33 +0100
From: _N3X_ <n3x@coders.eu.org>
To: linux-kernel@vger.kernel.org
Subject: serial_cs with devfs
Message-ID: <20030227073433.GA20856@unreal.coders.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: cdrs-0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in serial_cs.c there is a hardcoded device name in the code, stating
ttySx, that's not the right thing with devfs..
here's a patch of my own (should work also on the latest prepatch),
just to show the problem, i think that the defines around it could be
more carefully chosen, but what's the deal.. have a nice day.
_N3X_ <n3x@coders.eu.org>

diff -ru linux-2.4.19/drivers/char/pcmcia/serial_cs.c linux-2.4.19-fix/drivers/char/pcmcia/serial_cs.c
--- linux-2.4.19/drivers/char/pcmcia/serial_cs.c	2001-12-21 18:41:54.000000000 +0100
+++ linux-2.4.19-fix/drivers/char/pcmcia/serial_cs.c	2002-11-06 10:14:07.000000000 +0100
@@ -256,7 +256,11 @@
     }
     
     info->line[info->ndev] = line;
+#ifdef CONFIG_DEVFS_FS
+    sprintf(info->node[info->ndev].dev_name, "tts/%d", line);
+#else
     sprintf(info->node[info->ndev].dev_name, "ttyS%d", line);
+#endif /* CONFIG_DEVFS_FS */
     info->node[info->ndev].major = TTY_MAJOR;
     info->node[info->ndev].minor = 0x40+line;
     if (info->ndev > 0)

