Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268505AbUIXGjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268505AbUIXGjr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268496AbUIXGhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:37:36 -0400
Received: from fmr03.intel.com ([143.183.121.5]:10710 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S267880AbUIXGeL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:34:11 -0400
Date: Thu, 23 Sep 2004 23:34:10 -0700
From: Suresh Siddha <suresh.b.siddha@intel.com>
To: linux-kernel@vger.kernel.org
Cc: asit.k.mallick@intel.com
Subject: [Patch 0/2] Disable SW irqbalance/irqaffinity for E7520/E7320/E7525
Message-ID: <20040923233410.A19555@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the workaround for the "Interrupt message re-ordering across
hub interface" errata (page #16 in
http://developer.intel.com/design/chipsets/specupdt/30288402.pdf),
BIOS may enable hardware IRQ balancing for Lindenhurst/Tumwater based chipset
platforms. Software based irq_balance/irq_affinity should be disabled if
hardware IRQ balancing is enabled.

This is applicable for chipsets with PCI id's

E7520, 0x3590
E7320, 0x3592
E7525, 0x359E

and with revision ID 0x09 and below.

Patch is broken into two parts.

1/2 - Set TARGET_CPUS on x86_64 to cpu_online_map. This brings the code inline
with x86 mach-default
2/2 - Add pci quirks to disable irq_balance/affinity based on the above
information and make sure destination cpus in IO-APIC redirection table
entries are set to cpu_online_map

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
