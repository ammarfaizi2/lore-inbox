Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751885AbWFWSWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbWFWSWj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWFWSWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:22:39 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:8608 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751885AbWFWSWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:22:39 -0400
Date: Fri, 23 Jun 2006 20:22:37 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Jean-Daniel Pauget <jd@disjunkt.com>, Chris Rankin <rankincj@yahoo.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>,
       bert hubert <bert.hubert@netherlabs.nl>, george@mvista.com
Subject: [PATCH -mm] clocksource: add PM Timer bug hunting notes
Message-ID: <20060623182237.GA19853@rhlx01.fht-esslingen.de>
References: <20060620100800.GB5040@disjunkt.com> <20060620101946.GA32658@rhlx01.fht-esslingen.de> <87zmg7q3gm.fsf@duaron.myhome.or.jp> <20060620151658.GA5230@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620151658.GA5230@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 05:16:58PM +0200, Andreas Mohr wrote:
> Hi,
> 
> On Tue, Jun 20, 2006 at 11:58:01PM +0900, OGAWA Hirofumi wrote:
> > Almost ICH4 should be sane.  Since there seems both reports of good
> > and bad, probably the bug of ICH4 seems to be depending on a specific
> > motherboard.
> > 
> > FWIW, If you want to reduce gray-list, probably it should be
> > motherboard list.
> 
> OK, so if I get a nice description of which dual P4 Xeon motherboard that
> was (Dell something?), then I'll make a patch adding
> this chipset's revision + motherboard + LKML link of bug test app
> to the file, and asking for more testers there, too.

Done, hope that's ok (fixed a typo in the process).

Jean-Daniel, Chris: please complain loudly if you don't want to have your name
in that file...

Compile-tested on 2.6.17-mm1.

Signed-off-by: Andreas Mohr <andi@lisas.de>


--- linux-2.6.17-mm1.orig/drivers/clocksource/acpi_pm.c	2006-06-21 14:28:16.000000000 +0200
+++ linux-2.6.17-mm1/drivers/clocksource/acpi_pm.c	2006-06-23 20:11:32.000000000 +0200
@@ -70,7 +70,7 @@
 	.rating		= 200,
 	.read		= acpi_pm_read,
 	.mask		= (cycle_t)ACPI_PM_MASK,
-	.mult		= 0, /*to be caluclated*/
+	.mult		= 0, /* to be calculated */
 	.shift		= 22,
 	.is_continuous	= 1,
 };
@@ -92,7 +92,8 @@
 }
 
 /*
- * PIIX4 Errata:
+ * PIIX4 Errata #20, Intel PDF 29773817:
+ * (affects PIIX4 A0/A1/B0 and PIIX4E A0, *fixed* in PIIX4M A0)
  *
  * The power management timer may return improper results when read.
  * Although the timer value settles properly after incrementing,
@@ -135,6 +136,20 @@
 	       " workaround\n");
 
 	acpi_pm_need_workaround();
+
+	/* If you happen to have such a chipset and want to help improve things,
+	   then please run OGAWA Hirofumi's test app at
+	   http://marc.theaimsgroup.com/?l=linux-kernel&m=114297656924494&w=2
+	   (run for a somewhat longer time to be sure)
+	   and report bug status of your chipset revision/motherboard.
+
+	   Devices that seem to work fine (run "lspci -n"):
+	   - Chris Rankin: 8086:24c0 (rev 01), Dell Precision 650 (dual P4 Xeon)
+	   - Jean-Daniel Pauget: 8086:24c0 (rev 02), ASUS P4PE (non-SMP)
+
+	   Possibly the 8086:24c0 device is completely fine with all revisions
+	   after all... (but not sure yet, which is why we need your input)
+	*/
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0,
 			acpi_pm_check_graylist);

-- 
No programming skills!? Why not help translate many Linux applications! 
https://launchpad.ubuntu.com/rosetta
(or alternatively buy nicely packaged Linux distros/OSS software to help
support Linux developers creating shiny new things for you?)
