Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbUJaRNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbUJaRNJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 12:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbUJaRNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 12:13:09 -0500
Received: from mailhub2.nextra.sk ([195.168.1.110]:37898 "EHLO toe.nextra.sk")
	by vger.kernel.org with ESMTP id S261330AbUJaRNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 12:13:00 -0500
Message-ID: <41851D24.3040303@rainbow-software.org>
Date: Sun, 31 Oct 2004 18:13:08 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HP C2502 SCSI card (NCR 53C400A based) not working
References: <4184D8EB.6000306@rainbow-software.org> <1099236179.16385.16.camel@localhost.localdomain>
In-Reply-To: <1099236179.16385.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sul, 2004-10-31 at 12:22, Ondrej Zary wrote:
> 
>>Hello,
>>I have an old ISA SCSI card that came with HP ScanJet IIP scanner. It's
>>HP C2502 card based on NCR 53C400A chip. I was unable to get it working
>>with g_NCR5380 driver so I tried loading the official MINI400I.SYS
>>driver in DOSemu. I was surprised that the values sent to the ports are 
>>not the same as in the g_NCR5380 driver.
> 
> 
> It should work in 2.4 providing you use the loading options for
> ncr53c400a and set a port and no IRQ (read mine did). What options are
> you trying ?

I forgot to say that I'm trying this in 2.6.9. I've tried options like this:
ncr_53c400a=1 ncr_addr=0x350 ncr_irq=255
also tried ncr_53c400=1 (without the 'a'), various addresses and IRQs.
It never worked. I always get "scsi0: bus busy, attempting abort", etc.
and even Oops sometimes.

>>According to this, I think that my card has the 53C400A chip registers 
>>mapped to different addresses (offsets) but I'm unable to determine what 
>>the mapping is. I was also unable to find the 53C400A datasheet which 
>>might help a bit.
> 
> 
> The 53c400a can be programming to an address by software - either by
> magic sequences or I believe according to pin strapping by ISAPnP.

My card has no jumpers - only solder points for two 3-pin jumpers and it
doesn't look like it can do ISAPnP.
I've made a simple test program in pascal to test the magic sequences in
DOS. The card ignores the magic sequences that the g_NCR5380 driver
uses. When I use the sequences obtained from MINI400I.SYS using DOSemu,
it "works" - I can read/write the card's registers at the configured
base address. The IRQ (2,3,4,5 and 7) can be configured by the magic
sequence too (by setting the high-order bits in the last number in the 
sequence).
So I know how to configure my card, maybe I should try to add it to the
driver (e.g. by adding ncr_53c400a_hp=1 parameter). If I only could get
the register mapping correctly (I think that this is the problem now).

The g_NCR5380 driver moves the base address by +8 bytes for 53C400 chips 
(but not for 53C400A) and defines the 53C400 specifis register offsets 
negative. This looks weird to me - either the 53C400A does not have 
these additional registers or the driver is broken and is trying to 
access these registers outside the I/O range on 53C400A.

> Its been a long time since I touched such junk however and if you want
> to do anything useful with your computer while scanning (like waving the
> mouse point around) get something else!

I know it's old, cheap and bad - I just want to make it work. I remember
that it worked in DOS/Windows 3.1. I was not successful in Windows 98 -
although there is an official driver from HP.

P.S. I've removed the Ingmar Baumgart's e-mail address from CC as it
does not work.

-- 
Ondrej Zary



