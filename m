Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312401AbSCYLfJ>; Mon, 25 Mar 2002 06:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312404AbSCYLeu>; Mon, 25 Mar 2002 06:34:50 -0500
Received: from p50846B26.dip.t-dialin.net ([80.132.107.38]:34018 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S312401AbSCYLei>;
	Mon, 25 Mar 2002 06:34:38 -0500
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@zip.com.au>,
        christophe =?iso-8859-1?q?barb=E9?= 
	<christophe.barbe.ml@online.fr>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x and resume
In-Reply-To: <20020323161647.GA11471@ufies.org> <3C9CCBEB.D39465A6@zip.com.au>
	<1016914030.949.20.camel@phantasy>
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Mon, 25 Mar 2002 12:34:18 +0100
Message-ID: <m3r8m851ad.fsf@venus.fo.et.local>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> writes:

> On Sat, 2002-03-23 at 13:39, Andrew Morton wrote:
>
>> in modules.conf, and we really have eight NICS, and they're
>> being plugged and unplugged, how can we reliably associate
>> that option with the eight cards?  So the right option is
>> applied to each card eash time it's inserted?  Should the
>> option be associated with a card, or with a bus position?
>
> Ugh, not pretty.
>
> Associate it with the bus position I'd say?

I don't know wherewith the <i> in eth<i> is associated (bus pos or
maybe linear ordering of the MAC addresses or somesuch), but I would
expect a selected combination of eth<i> userland configuration (IP
address, netmask) and driver level configuration (WOL, ...) to remain
stable.

Being able to redetect a pulled card put in a different slot as a
"known" one giving it the same eth<i> (and associated WOL etc. config)
as before would of course be nice, but I can't see how this can be
cleanly done over reboots.

With bus pos you get a lesser variant of the "SCSI disk association
problem", i.e. inserting an eth card in an empty slot between other
eth cards moves at least some of the others (I'm not sure, but I think
this would be the current behaviour. - Over reboots, not in the
hot-plug case, of course).

I wouldn't mind if the <i> in eth<i> was somehow derived from the
phy. bus pos; so I'd maybe have eth3 and eth7 and if I plugged another
one it could be eth4. That way I'd only have to worry about the cards
"wandering" around when changing/drastically reconfiguring (BIOS
update?) the motherboard.

To cut a lengthy dogfight short most of that useful functionality
could be had by indexing the eth configure scripts over, say, MAC
address instead of eth<i>; that way I'd have to touch the config when
exchanging the card against a different one; but no others would
decide to move around no matter what. OK, so there might be b0rked
cards with unusable MACs out there, but for the applications I have in
mind I wouldn't use those, anyway.

(All this comes to mind because in my PFY days I had to fight with a
firewall which, after card change (might even have been driver load
order, can't remember whether it was the same driver for all 3 cards)
shifted eth<i> in a most, ah, undesirable fashion.)


So long,
   Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
