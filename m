Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWGCAwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWGCAwX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWGCAuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:50:23 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:21724 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750775AbWGCAuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:50:20 -0400
Message-Id: <20060703003959.942374000@myri.com>
User-Agent: quilt/0.45-1
Date: Sun, 02 Jul 2006 20:39:59 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: [patch 0/7] Improve MSI detection v5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another set of patches to cleanup MSI detection to
replace the patchset that is currently in Greg's tree.

After -mm5 breakage due to some root chipsets not having a
subordinate bus, we now use the dev->no_msi flag to disable
MSI on a chipset instead of the subordinate bus flag (see #3).

Other changes include a TTL in the pci_find_next_capability()
loop to find MSI HT cap (see #5), and changing the ipath driver
to use the common PCI_CAP_ID_HT (see #4).

#1 - Merge existing MSI disabling quirks
#2 - Factorize common MSI detection code from pci_enable_msi() and msix()
#3 - Check root chipset no_msi flag instead of all parent busses flags
#4 - Rename PCI_CAP_ID_HT_IRQCONF into PCI_CAP_ID_HT
#5 - Blacklist PCI-E chipsets depending on Hypertransport MSI capability
#6 - Drop pci_msi_quirk
#7 - Drop pci bus_flags

These patches are against 2.6.17-git20.

Brice Goglin

