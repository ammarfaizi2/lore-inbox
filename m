Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267970AbTB1PjQ>; Fri, 28 Feb 2003 10:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267972AbTB1PjQ>; Fri, 28 Feb 2003 10:39:16 -0500
Received: from zeke.inet.com ([199.171.211.198]:11665 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S267970AbTB1PjO>;
	Fri, 28 Feb 2003 10:39:14 -0500
Message-ID: <3E5F84FE.1050409@inet.com>
Date: Fri, 28 Feb 2003 09:49:18 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Andi Kleen <ak@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Proposal: Eliminate GFP_DMA
References: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <p73heao7ph2.fsf@amdsimf.suse.de> <20030228141234.H23865@parcelfarce.linux.theplanet.co.uk> <1046445897.16599.60.camel@irongate.swansea.linux.org.uk> <20030228143405.I23865@parcelfarce.linux.theplanet.co.uk> <1046447737.16599.83.camel@irongate.swansea.linux.org.uk> <20030228145614.GA27798@wotan.suse.de> <20030228152502.GA32449@gtf.org> <10490000.1046446480@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>>>>umm.  are you volunteering to convert drivers/net/macmace.c to the pci_*
>>>>>API then?  also, GFP_DMA is used on, eg, s390 to get memory below 2GB and
>>>>>on ia64 to get memory below 4GB.
>>>>
>>>>The ia64 is a fine example of how broken it is. People have to hack around 
>>>>with GFP_DMA meaning different things on ia64 to everything else. It needs
>>>>to die. 
>>>
>>>At least on x86-64 it is still needed when you need have some hardware
>>>with address limits < 4GB (e.g. an 24bit soundcard)
>>>
>>>pci_* on K8 only allows address mask 0xffffffff or unlimited.
>>
>>That's a bit broken...  I have an ALS4000 PCI soundcard that is a 24-bit
>>soundcard.  pci_set_dma_mask should support 24-bits accordingly,
>>otherwise it's a bug in your platform implementation...  Nobody will be
>>able to use certain properly-written drivers on your platform otherwise.
> 
> 
> If we're going to really sort this out, would be nice to just pass an upper
> bound for an address to __alloc_pages, instead of a simple bitmask ;-)

To do it properly, I think you'd need to give a range, not just an upper 
bound.  On some ARM / XScale systems, you can specify a window of your 
RAM that is visible on the PCI bus.  That may be a case too odd to care 
about, but I'm going to have to at some point in the future....

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

