Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265684AbUHSLoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUHSLoT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 07:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265691AbUHSLoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 07:44:19 -0400
Received: from mail.tactel.se ([195.22.66.197]:45797 "EHLO mail.tactel.se")
	by vger.kernel.org with ESMTP id S265684AbUHSLoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 07:44:01 -0400
Subject: Re: 2.6.8.1-mm1 hangs on boot with ACPI
From: Pontus Fuchs <pontus.fuchs@tactel.se>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <1092898173.25911.224.camel@dhcppc4>
References: <566B962EB122634D86E6EE29E83DD808182C35CE@hdsmsx403.hd.intel.com>
	 <1092898173.25911.224.camel@dhcppc4>
Content-Type: text/plain
Message-Id: <1092915833.6089.11.camel@dhcp-225.mlm.tactel.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 19 Aug 2004 13:43:54 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-19 at 08:49, Len Brown wrote:
> On Tue, 2004-08-17 at 04:55, Pontus Fuchs wrote:
> > Hi,
> > 
> > After upgrading to 2.6.8.1-mm1 from plain 2.6.8.1 my machine does not
> > boot anymore. The last message i see is:
> > 
> > ACPI: Processor [CPU0] (supports C1,C2,C3, 8 throttling states)
> > 
> > In plain 2.6.8.1 the next messages would be:
> > 
> > ACPI: Thermal Zone [THRM] (52 C)
> > Console: switching to colour frame buffer device 175x65
> > Linux agpgart interface v0.100 (c) Dave Jones
> > agpgart: Detected SiS 648 chipset
> > 
> > Booting with acpi=off works fine. I have also tried pci=routeirq but
> > it
> > does not make any difference.
> > 
> > The machine is an Asus L5c laptop.
> 
> Please try booting with "pci=routeirq"
> If that doesn't work, please take stock 2.6.8.1 and apply the latest
> patch here:
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.8/
> and give it a go.
> 
> This will bring your kernel up to the same ACPI patch that is in the -mm
> tree, but without all the other stuff in the mm tree.
> 
> If it fails, then ACPI broke.  If it works, then something in -mm broke
> ACPI.

Hi,

I found this another Asus laptop with intel chipset which also has
problems with the latest ACPI code, and I tried the same trick on my
machine, and now the machine boots again! 

http://bugme.osdl.org/show_bug.cgi?id=3191

I have no clue what I'm actually doing so please don't consider the
patch a fix for the problem, but rather a way do show how to make the
symptom go away.

--- quirks.c.bak        2004-08-19 13:25:23.000000000 +0200
+++ quirks.c    2004-08-19 13:25:47.000000000 +0200
@@ -756,11 +756,13 @@
  */
 static void __init quirk_sis_96x_smbus(struct pci_dev *dev)
 {
+/*
	u8 val = 0;
	printk(KERN_INFO "Enabling SiS 96x SMBus.\n");
	pci_read_config_byte(dev, 0x77, &val);
	pci_write_config_byte(dev, 0x77, val & ~0x10);
	pci_read_config_byte(dev, 0x77, &val);
+*/
 }

Pontus


