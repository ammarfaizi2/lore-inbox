Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268000AbTB1PYi>; Fri, 28 Feb 2003 10:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268001AbTB1PYi>; Fri, 28 Feb 2003 10:24:38 -0500
Received: from franka.aracnet.com ([216.99.193.44]:15755 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268000AbTB1PYh>; Fri, 28 Feb 2003 10:24:37 -0500
Date: Fri, 28 Feb 2003 07:34:41 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>, Andi Kleen <ak@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Proposal: Eliminate GFP_DMA
Message-ID: <10490000.1046446480@[10.10.2.4]>
In-Reply-To: <20030228152502.GA32449@gtf.org>
References: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <p73heao7ph2.fsf@amdsimf.suse.de> <20030228141234.H23865@parcelfarce.linux.theplanet.co.uk> <1046445897.16599.60.camel@irongate.swansea.linux.org.uk> <20030228143405.I23865@parcelfarce.linux.theplanet.co.uk> <1046447737.16599.83.camel@irongate.swansea.linux.org.uk> <20030228145614.GA27798@wotan.suse.de> <20030228152502.GA32449@gtf.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > > umm.  are you volunteering to convert drivers/net/macmace.c to the pci_*
>> > > API then?  also, GFP_DMA is used on, eg, s390 to get memory below 2GB and
>> > > on ia64 to get memory below 4GB.
>> > 
>> > The ia64 is a fine example of how broken it is. People have to hack around 
>> > with GFP_DMA meaning different things on ia64 to everything else. It needs
>> > to die. 
>> 
>> At least on x86-64 it is still needed when you need have some hardware
>> with address limits < 4GB (e.g. an 24bit soundcard)
>> 
>> pci_* on K8 only allows address mask 0xffffffff or unlimited.
> 
> That's a bit broken...  I have an ALS4000 PCI soundcard that is a 24-bit
> soundcard.  pci_set_dma_mask should support 24-bits accordingly,
> otherwise it's a bug in your platform implementation...  Nobody will be
> able to use certain properly-written drivers on your platform otherwise.

If we're going to really sort this out, would be nice to just pass an upper
bound for an address to __alloc_pages, instead of a simple bitmask ;-)

M.

