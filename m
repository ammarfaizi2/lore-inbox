Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318867AbSHEUOX>; Mon, 5 Aug 2002 16:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318868AbSHEUOX>; Mon, 5 Aug 2002 16:14:23 -0400
Received: from h-64-105-137-168.SNVACAID.covad.net ([64.105.137.168]:61636
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318867AbSHEUOT>; Mon, 5 Aug 2002 16:14:19 -0400
Date: Mon, 5 Aug 2002 13:17:40 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: mporter@mvista.com
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.30/arch/arm/mach-iop310/iq80310-pci.c BUG_ON(cond1 || cond2) separation
Message-ID: <20020805131740.A2433@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	I want to replace all statements in the kernel of the form
BUG_ON(condition1 || condition2) with:

			BUG_ON(condition1);
			BUG_ON(condition2);

	I was recently bitten by a very sporadic BUG_ON(cond1 || cond2)
statement and was quite annoyed at the greatly reduced opportunity to
debug the problem.  Make these changes and someone who experiences
the problem may be able to provide slightly more useful information.

	There are only three other places in the kernel besides the
bug I tripped (Matt Dharm and Greg Kroah-Hartmann have already accepted
the patch that I submitted for that one, in drivers/usb/storage).  They
are:

	2 in arch/arm/mach-iop310/iq80310-pci.c
	12 in fs/ntfs/
	23 in fs/partitions/ldm.c

	Here is the patch for linux-2.5.30/arch/arm/mach-iop310/iq80310-pci.c.

	Please let me know if you are going to shepherd this patch to
Linus's linux-2.5 tree, if you want me to submit it to Linus or
someone else, or if there is some other way you'd like me to proceed.

	Thanks for your work on Linux on ARM.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="arm.diff"

--- linux-2.5.30/arch/arm/mach-iop310/iq80310-pci.c	2002-08-01 14:16:18.000000000 -0700
+++ linux/arch/arm/mach-iop310/iq80310-pci.c	2002-08-05 12:44:20.000000000 -0700
@@ -65,7 +65,8 @@
 {
 	irq_table *pci_irq_table;
 
-	BUG_ON(pin < 1 || pin > 4);
+	BUG_ON(pin < 1);
+	BUG_ON(pin > 4);
 
 	if (!system_rev) {
 		pci_irq_table = pci_pri_d_irq_table;
@@ -102,7 +103,8 @@
 {
 	irq_table *pci_irq_table;
 
-	BUG_ON(pin < 1 || pin > 4);
+	BUG_ON(pin < 1);
+	BUG_ON(pin > 4);
 
 	if (!system_rev) {
 		pci_irq_table = pci_sec_d_irq_table;

--PNTmBPCT7hxwcZjr--
