Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTDFApC (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 19:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbTDFApB (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 19:45:01 -0500
Received: from relais.videotron.ca ([24.201.245.36]:36956 "EHLO
	VL-MS-MR001.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id S262742AbTDFApA (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 19:45:00 -0500
Date: Sat, 05 Apr 2003 19:56:31 -0500
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [PATCH]  Unresolved symbol compile error on non-PCI PC systems
To: linux-kernel@vger.kernel.org
Message-id: <3E8F7B3F.1040000@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_4BAxi19ZP6jb83+nzvYHog)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_4BAxi19ZP6jb83+nzvYHog)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Folks,

    in the file arch/i386/kernel/dmi_scan.c, there are two unresolved 
symbols when this file is compiled for a system without PCI support.

    The following patch fixes this.  Patch applies against 2.4.21-pre5-ac3.

    As I do not know for sure if there are other issues related with 
this patch, I would like that someone double-checks it.  There is also a 
possibility that this fix applies to the 2.5 kernel tree.

Regards,

Stephane Ouellette



--Boundary_(ID_4BAxi19ZP6jb83+nzvYHog)
Content-type: text/plain; name=dmi_scan.c.patch; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=dmi_scan.c.patch

--- linux-2.4.21-pre5-ac3/arch/i386/kernel/dmi_scan.c	Fri Apr  4 16:52:19 2003
+++ linux-2.4.21-pre5-ac3-fixed/arch/i386/kernel/dmi_scan.c	Sat Apr  5 12:12:48 2003
@@ -415,8 +415,10 @@
  */
  
 extern int skip_ioapic_setup;
+#ifdef CONFIG_PCI
 extern int broken_440gx_bios;
 extern unsigned int pci_probe;
+#endif
 static __init int broken_pirq(struct dmi_blacklist *d)
 {
 	printk(KERN_INFO " *** Possibly defective BIOS detected (irqtable)\n");
@@ -427,8 +429,10 @@
 #ifdef CONFIG_X86_IO_APIC
 	skip_ioapic_setup = 0;
 #endif
+#ifdef CONFIG_PCI
 	broken_440gx_bios = 1;
 	pci_probe |= PCI_BIOS_IRQ_SCAN;
+#endif
 	
 	return 0;
 }

--Boundary_(ID_4BAxi19ZP6jb83+nzvYHog)--
