Return-Path: <linux-kernel-owner+w=401wt.eu-S1755267AbXABFIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbXABFIX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 00:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755268AbXABFIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 00:08:23 -0500
Received: from outbound-mail-75.bluehost.com ([69.89.20.10]:41427 "HELO
	outbound-mail-75.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755267AbXABFIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 00:08:22 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 00:08:22 EST
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] quiet MMCONFIG related printks
Date: Mon, 1 Jan 2007 21:01:38 -0800
User-Agent: KMail/1.9.5
Cc: Arjan van de Ven <arjan@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701012101.38427.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 67.161.73.10 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using MMCONFIG for PCI config space access is simply an optimization, not
a requirement.  Therefore, when it can't be used, there's no need for
KERN_ERR level message.  This patch makes the message a KERN_INFO instead
to reduce some of the noise in a kernel boot with the 'quiet' option.
(Note that this has no effect on a normal boot, which is ridiculously
verbose these days.)

Signed-off-by:  Jesse Barnes <jbarnes@virtuousgeek.org>

Thanks,
Jesse

diff --git a/arch/i386/pci/mmconfig.c b/arch/i386/pci/mmconfig.c
index e2616a2..b95e7f3 100644
--- a/arch/i386/pci/mmconfig.c
+++ b/arch/i386/pci/mmconfig.c
@@ -210,9 +210,9 @@ void __init pci_mmcfg_init(int type)
 	if (type == 1 && !e820_all_mapped(pci_mmcfg_config[0].base_address,
 			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
 			E820_RESERVED)) {
-		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
+		printk(KERN_INFO "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
 				pci_mmcfg_config[0].base_address);
-		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
+		printk(KERN_INFO "PCI: Not using MMCONFIG.\n");
 		return;
 	}
 
