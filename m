Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbRGXOSi>; Tue, 24 Jul 2001 10:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbRGXOS2>; Tue, 24 Jul 2001 10:18:28 -0400
Received: from [193.120.224.170] ([193.120.224.170]:20365 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S267542AbRGXOSR>;
	Tue, 24 Jul 2001 10:18:17 -0400
Date: Tue, 24 Jul 2001 15:15:05 +0100 (IST)
From: Paul Jakma <paulj@alphyra.ie>
To: Michael Poole <poole@troilus.org>
cc: Dominik Kubla <kubla@sciobyte.de>, Paul Jakma <paul@clubi.ie>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Arp problem
In-Reply-To: <87k80y8qsz.fsf@cj46222-a.reston1.va.home.com>
Message-ID: <Pine.LNX.4.33.0107241453110.14727-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 24 Jul 2001, Michael Poole wrote:

>
> This may be a stupid question, but does
>   cat 0 > /proc/sys/net/ipv4/conf/eth0/send_redirects
> help the problem any (for the proper value of "eth0")?  A college
> roommate of mine once had the same problem, and clearing
> send_redirects for the interface fixed it for him.
>

i'll have to try this sometime... but i'm a bit doubtful.

when i originally was looking at this (long time ago), i did consider
disabling redirects, but decided against because:

- i presumed that this would not affect network behaviour in any way
bar suppressing redirects

- i actually do need redirects :)

you see.....

i actually have /multiple/ linux boxes, each acting with a physically
independent subnet behind them, each box acting as router for that
subnet. one linux box is the internet router/firewall/proxy/etc.. it
is also the default gateway for the windows machines and the other
linux routers.


eg, something like:

			(internet)
			   |
			linux1
                         |  |
             (192.168.0/24) (192.168.3)
-----------------------------------------------------------------
  |          |                        | | | | | | | | | | | |
 (192.168.0/24)
linux2	   linux3       	    (windows hosts: 192.168.3/24)
 |           |
192.168.x/y  192.168.a/b

so i need redirects in order for the linux boxes to properly route
between themselves (they are all on the same logical subnet). however,
i need the linux box to fully route between 192.168.0/24 and
192.168.3/24 because the windows boxen are incapable of following
redirects to hosts where dst net != own net. (not an unreasonable
thing to do actually).

eventually i had to put an extra NIC into linux1 to get it to route
between 192.168.8.3.

(ironically though... linux1 knows fine well that the the 2 seperate
NICs are on the same wire - it will send replies to both nets from
either NIC! so why could it not have done routing between the subnets
when they were on the same NIC? it knew then too that it was the same
wire!)

eventually of course i'll throw the windows machines onto a
/physically/ distinct network. however, still a PITA that linux will
not route between subnets that are bound to the same link - and i'd
love to know if it is possible to make linux do it. (i would have
thought that would be the default behaviour).

also: suggestions were made to try ipchains... however ipchains was
already setup on the 'linux1' box with -j ACCEPT set for forwarding
where src/dst == 192.168/16. (what more can be done??).

so that isn't the answer, AFAICT.

> -- Michael Poole

regards,

--paulj

