Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWFHA32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWFHA32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 20:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWFHA32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 20:29:28 -0400
Received: from mms2.broadcom.com ([216.31.210.18]:4619 "EHLO mms2.broadcom.com")
	by vger.kernel.org with ESMTP id S932463AbWFHA31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 20:29:27 -0400
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Subject: Re: tg3 broken on 2.6.17-rc5-mm3
From: "Michael Chan" <mchan@broadcom.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Greg KH" <greg@kroah.com>
In-Reply-To: <200606071711.06774.bjorn.helgaas@hp.com>
References: <200606071711.06774.bjorn.helgaas@hp.com>
Date: Wed, 07 Jun 2006 15:49:58 -0700
Message-ID: <1149720598.22757.6.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006060706; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230342E34343837364531382E303032302D412D;
 ENG=IBF; TS=20060608002919; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006060706_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6899B0D64I819535250-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-07 at 17:11 -0600, Bjorn Helgaas wrote:
> Something changed between 2.6.17-rc5-mm2 and -mm3 that broke tg3
> on my HP DL360:
> 
> 2.6.17-rc5-mm2:
>   tg3.c:v3.59 (May 26, 2006)
>   ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 30 (level, low) -> IRQ 177
>   eth0: Tigon3 [partno(N/A) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:0e:7f:b4:69:94
>   eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
>   eth0: dma_rwctrl[769f4000] dma_mask[64-bit]
> 
> 2.6.17-rc5-mm3 (with a bit of debug showing tg3_read_mem result):
>   tg3.c:v3.59 (May 26, 2006)
>   ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 30 (level, low) -> IRQ 177
>   tg3_get_eeprom_hw_cfg:
>   tg3_get_eeprom_hw_cfg: val 0xffffffff (magic 0x4b657654)
>   tg3_phy_probe: after readphy, err -16 hw_phy_id 0x0
>   tg3_phy_probe: phy_id 0xffffffff
>   lookup_by_subsys: vendor 0xe11 dev 0xcb
>   tg3: (0000:01:02.0) phy probe failed, err -19
>   tg3: Problem fetching invariants of chip, aborting.

My suspicion is that either the memory enable bit in PCI config register
4 is not set or the power state in PCI config register 0x4c is D3hot.
Any of these conditions will cause MMIO registers to return 0xffffffff.

Try reading config registers 0x4 and 0x4c to see what the values are.

Thanks.

