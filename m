Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267479AbTAQKSD>; Fri, 17 Jan 2003 05:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267480AbTAQKSC>; Fri, 17 Jan 2003 05:18:02 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:54471 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S267479AbTAQKSB>; Fri, 17 Jan 2003 05:18:01 -0500
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.59
References: <Pine.LNX.4.44.0301161826430.8879-100000@penguin.transmeta.com>
	<20030117095921.GW2333@fs.tum.de>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 17 Jan 2003 11:23:28 +0100
Message-ID: <wrpel7cxefz.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030117095921.GW2333@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Adrian" == Adrian Bunk <bunk@fs.tum.de> writes:

Adrian> On Thu, Jan 16, 2003 at 06:28:03PM -0800, Linus Torvalds wrote:
>> ...
>> o EISA sysfs updates to 3c509 and 3c59x drivers
>> ...

Adrian> This change browke the compilation of 3c509 with CONFIG_PM:

Can you try this patch (compiles, but otherwise untested) ?

Thanks,

        M.

===== drivers/net/3c509.c 1.30 vs edited =====
--- 1.30/drivers/net/3c509.c	Wed Jan 15 11:07:35 2003
+++ edited/drivers/net/3c509.c	Fri Jan 17 11:17:18 2003
@@ -319,16 +319,6 @@
 	dev->watchdog_timeo = TX_TIMEOUT;
 	dev->do_ioctl = netdev_ioctl;
 
-#ifdef CONFIG_PM
-	/* register power management */
-	lp->pmdev = pm_register(PM_ISA_DEV, card_idx, el3_pm_callback);
-	if (lp->pmdev) {
-		struct pm_dev *p;
-		p = lp->pmdev;
-		p->data = (struct net_device *)dev;
-	}
-#endif
-
 	return 0;
 }
 
@@ -597,6 +587,16 @@
 	lp->pnpdev = idev;
 #endif
 	lp->mca_slot = mca_slot;
+
+#ifdef CONFIG_PM
+	/* register power management */
+	lp->pmdev = pm_register(PM_ISA_DEV, card_idx, el3_pm_callback);
+	if (lp->pmdev) {
+		struct pm_dev *p;
+		p = lp->pmdev;
+		p->data = (struct net_device *)dev;
+	}
+#endif
 
 	return el3_common_init (dev);
 }

-- 
Places change, faces change. Life is so very strange.
