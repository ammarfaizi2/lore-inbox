Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315060AbSDWENi>; Tue, 23 Apr 2002 00:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315061AbSDWENh>; Tue, 23 Apr 2002 00:13:37 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:36496 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S315060AbSDWENf>; Tue, 23 Apr 2002 00:13:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@yahoo.com>
Reply-To: ivangurdiev@yahoo.com
Organization: ( )
To: Urban Widmark <urban@teststation.com>
Subject: Re: [PATCH] Via-rhine minor issues
Date: Mon, 22 Apr 2002 22:07:16 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.33.0204222056480.9063-100000@cola.teststation.com>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02042222071600.00745@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The public docs don't say.
>

That is precisely the problem.
4 missing interrupts in the interrupt mask, 1 additional interrupt 
which Jeff Garzik says all drivers should handle and the via-rhine doesn't.
2 interrupts handled quite differently in the linuxfet driver.
1 wicked error message of which I've seen 3 different versions and none of 
them makes much sense to me. 

It is lack of documentation.
The tech sheets do not explain what causes the interrupts in detail, how to 
handle the interrupts in detail. They rather provide the bit address of the 
interrupt which is good to know, but not enough. What resources did Donald 
Becker use when he was writing this?

Perhaps I should ask him.
Or do you know a good document on such things?
 

> You should probably add them to the list of reasons to call
> via_rhine_error, and let them be caught by the "wicked" error rule. A
> reason to use a term that doesn't try to be specific is that we don't
> really know what is causing the event.

Well, most Rx errors are handled in via_rhine_rx.
The "Wicked" error rule doesn't do anything besides a CmdTxDemand.
Is this correct handling for, let's say RxOverflow?  ..Again, facing the
overwhelming lack of documentation :) (see above paragraph)

Yes, we do know what's causing the event.
We know exactly which interrupt.
We just don't know how to handle it.

> Does merging this error handling change into the main kernel really help
> you test other things for your timeout problem? Can't you just include
> this bit in your other work?
>
> /Urban

Ok not really.
Apparently this change is controversial and I'll leave it out of my patch 
until decided what to do. I would just like the kernel driver to be less 
buggy and I wanted to contribute.

Plus, I've been making too many changes to my copy. It would be easier to 
work over a clean kernel driver.  I would have less things to keep track of 
that have been changed.


---------------------------
While we're talking about bugs, here's a (possibly ignorant) question:
Do Rhine-III's have a place in the following? : 

#ifdef USE_MEM
static void __devinit enable_mmio(long ioaddr, int chip_id)
{
        int n;
        if (chip_id == VT86C100A) {
                /* More recent docs say that this bit is reserved ... */
                n = inb(ioaddr + ConfigA) | 0x20;
                outb(n, ioaddr + ConfigA);
        } else if (chip_id == VT6102) {
                n = inb(ioaddr + ConfigD) | 0x80;
                outb(n, ioaddr + ConfigD);
        }
}
#endif


-----------------------------

Well, apart from things which are not precisely clear how to fix, 
would you like to me to submit any portions of my patch for inclusion at all?
A little warning: as far as testing goes - my card stalls without the fixes,
and it stalls with the fixes :) Yet, they seem simple enough to offer for 
inclusion. 







