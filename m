Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129358AbRBHRrf>; Thu, 8 Feb 2001 12:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129106AbRBHRrZ>; Thu, 8 Feb 2001 12:47:25 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:12120 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S129092AbRBHRrU>;
	Thu, 8 Feb 2001 12:47:20 -0500
Message-ID: <3A82DB9B.3050008@valinux.com>
Date: Thu, 08 Feb 2001 10:47:07 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; 0.7) Gecko/20010126
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: Alex Deucher <adeucher@UU.NET>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x, drm, g400 and pci_set_master
In-Reply-To: <14E9CDBC07F1@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

> On  8 Feb 01 at 12:15, Alex Deucher wrote:
> 
>> I wasn't talking about the drm driver I was talking about programming
>> the PCI controller directly using setpci 1.0.0 .... or some such
>> command, I can't remember off hand.  Which turns on busmastering if it
>> is off for a particular device.
> 
> 
> OK. 
> 
>> Jeff Hartmann wrote:
>> 
>>> The DRM drivers don't know about the pcidev structure at all.  All this
>>> is done in the XFree86 ddx driver.  You can probably add something like
>>> this to MGAPreInit (after pMga->PciTag is set, in my copy its
>>> mga_driver.c:1232 yours might be at a slightly different line number
>>> depending on the version your using):
>>> 
>>> {
>>>    CARD32 temp;
>>>    temp = pciReadLong(pMga->PciTag, PCI_CMD_STAT_REG);
>>>    pciWriteLong(pMga->PciTag, PCI_CMD_STAT_REG, temp |
>>> PCI_CMD_MASTER_ENABLE);
>>> }
>> 
> 
> Jeff, do you say that drm code does not use dynamic DMA mapping, which is
> specified as only busmastering interface for kernels 2.4.x, at all? Now 
> I understand what had one friend in the mind when he laughed when I said 
> that it must be easy to get it to work on Alpha...
>                             Thanks anyway for all suggestions,
>                                         Petr Vandrovec
>                                         vandrove@vc.cvut.cz
>                                         
> 
It does not use dynamic DMA mapping, because it doesn't do PCI DMA at 
all.  It uses AGP DMA.  Actually, it shouldn't be too hard to get it to 
work on the Alpha (just a few 32/64 bit issues probably.)  Someone just 
needs to get agpgart working on the Alpha, thats the big step.

-Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
