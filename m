Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266148AbUAGTYW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 14:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266177AbUAGTYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 14:24:22 -0500
Received: from web13910.mail.yahoo.com ([216.136.172.95]:46707 "HELO
	web13910.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266148AbUAGTYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 14:24:13 -0500
Message-ID: <20040107192412.36719.qmail@web13910.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Wed, 7 Jan 2004 11:24:12 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: Any changes in Multicast code between 2.4.20 and 2.4.22/23 ? -> New Info
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Stevens <dlstevens@us.ibm.com>
In-Reply-To: <OFDDD008B9.906B9BD6-ON88256E14.0038B2E4@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

 last message on this issue for today. By inserting printk's I could
show that the packets from the "external" Ganglia/gmond clients never
show up in the "udp_rcv" routine when running the 2.4.22 kernel. So it
seems something goes amiss when receiving certain UDP packets.

 Unfortunatelly this exhausts my clues about the dataflow of ipv4. Next
question from me would be who calls "udp_rcv", or would such call be
dispatched from the inet_protos table.

Cheers
Martin

--- David Stevens <dlstevens@us.ibm.com> wrote:
> 
> 
> 
> 
> BTW, one other thing to try with this new information-- if it works
> with
> 224.0.0.1 (the all-hosts group), then I'd assume it is not a problem
> with
> the bind() or an issue with multicast delivery.
> 
> If that's true, it may be a problem with the driver multicast address
> filter,
> then I'd expect it to not receive anything on the receiver side when
> using
> "tcpdump -i ethX" but it should work if you put the interface in
> promiscuous
> mode with "tcpdump -p -i ethX" (ie, add the "-p" option to tcpdump on
> the
> receiver and see if it works then). Can you try that?
> 
> Also, if you have any other network cards you could plug in to test
> with
> that are not tg3's, it'd be useful to test with those.
> 
>             +-DLS
> 
> 
> Martin Knoblauch <knobi@knobisoft.de>@vger.kernel.org on 01/07/2004
> 02:10:28 AM
> 
> Please respond to knobi@knobisoft.de
> 
> Sent by:    linux-net-owner@vger.kernel.org
> 
> 
> To:    linux-net@vger.kernel.org
> cc:    linux-kernel@vger.kernel.org, David
> Stevens/Beaverton/IBM@IBMUS
> Subject:
> 
> 
> 
> >
> > To rule out further causes, I rebuilt the 2.4.21 version of tg3.o
> >(V1.5) for the 2.4.22 kernel (tg3-V1.6). Unfortunatelly the problem
> did
> >not go away, which point into the direction of the pretty large
> >igmp/multicast changes introduced with 2.4.22. Debugging tg3 would
> have
> >been easier ...
> 
>  Next tidbit: the problem comes when using a multicast group
> different
> from 224.0.0.1. If I change the group used by Ganglia from
> 239.2.11.71
> to 224.0.0.1 all of a sudden the multicasts come in.
> 
>  Hope this helps the specialists to track it down.
> 


=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
