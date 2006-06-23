Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752016AbWFWUNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbWFWUNt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbWFWUNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:13:48 -0400
Received: from mga07.intel.com ([143.182.124.22]:48505 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1752016AbWFWUNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:13:48 -0400
X-IronPort-AV: i="4.06,170,1149490800"; 
   d="scan'208"; a="56629573:sNHT15669997"
Message-Id: <20060623200928.036235000@rshah1-sfield.jf.intel.com>
Date: Fri, 23 Jun 2006 13:09:28 -0700
From: rajesh.shah@intel.com
To: ak@suse.de, gregkh@suse.de
Cc: akpm@osdl.org, brice@myri.com, 76306.1226@compuserve.com,
       arjan@linux.intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: [patch 0/2] PCI: improve extended config space verification
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

Rajesh
--
