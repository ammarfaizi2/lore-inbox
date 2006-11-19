Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933056AbWKSTYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933056AbWKSTYT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 14:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933057AbWKSTYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 14:24:19 -0500
Received: from mx2.cs.washington.edu ([128.208.2.105]:53431 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S933056AbWKSTYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 14:24:18 -0500
Date: Sun, 19 Nov 2006 11:24:08 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Hiroshi Miura <miura@da-cha.org>,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] i386 cpufreq: cs5530A allows active idle
Message-ID: <Pine.LNX.4.64N.0611191121050.391@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cs5530A will be able to go into active idle (PWRSVE) so its PCI class 
revision should be accurately stored.

Cc: Hiroshi Miura <miura@da-cha.org>
Cc: Dave Jones <davej@codemonkey.org.uk>
Cc: Zwane Mwaikambo <zwane@commfireservices.com>
Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 arch/i386/kernel/cpu/cpufreq/gx-suspmod.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
