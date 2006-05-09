Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWEIUqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWEIUqU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWEIUqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:46:20 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:30353 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751153AbWEIUqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:46:20 -0400
Date: Tue, 9 May 2006 13:46:17 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       masouds@masoud.ir, jeff@garzik.org, gregkh@suse.de
Subject: Re: [PATCH] VIA quirk fixup, additional PCI IDs
Message-ID: <20060509204617.GA29287@taniwha.stupidest.org>
References: <20060430162820.GA18666@masoud.ir> <20060509191455.GA27503@taniwha.stupidest.org> <20060509125916.03c96efe.akpm@osdl.org> <20060509201450.GK15257@redhat.com> <20060509134101.32ef49c1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509134101.32ef49c1.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 01:41:01PM -0700, Andrew Morton wrote:

> DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
> quirk_via_irq);

which is wrong, we don't want to apply the qurik for *ALL* via devices

the comment says we want it only for on-ship devices

> DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, quirk_via_irq);
> DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, quirk_via_irq);
> DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irq);
> DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, quirk_via_irq);
> DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
> DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
> DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
>
> which is rather a step backwards, because we need to keep that list
> updated now, and we'll fail to catch new devices.

as best as i can tell this is a complete list

i tried to get details of people with hardware and was told to check
in a museum :-)

also, what *new* devices? this hardware is pretty ancient what we have
listed now should be close to everything

> What happens if we just revert
> 75cf7456dd87335f574dcd53c4ae616a2ad71a11?

the quirk gets run for VIA chips on chipsets that don't need it, so
the interrupt line is masked down when it sometimes shouldn't be (does
it mean they will always be IO-APIC-edge / PIC in that case?)

> Is there was a problem, is there something we can do at runtime in
> quirk_via_irq() to avoid the problem, rather than expanding out the
> fixup list in this manner?

from reading the comment and chedcking over pci_ids.h i think the list
is complete

in fact, i'm not sure that PCI_DEVICE_ID_VIA_82C586_0 and
PCI_DEVICE_ID_VIA_82C686 are strictly speaking supposed to be in the
list, it's unclear there and seems harmless enough
