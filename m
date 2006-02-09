Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422842AbWBIHHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422842AbWBIHHN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 02:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422843AbWBIHHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 02:07:13 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:16521 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1422841AbWBIHHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 02:07:10 -0500
Date: Thu, 09 Feb 2006 16:05:46 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andi Kleen <ak@suse.de>, "Luck, Tony" <tony.luck@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       naveen.b.s@intel.com, Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [RFC:PATCH(000/003)] Memory add to onlined node. (ver. 2)
Cc: ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, x86-64 Discuss <discuss@x86-64.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060209153539.6CEE.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I updated patches for memory hot-add.
Current code allow addition to just node 0.
By this patch, the new memory is able to be added to appropriate node,
- if the node is already online.-  If the node is offline, 
(It means new node is comming!)  then the memory will belongs
to node 0 yet.

If new memory belongs to new node, new pgdat must be initialized.
But, it still need more many steps. So, I would like to propose
this small steps for a while.

This patch is use acpi's DSDT to find node id from physicall address.
So, this patch is just for intel/AMD architecture.

I tested this patch on ia64 and x86-64 box with custermized  SRAT & DSDT
node emulation.

This patch is for 2.6.16-rc2-mm1. 

Please comment.

Change log from ver.1 is
  - The parameter of size of add_memory() was changed from (_MAX - _MIN + 1)
    to _LEN by Bjorn Helgaas-san.
    To compare physical memory and DSDT at
    acpi_memory_match_paddr_to_memdevice(), using MAX-MIN +1 was changed 
    to using length.
  - change from using acpi_map_pxm_to_node() to pxm_to_node().
    acpi_map_pxm_to_node() is useful to decide new node's id
    when new node can be added, but it is not appropriate for 
    current code.
  - Remove extra \n from ACPI_TRACE_FUNCTION().
  - Update for 2.6.16-rc2-mm1.
  - Tested on x86_64 box with SRAT & DSDT emulation.

Please comment.
-- 
Yasunori Goto 


