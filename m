Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133099AbRAXX0L>; Wed, 24 Jan 2001 18:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133021AbRAXX0C>; Wed, 24 Jan 2001 18:26:02 -0500
Received: from zeus.kernel.org ([209.10.41.242]:38355 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129742AbRAXXZz>;
	Wed, 24 Jan 2001 18:25:55 -0500
Date: Wed, 24 Jan 2001 13:58:09 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Alan Chandler <alan@chandlerfamily.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [preview] Latest AMD & VIA IDE drivers with UDMA100 support
In-Reply-To: <20010124202527.A2405@suse.cz>
Message-ID: <Pine.LNX.4.10.10101241314470.14153-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001, Vojtech Pavlik wrote:

> On Wed, Jan 24, 2001 at 10:04:50AM -0800, Andre Hedrick wrote:
> 
> > > Well, I know this. But I fear hardcoded timings won't really help here,
> > > unless everyone out there ran their chipsets at 33 MHz, in which case the
> > 
> > You have to run the ATA Chipset at 33MHz or it will fail in 99% of all
> > cases. 
> 
> No. Though I'd advise everyone to stick with 33MHz PCI when they can
> because it is safe. But even the VIA specs mention 25, 37.5 and 41.5 PCI
> speeds.
> 
> > This is not the FSB running at 66/83/100/133.  So hardcode is
> > correct.
> 
> If you set a MVP3 or MVP4 chipset to 83 MHz FSB, you'll get 41.5 MHz
> or 27.6 MHz PCI. And there are chips speced for 75 and 83 MHz FSB's -
> Cyrix 6x86MX etc.
> 
> No way to get 33 here, if you *don't* want to over/under-clock the CPU. 

Vojtech,

In the past there were hardcoded timing values for the allowable for the
VIA cores that were defined by VIA.  They were taken from their internal
lookup tables.  You have stated that you have allowed for "slop" in the
timing to attempt to soften the driver, that is your decision you are
totally responsible for keeping that chipset alive.

I suspect that you have not seen and know that you have not hear in person
the issues that arise for pushing or slacking the timing on the HOST side
of the world.  However, I do expect that you understand that at slower
transfer rates you have a greater margin for error-tolerance.  However the
game completely changes once Mode 3 and higher are used.  The margins are
ever so narrow.  Thus by following the exact letter and value you remove
suspect from the driver.

Additionally with the auto_crc_downgrade feature now in 2.4.x if they only
get iCRC errors the main driver will force the transfer rate down to
stablize the timings.  This was put in to correct for all the real crap
mainboards that everyone buys and expects them to work at full speed.
Well the do not, and fudging the timing tables to make crap work and
then cause ones that are within the tolerance of the cable skews is not
acceptable.  You will continue to fight this battle and lose, but consider
doing so gracefully.

Put the hardcoded timing values back in as default, and allow for the
option to use the dynamic fudged ones by the enduser.  The default are
generally stable, the fudged ones I can not comment.

Oh and overclockers can goto hell on a bobsled for all I care because
current scope as define by the top is that overclock is not the default
case of use.

Lastly the IDE-PCI clocking is independent of the FBS or PCI-Bus clocking.
The three timing ranges given by VIA for 25, 33, 41 are to morph the
IDE-PCI clock back to 33.  Thus PCI-Bus of 25 increases cycle time to
achieve the 33, as the 41 reduces time to achieve the 33.  I know what I
want to say, whether I did or not succeed is an issue.  So if you do not
follow me (as most usually fail to follow me :-(( ) just ask.

Regards,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
