Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVETRBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVETRBE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 13:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVETRBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 13:01:03 -0400
Received: from fsmlabs.com ([168.103.115.128]:3778 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261505AbVETRAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 13:00:13 -0400
Date: Fri, 20 May 2005 11:03:08 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Natalie.Protasevich@unisys.com
cc: akpm@osdl.org, ak@suse.de, len.brown@intel.com, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] Proposed: Let's not waste precious IRQs...
In-Reply-To: <20050519110613.B817D27266@linux.site>
Message-ID: <Pine.LNX.4.61.0505201020220.24152@montezuma.fsmlabs.com>
References: <20050519110613.B817D27266@linux.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Natalie,

On Thu, 19 May 2005 Natalie.Protasevich@unisys.com wrote:

> I suggest to change the way IRQs are handed out to PCI devices. 
> Currently, each I/O APIC pin gets associated with an IRQ, no matter if 
> the pin is used or not. It is expected that each pin can potentually be 
> engaged by a device inserted into the corresponding PCI slot. However, 
> this imposes severe limitation on systems that have designs that employ 
> many I/O APICs, only utilizing couple lines of each, such as P64H2 
> chipset. It is used in ES7000, and currently, there is no way to boot 
> the system with more that 9 I/O APICs. The simple change below allows to 
> boot a system with say 64 (or more) I/O APICs, each providing 1 slot, 
> which otherwise impossible because of the IRQ gaps created for unused 
> lines on each I/O APIC. It does not resolve the problem with number of 
> devices that exceeds number of possible IRQs, but eases up a tension for 
> IRQs on any large system with potentually large number of devices. I 
> only implemented this for the ACPI boot, since if the system is this big 
> and

Can you determine number of slots in use?

>   using newer chipsets it is probably (better be!) an ACPI based system 
> :). The change is completely "mechanical" and does not alter any 
> internal structures or interrupt model/implementation. The patch works 
> for both i386 and x86_64 archs. It works with MSIs just fine, and should 
> not intervene with implementations like shared vectors, when they get 
> worked out and incorporated.

Well we ran into similar problems on older MPS systems (NUMAQ) but those 
don't really matter right now anyway. So i think fixing this for ACPI is 
fine.

But i like your patch =)

Thanks,
	Zwane

