Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVCWSlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVCWSlj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 13:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVCWSli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 13:41:38 -0500
Received: from fmr22.intel.com ([143.183.121.14]:40885 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261824AbVCWSlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 13:41:36 -0500
Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
From: Len Brown <len.brown@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Shaohua Li <shaohua.li@intel.com>, Grzegorz Kulewski <kangur@polcom.net>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1110.65.74.231.82.1111550240.squirrel@mail.cce.hp.com>
References: <41062.15.99.19.46.1111525073.squirrel@mail.atl.hp.com>
	 <1111539249.18927.17.camel@sli10-desk.sh.intel.com>
	 <1110.65.74.231.82.1111550240.squirrel@mail.cce.hp.com>
Content-Type: text/plain
Organization: 
Message-Id: <1111603235.17317.883.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Mar 2005 13:40:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

I like how pci_fixup_device() invokes the quirk
when we want at pci_enable_device() time w/o cluttering
the code with VIA specific hooks.

I think you've also identified an improvement by
checking acpi_irq_model -- as the PCI config space
IRQ register is defined only in PIC-mode -- so one
must assume that the quirky via HW can't depend on
us writing reserved bits for IRQs > 15.

But checking skip_ioapic_setup in the non-ACPI case
isn't quite right.  This is set for "noapic".  But
it is not set in the PIC-mode case where the kernel
supports IOAPIC but the hardware does not -- in that
case the quirk would erroneously exit.

Also, the original quirk_via_irqpic()
had a udelay(15) before the write -- I have no idea
if that was significant or not -- maybe soembody else
on the list does -- as none of us have VIA documentation...

thanks,
-Len

ps. we need to fix this on 2.4 also.


