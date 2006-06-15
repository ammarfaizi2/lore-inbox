Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWFOMUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWFOMUn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWFOMUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:20:43 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:51730 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S1030307AbWFOMUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:20:42 -0400
Message-ID: <44915098.3070404@onelan.co.uk>
Date: Thu, 15 Jun 2006 13:20:40 +0100
From: Barry Scott <barry.scott@onelan.co.uk>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc6 does not boot on HP dc7600u - MCFG area is not E820-reserved
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to boot 2.6.17-rc6 with Mismatched section patches applied.

On my HP dc7600U the last messages printed are:

PCI: BUIS Bug: MCFG area is not E820-reserved
PCI: Not using MMCONFIG

Googling I found a message about a IBM laptop reporting this message
but that it did go on to boot. THere was a suggestion that the test 
should be
removed. I commented out the code and I can boot further.

Here is the code I patched.

--- arch/i386/pci/mmconfig.c~   2006-06-15 13:04:58.000000000 +0100
+++ arch/i386/pci/mmconfig.c    2006-06-15 13:04:58.000000000 +0100
@@ -194,17 +194,19 @@
        if ((pci_mmcfg_config_num == 0) ||
            (pci_mmcfg_config == NULL) ||
            (pci_mmcfg_config[0].base_address == 0))
                return;

+/* qqq
        if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
                        pci_mmcfg_config[0].base_address + 
MMCONFIG_APER_SIZE,
                        E820_RESERVED)) {
                printk(KERN_ERR "PCI: BIOS Bug: MCFG area is not 
E820-reserved\n");
                printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
                return;
        }
+qqq */

        printk(KERN_INFO "PCI: Using MMCONFIG\n");
        raw_pci_ops = &pci_mmcfg;
        pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;

Barry

