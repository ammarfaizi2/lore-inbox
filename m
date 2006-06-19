Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWFSBFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWFSBFv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWFSBFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:05:51 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:64669 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932161AbWFSBFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:05:50 -0400
Date: Sun, 18 Jun 2006 21:05:45 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/8] Improve MSI detection v2
Message-ID: <20060619010544.GA29950@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 0/8] Improve MSI detection v2

After my proposal to whitelist chipsets supporting MSI a couple days ago,
here's a patchset implementing what seemed to better suit what people replied.
We enable MSI by default on PCI-E and disable on non-PCI-E chipsets.

#1 - Rename PCI_CAP_ID_HT_IRQCONF to PCI_CAP_ID_HT
#2 - Factorize common MSI detection code from pci_enable_msi() and msix()
#3 - Blacklist PCI-E chipsets depending on Hypertransport MSI capabality
#4 - Stop inheriting bus flags and check root chipset bus flags instead
#5 - Whitelist Intel PCI chipsets that are known to support MSI
#6 - Disable MSI by default on non PCI-E chipsets
#7 - Drop existing quirks that disable MSI on some non PCI-E chipsets
#8 - Drop pci_msi_quirk

#1 to #4 are simple and could make it to 2.6.18 easily.
#6 might need the list of whitelisted chipsets to be improved to avoid
regressions (nVidia chipsets for Intel processors?).
#5 is useless without #6.
#7 and #8 are mainly cosmetic (remove obsolete stuff when the new model
is in place).

These patches are against 2.6.17-rc6-mm2.

I did not keep the option "pci=forcemsi" since it makes less sense than
in my previous RFC. But I'd be happy to reimplement it, or even something
at the device granularity.

Brice Goglin
