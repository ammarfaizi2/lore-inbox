Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTJNXZS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 19:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbTJNXZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 19:25:18 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:19135 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S261592AbTJNXZN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 19:25:13 -0400
Date: Tue, 14 Oct 2003 16:25:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
Message-ID: <20031014232511.GA17741@ip68-0-152-218.tc.ph.cox.net>
References: <20031014185305.GB16614@ip68-0-152-218.tc.ph.cox.net> <Pine.GSO.4.44.0310142257010.28944-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310142257010.28944-100000@math.ut.ee>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 10:58:05PM +0300, Meelis Roos wrote:
> > > This is Motorola Poserstack Pro4000 (UtahII), it has no residual data,
> > > at least the messages say so.
> >
> > Does that machine have openfirmware by chance?
> 
> Yes, OF is present.

Ah-ha!

> I will be away and can access this computer only on next Monday again.

Can you apply the following patch (2.6)?  I'm expecting it to print out that
it hard-codes to 32mb.

===== arch/ppc/boot/prep/misc.c 1.18 vs edited =====
--- 1.18/arch/ppc/boot/prep/misc.c	Tue Jan  7 13:25:58 2003
+++ edited/arch/ppc/boot/prep/misc.c	Tue Oct 14 16:23:55 2003
@@ -224,14 +224,18 @@
 	if (((pci_viddid & 0xffff) == PCI_VENDOR_ID_MOTOROLA)
 			&& ((pci_did == PCI_DEVICE_ID_MOTOROLA_MPC105)
 				|| (pci_did == PCI_DEVICE_ID_MOTOROLA_MPC106)
-				|| (pci_did == PCI_DEVICE_ID_MOTOROLA_MPC107)))
+				|| (pci_did == PCI_DEVICE_ID_MOTOROLA_MPC107))) {
+		puts("Probing for memory\n");	
 		TotalMemory = get_mem_size();
 	/* If it's not, see if we have anything in the residual data. */
-	else if (residual && residual->TotalMemory)
+	} else if (residual && residual->TotalMemory) {
+		puts("Residual? Shouldn't!\n");
 		TotalMemory = residual->TotalMemory;
 	/* Fall back to hard-coding 32MB. */
-	else
+	} else {
+		puts("Hard-coded\n");
 		TotalMemory = 32*1024*1024;
+	}
 
 
 	/* assume the chunk below 8M is free */

Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
