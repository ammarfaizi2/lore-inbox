Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751715AbWFVGzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbWFVGzo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 02:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbWFVGzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 02:55:44 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:24040 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S1751714AbWFVGzo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 02:55:44 -0400
Date: Wed, 21 Jun 2006 23:55:40 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: Brice Goglin <brice@myri.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] Blacklist PCI-E chipsets depending on Hypertransport
 MSI capabality
In-Reply-To: <fa.MhIWHiMWLnkJKB6OhkoEpGfTlNM@ifi.uio.no>
Message-ID: <Pine.LNX.4.61.0606212352480.32220@osa.unixfolk.com>
References: <fa.P1G6z6CZQKxLrmseicFSuE3LBWc@ifi.uio.no>
 <fa.MhIWHiMWLnkJKB6OhkoEpGfTlNM@ifi.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Brice Goglin wrote:

| [PATCH 3/6] Blacklist PCI-E chipsets depending on Hypertransport MSI capabality
| 
| Introduce msi_ht_cap_enabled() to check the MSI capability in the
| Hypertransport configuration space.
| It is used in a generic quirk quirk_msi_ht_cap() to check whether
| MSI is enabled on hypertransport chipset, and a nVidia specific quirk
| quirk_nvidia_ck804_msi_ht_cap() where two 2 HT MSI mappings have to
| be checked.
| Both quirks set the PCI_BUS_FLAGS_NO_MSI flags when MSI is disabled.
...
| Index: linux-mm/drivers/pci/quirks.c

| +/* Returns 1 if the HT MSI capability is found and enabled */
| +static pci_bus_flags_t __devinit msi_ht_cap_enabled(struct pci_dev *dev)
| +{
| +
| +	/* go through all caps looking for a hypertransport msi mapping */
| +	while (pci_read_config_byte(dev, cap_off + 1, &cap_off) == 0 &&

Perhaps this could be modified to use pci_find_capability() and pci_find_next_capability(),
rather than writing your own code to do it?

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
