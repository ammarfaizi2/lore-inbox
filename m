Return-Path: <linux-kernel-owner+w=401wt.eu-S1760739AbWLHOUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760739AbWLHOUW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 09:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760741AbWLHOUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 09:20:22 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:41878 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760739AbWLHOUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 09:20:21 -0500
X-Originating-Ip: 74.109.98.100
Date: Fri, 8 Dec 2006 09:15:45 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq : Change logical compare to bitwise compare.
Message-ID: <Pine.LNX.4.64.0612080449220.30237@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Change a logical comparison to the proper bitwise comparison.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

diff --git a/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c b/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c
index 92afa3b..0b9cc8a 100644
--- a/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c
+++ b/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c
@@ -473,7 +473,7 @@ static int __init cpufreq_gx_init(void)
 	pci_read_config_byte(params->cs55x0, PCI_MODON, &(params->on_duration));
 	pci_read_config_byte(params->cs55x0, PCI_MODOFF, &(params->off_duration));
         pci_read_config_dword(params->cs55x0, PCI_CLASS_REVISION, &class_rev);
-	params->pci_rev = class_rev && 0xff;
+	params->pci_rev = class_rev & 0xff;

 	if ((ret = cpufreq_register_driver(&gx_suspmod_driver))) {
 		kfree(params);

