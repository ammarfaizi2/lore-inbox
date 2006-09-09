Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWIIVex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWIIVex (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 17:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWIIVex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 17:34:53 -0400
Received: from smtp111.iad.emailsrvr.com ([207.97.245.111]:11994 "EHLO
	smtp141.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1751386AbWIIVew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 17:34:52 -0400
Message-ID: <45033370.8040005@gentoo.org>
Date: Sat, 09 Sep 2006 17:34:40 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060818)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, torvalds@osdl.org, sergio@sergiomb.no-ip.org,
       jeff@garzik.org, greg@kroah.com, cw@f00f.org, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru, liste@jordet.net
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
References: <20060907223313.1770B7B40A0@zog.reactivated.net>	 <1157811641.6877.5.camel@localhost.localdomain>	 <4502D35E.8020802@gentoo.org> <1157817836.6877.52.camel@localhost.localdomain>
In-Reply-To: <1157817836.6877.52.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> If they are on the V-Bus then the IRQ number controls routing if they
> are on the PCI bus the IRQ line controls routing as normal.

OK, so per your last mail, most VIA devices start on the PCI bus and 
then later are migrated onto the V-bus.

Devices on the PCI bus need to be quirked (in some circumstances), as 
when they are on the PCI bus they use the IRQ line for routing, and the 
IRQ line is what the quirk actually modifies.

V-bus devices do not need the quirk because IRQ routing there is handled 
by IRQ number alone.

Is the above correct?

I did some searching and couldn't find anything out about the V-bus, I 
assume that is some VIA-specific thing.


That aside, it appears we were talking about different situations in the 
earlier email. We have 3 device classes:

- Internal PCI bus devices
- Internal V-bus devices
- External PCI card devices

I was talking about the corner case where we quirk an external-PCI-card 
device when it is plugged into a mainboard which happens to be based on 
a VIA chipset, whereas you were objecting to the fact that my patch 
quirks both internal-PCI-bus and internal-V-bus devices (but only one of 
those classes needs to be quirked). Is that correct?


Final question for now, are you saying that the current quirk in 
mainline only quirks devices which are in the internal-PCI-bus class? 
i.e. all of the following are *not* available in internal-V-bus form?

DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0,
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, 
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, 
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686,
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4,
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5,

Thanks.
Daniel
