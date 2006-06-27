Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWF0Avt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWF0Avt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 20:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWF0Avs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 20:51:48 -0400
Received: from mga06.intel.com ([134.134.136.21]:48020 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030300AbWF0Avr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 20:51:47 -0400
X-IronPort-AV: i="4.06,178,1149490800"; 
   d="scan'208"; a="57046541:sNHT37410429"
Message-Id: <20060627004556.809330000@rshah1-sfield.jf.intel.com>
Date: Mon, 26 Jun 2006 17:45:56 -0700
From: rajesh.shah@intel.com
To: ak@suse.de, gregkh@suse.de, len.brown@intel.com
Cc: akpm@osdl.org, arjan@linux.intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: [patch 0/2] PCI: improve extended config space verification - take #2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI defines an MCFG table that gives us the pointer to where the
extended PCI-X/PCI-Express configuration space exists. We validate
this region today by making sure that the reported range is marked
as reserved in the int 15 E820 memory map. However, the PCI firmware
spec states this is optional and BIOS should be reporting the MCFG
range as a motherboard resources. Several of my systems failed the
existing check and ended up without extended PCI-Express config
space. This patch extends the verification to also look for the
MCFG range as a motherboard resource in ACPI. This solves the
problem on my i386 as well as x86_64 test systems.

The difference from the first version of this patchset is that
I moved the bulk of the code to a file shared between i386 and
x86_64, to get code reuse.

Rajesh

--
