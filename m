Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWC3LtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWC3LtT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWC3LtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:49:19 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:46527 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750854AbWC3LtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:49:19 -0500
Date: Thu, 30 Mar 2006 20:49:06 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:000/004]Unify pxm_to_node id ver.4.
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Yasunori Goto <y-goto@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330204245.A4F5.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch set is to unify mapping from pxm to node id ver.4.
I posted patches for config of NODES_SHIFT.
So, MAX_PXM_DOMAIN is just defined by MAX_NUMNODES.
(But, old pxm's spec was 8 bit. So, if MAX_NUMNODES is 256 or smaller,
 then I use 256 for it.)

This patches are for 2.6.16-git16.
I tested them on ia64(Tiger4) with node emulation.

Please apply.

------------------------
Change log from ver.3
  - The patch for configuration of NODES_SHIFT is divided to other post.
    MAX_PXM_DOMAIN is defined by MAX_NUMNODES.

Change log from ver.2
  - update for 2.6.16-git14.
  - definition of pxm was changed from u8 to int. Pxm can be over 256.
  - CONFIG_NR_NODES is defined to configure MAX_PXM_DOMAINS.
  - redundant call of pxm_bit_set() is removed at acpi_numa_arch_fixup()
    of ia64 like followings.
	if (pxm_bit_test(i)) {
		:
		pxm_bit_set(i);  <---------------------- !!!
		:
	}

Change log from ver.1 
  - Fix old map from HP and SGI's code by Bob Picco-san.
  - Remove MAX_PXM_DOMAINS from asm-ia64/acpi.h. It is already defined at
    include/acpi/acpi_numa.h.
  - Fix return code of setup_node() at arch/x86_64/mm/srat.c
  - Fix ACPI_NUMA config for i386 by Andy Witcroft-san.
  - Define dummy functions for i386's compile error.
  - Remove garbage nid_to_pxm_map from acpi20_parse_srat() 
    at arch/i386/kernel/srat.c

----------------------------------
Description.

This patch is to unify mapping from pxm to node id.
In current code, i386, x86-64, and ia64 have its mapping by each own code.
But PXM is defined by ACPI and node id is used generically. So,
I think there is no reason to define it on each arch's code.
This mapping should be written at drivers/acpi/numa.c as a common code.



-- 
Yasunori Goto 


