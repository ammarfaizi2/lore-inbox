Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbTAXV06>; Fri, 24 Jan 2003 16:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265705AbTAXV06>; Fri, 24 Jan 2003 16:26:58 -0500
Received: from zmamail03.zma.compaq.com ([161.114.64.103]:22278 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S265700AbTAXV05>; Fri, 24 Jan 2003 16:26:57 -0500
Date: Fri, 24 Jan 2003 16:33:41 -0500
From: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@pobox.com, ink@jurassic.park.msu.ru, willy@debian.org,
       linux-kernel@vger.kernel.org, Jeff Wiedemeier <Jeff.Wiedemeier@hp.com>
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
Message-ID: <20030124163341.A4366@dsnt25.mro.cpqcorp.net>
References: <20030124152453.A4081@dsnt25.mro.cpqcorp.net> <20030124203402.GA4975@gtf.org> <20030124154635.A4161@dsnt25.mro.cpqcorp.net> <20030124.125121.78932406.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030124.125121.78932406.davem@redhat.com>; from davem@redhat.com on Fri, Jan 24, 2003 at 12:51:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 12:51:21PM -0800, David S. Miller wrote:
>    From: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
>    Date: Fri, 24 Jan 2003 15:46:35 -0500
> 
>    On Fri, Jan 24, 2003 at 03:34:02PM -0500, Jeff Garzik wrote:
>    > AFAICS, this is a per-driver decision, and needs to be done at the
>    > driver level, in the tg3 driver source.
>    
>    The last sentence in the quote above indicates that it is not intended
>    (by the PCI spec) to be a per-driver decision, but rather a system
>    decision. The messages used are also a per-bus system resource and how
>    an MSI goes from the PCI bus to the rest of the system (i.e. the CPU(s))
>    is implementation dependent.
> 
> Yes, this is understood.
> 
> But the tg3 hw designers have decided to do something which makes this
> not possible.

True. 
 
> So, for tg3's case, it has to become a driver specific decision
> whether to support MSI or not.

But right now, the driver does not have enough information to make it a
driver specific decision. INT_LINE may not be enough to determine the
vector to claim for LSIs and "Message Data" may not be enough to
determine the vector to claim for MSIs. What is there is the irq field
in struct pci_dev.

The intent I had in making sure that MSGINT_MODE was set to match
PCI_MSI_FLAGS_ENABLE and making sure the capability was saved and
restored was to come as close as possible to the spec.

If it needs to be made a driver decision, there needs to be some way to
communicate the correct vector information for whichever option the
driver is using (if there already is and I missed it, please let me
know). Otherwise, it seems that trying to match spec behavior given the
hardware design or disabling MSI at config time for these devices (such
as through quirks) are the options.

/jeff
