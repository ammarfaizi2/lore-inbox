Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271806AbRHRKl7>; Sat, 18 Aug 2001 06:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271807AbRHRKlk>; Sat, 18 Aug 2001 06:41:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44155 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S271806AbRHRKlf>; Sat, 18 Aug 2001 06:41:35 -0400
To: root@chaos.analogic.com
Cc: David Christensen <David_Christensen@Phoenix.com>,
        Holger Lubitz <h.lubitz@internet-factory.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <Pine.LNX.3.95.1010817151211.4584A-100000@chaos.analogic.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Aug 2001 04:34:28 -0600
In-Reply-To: <Pine.LNX.3.95.1010817151211.4584A-100000@chaos.analogic.com>
Message-ID: <m1n14xodvv.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> On 17 Aug 2001, Eric W. Biederman wrote:
> 
> > "Richard B. Johnson" <root@chaos.analogic.com> writes:
> > 
> > > 
> > > I just posted working SDRAM controller initialization code. The SDRAM
> > > controller must be initialized in a specific step-by-step manner or
> > > else you don't even get to "restoring the memory controller settings".
> > 
> > Comments frequently don't match the code.  And how the SDRAM controller
> > must be initialized totally depends on the chipset and vendor.  SDRAM
> > itself must be initialized in a specific matter.  
> > 
> 
> That's what I said, and the comments match the code.

Apologies, I saw it was masm formatted code and assumed it was a
snippet taken from one of the pirated award BIOS's.   

I wasn't saying that I though the comments didn't match the code but
rather that I simply don't trust comments as a general rule.

Now actually reading through the code is when I attach your 
argument.  Precharge does not clear memory.  It is part of the refresh
process and gets executed as a normal part of memory operation, besides
being part of the SDRAM initialization.  Precharge does not clear the
memory.

And then you don't have the code to clear the memory, and only a
comment about clearing the low 1 megabyte of memory.  That is a
comment not matchine the code snippet at least.

 
> > But for the case of a warm reset there is not need to reset the SDRAM
> > controller.  Memory really only needs to be cleared in the case when
> > some form of error checking is being used.
> >
> 
> Memory needs to be written (with anything). It must be written before
> it's used so that there are no "almost" logic levels within the cells.
> 
> The parasitic currents from having some cells "just barely on" will
> totally screw up data retention in other cells. If anybody ever
> writes memory initialization software that doesn't perform this
> extremely important step, they just don't know what the hell they are
> doing and will contribute towards a poor reputation for software
> engineering.

I can see how this could physically be, but I don't believe this
is a real situtation.  Memory is continuously losing it's contents,
and the refresh cycles are upping the value.   So if refresh is
operating correctly I can't see how this could occur for more than one
refresh cycle.

Further I have reviewed the SDRAM data sheets from two different
manufaturers and they don't mention anything about initializing the
contents of SDRAM.

Further if the question is what an attacker can do.  Even if it isn't
a part of normal operation having a modified BIOS that doesn't clear
the memory is perfectly reasonable, to get your secure information.

> > Personally I think writing such code carries more credibility then
> > simply posting it anyway....
> > 
> 
> Well I wrote the code. And I have written SDRAM initialization code
> for many chip-sets.

I feel like taking a cheap shot right now and saying you are currently
contributing to a poor reputation for software engineer.  But in this
case the posted code snippet is correct, so I see no failure in the
code.  Just in understanding an unimportant bit of trivia of the
low-level hardware operation.  That really doesn't matter unless you
manufacture a design memory controller.

I can't currenly claim many chip-sets under my belt currently.  But I
certainly understand how this works as well.

Eric
