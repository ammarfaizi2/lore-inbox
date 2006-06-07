Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWFGXLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWFGXLS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 19:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWFGXLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 19:11:18 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:48826 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932461AbWFGXLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 19:11:18 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-kernel@vger.kernel.org
Subject: tg3 broken on 2.6.17-rc5-mm3
Date: Wed, 7 Jun 2006 17:11:06 -0600
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       mchan@broadcom.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606071711.06774.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something changed between 2.6.17-rc5-mm2 and -mm3 that broke tg3
on my HP DL360:

2.6.17-rc5-mm2:
  tg3.c:v3.59 (May 26, 2006)
  ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 30 (level, low) -> IRQ 177
  eth0: Tigon3 [partno(N/A) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:0e:7f:b4:69:94
  eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
  eth0: dma_rwctrl[769f4000] dma_mask[64-bit]

2.6.17-rc5-mm3 (with a bit of debug showing tg3_read_mem result):
  tg3.c:v3.59 (May 26, 2006)
  ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 30 (level, low) -> IRQ 177
  tg3_get_eeprom_hw_cfg:
  tg3_get_eeprom_hw_cfg: val 0xffffffff (magic 0x4b657654)
  tg3_phy_probe: after readphy, err -16 hw_phy_id 0x0
  tg3_phy_probe: phy_id 0xffffffff
  lookup_by_subsys: vendor 0xe11 dev 0xcb
  tg3: (0000:01:02.0) phy probe failed, err -19
  tg3: Problem fetching invariants of chip, aborting.

The tg3 driver itself didn't change, so it must be some other PCI
change or something.  The only other PCI device I have (a Smart
Array with cciss driver) works fine.

I'll try to narrow down the problem tomorrow, but I'll post this in
case it's obvious to somebody.

Bjorn
