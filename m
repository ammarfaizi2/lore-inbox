Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266443AbUAIIh6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 03:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266445AbUAIIh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 03:37:57 -0500
Received: from web13908.mail.yahoo.com ([216.136.175.71]:31560 "HELO
	web13908.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266443AbUAIIhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 03:37:24 -0500
Message-ID: <20040109083720.86025.qmail@web13908.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Fri, 9 Jan 2004 00:37:20 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: Any changes in Multicast code between 2.4.20 and 2.4.22/23 ? -> New Info
To: David Stevens <dlstevens@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <OFF9934921.DF9DB0E3-ON88256E15.00658D89@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Martin,
>       If forcing it to use IGMPv2 makes it work when you aren't even
> using
> a multicast router, it sounds like you may have a switch that is
> snooping
> IGMP
> packets and doesn't understand IGMPv3. If so, that isn't a bug in
> linux;
> that would
> be your switch software needing an upgrade.
David,

 thanks for your suggestion. I will try to find out what kind of switch
the customer is using in their (pretty much a black hole for anybody)
network infrastructure.

 I am still confused why the switch would matter. The setup is 21
identical nodes, besides 20 are running 2.4.20 and one is running
2.4.22. All on the same switch. All on the same "line card" as far as I
know. The 20 2.4.20 nodes talk happily to each other over the
239.2.11.71 multicast. Only the one node running 2.4.22 does not "see"
the packets from the other 20 nodes (they see the packets from the node
running 2.4.22).

 So you are telling me that the switch somehow decides not to
send/forward 239.2.11.71 packets to the node running 2.4.22? As I said,
I have to check that out with the customers IT.

 The other thing is - why does it work with the 224.0.0.1 group.
Because the switch would always pass those packets?

>       I have no idea what you mean by "timer bug"; IGMP_V2_SEEN()
> only
> applies  when you have a v2 multicast router that is doing IGMPv2
> queries.

 Just a wild guess probably. From looking at the IGMP_Vx_SEEN macros it
seemed to me yesterday that at least for the V1 case the actual jiffie
comparison had been reversed when going from 2.4.21 to 2.4.22+. But
maybe it was already to late... OK, closer look at the source shows
that it was already to late. Nothing changed :-)

> You
> told me you were on a single network, in which case the version of
> IGMP or
> whether you send any IGMP reports at all is irrelevant, except for
> the
> special
> case of "smart" switches that are trying to use IGMP packets for port
> forwarding.

 OK. Maybe the switch is really to smart...

> IGMP reports do not in any way affect multicast group membership on
> the
> host.

 Correct. The group membership seems OK.

>       In any case, I have tested IGMPv2 compatibility mode and, of
> course,
> I found nothing broken-- certainly it WOULD violate the IGMPv3 RFC to
> always do IGMPv2, so I'm not sure what you're suggesting.
> 
>                         +-DLS
> 

 Not really suggesting anything here. I just try to understand an
apparently complex issue. From the outside it just looks like something
in 2.4.22+ breaks an application that has worked for years with Linux.
Now, maybe/likely you are right and the upgrade just shows some
interesting property of our customers setup :-)

 Or maybe I am suggesting an compile/runtime option to disable IGMP_V3.
Just a thought. I know, massaging good code to make other "broken"
stuff work is wrong in principle. But sometimes it is the only way top
go. Maybe I can come up with a patch.

 In any case thanks for your attention/suggestions/help. If anything
comes out of this, I will have learned something new.

Cheers
Martin
PS: Something I never mentioned. You CC linux-kernel and linux-net,but
I never actually saw your posts on the list .... Just in my mailbox.


=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
