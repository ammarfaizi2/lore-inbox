Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135263AbRECWIg>; Thu, 3 May 2001 18:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135266AbRECWIZ>; Thu, 3 May 2001 18:08:25 -0400
Received: from asooo.flowerfire.com ([63.104.96.247]:26338 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S135263AbRECWIS>; Thu, 3 May 2001 18:08:18 -0400
Message-Id: <200105032207.RAA11260@asooo.flowerfire.com>
Date: Thu, 3 May 2001 15:07:39 -0700
From: Ken Brownfield <brownfld@irridia.com>
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
Subject: Re: 2.4.4 Kernel - ASUS CUV4X-DLS Question
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
To: Hugh Dickins <hugh@veritas.com>
X-Mailer: Apple Mail (2.388)
In-Reply-To: <Pine.LNX.4.21.0105032206260.3039-100000@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v388)
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm losing the timer interrupt, but it's not driver-specific -- only the 
motherboard is required to reproduce for me; different SCSI, RAID, and 
ether drivers have been swapped out.  Nothing with "HP" on it seems to 
work, and it wouldn't surprise me in the least to find out that HP's 
stuff is broken.  But this problem has existed since 2.4.0-test1 and 
hasn't changed, and it surprises me that at least a work-around hasn't 
been merged into "the" kernel by now.

There might be fixes in the -ac tree that effect my problem -- I'll try 
the latest -ac and see what happens.  Thanks for the suggestion.

But the distributions use _the_ kernel.  Even if -ac is fixed, it's not 
really something I would be willing to put in production.  Until I found 
the noapic work-around, we were basically going to have to move off of 
Linux.  I could very well be an isolated case, but the APIC issues I'm 
seeing scare me, and not just for my sake.

I mean all of this in the utmost respect -- I just felt that this issue 
needs a little more light shed on it, and I'm here to help in any way I 
can.
--
Ken.

On Thursday, May 3, 2001, at 02:24 PM, Hugh Dickins wrote:

> On Thu, 3 May 2001, Alan Cox wrote on APIC problems in 2.4:
>> There are five cases I am seeing
>> 1.	Serverworks total APIC hose ups.
>> 	Fix: remove OSB4 or use -ac tree
>> 2.	440BX and similar boards losing interrupts on some drivers
>> 	Fix: use -ac
>> 3.	APIC errors notably checksum errors.
>> 	Fix: buy properly manufactured hardware
>> 4.	Hangs on boot with the CUV4XD and a couple of other boards.
>> 	Still a mystery
>> 5.	Incorrect PCI IRQ routing
>> 	Fix: Mostly get a board with a correct BIOS. There are a couple of
>> 	cases people are looking at - some are fixed in 2.4.4 and -ac
>> 	where magic IRQ lines are not visible directly in PCI space
>
> Doesn't 2.4.1-ac1 onwards contain:
>
> o	Workaround code for APIC problems with ne2k	(Maciej Rozycki)
> 	| this will break original 82489DX devices for now
> 	| ie _very_ early dual pentium boards
>
> Got good reviews at the time, and I thought it was more general than
> ne2k.  I don't remember it going forward to Linus (but I've not looked).
>
> Hugh
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
