Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315653AbSECS6T>; Fri, 3 May 2002 14:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315654AbSECS6T>; Fri, 3 May 2002 14:58:19 -0400
Received: from [62.47.201.188] ([62.47.201.188]:52997 "EHLO Goucho")
	by vger.kernel.org with ESMTP id <S315653AbSECS6R>;
	Fri, 3 May 2002 14:58:17 -0400
Message-ID: <001501c1f2d4$79ca63a0$1401000a@GOD>
From: "Andreas Beham" <atahualpa@gmx.at>
To: "Christian Koenig" <"ChristianK."@t-online.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <001d01c1f2b4$18b00b30$1401000a@GOD> <173hFh-0Mpsp6C@fwd04.sul.t-online.com>
Subject: Re: 2.4.18 NAT Problems with udp packets; kernel doesnt care about changed rules
Date: Fri, 3 May 2002 20:58:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Christian Koenig" <"ChristianK."@t-online.de>
To: "Andreas Beham" <atahualpa@gmx.at>
Sent: Friday, May 03, 2002 8:54 PM
Subject: Re: 2.4.18 NAT Problems with udp packets; kernel doesnt care about
changed rules


> Hi,
>
> > Hi,
> >
> > I have a Linux Box configured as Router for my Network. Behind my
Network
> > are several Win/Mac/Linux Clients. Today I tried to play Dungeon Siege
(DS)
> > on my Notebook (WinXP) which is behind my router with my friend.
> > so the connection looks like the following (did tcpdump, dont have the
> > actual data available though):
> > myNotebook.2302 -> myRouter.someport
> > myRouter.2302 -> Friend.6073 udp blah blah
> > Friend.6073 -> myRouter.2302 udp blah blah
> > myRouter.2302 -> Friend.6073 icmp udp port 2302 unreachable
> >
> > the following line in my fw script does masquerading:
> > $FILTER = /sbin/iptables
> > $EXTINT = ppp0 (most of the time, but it happened under 2.2.x that the
> > kernel went crazy and started naming them ppp0 ppp1 ppp2 ppp3..., hasnt
> > happened in a while)
> > $FILTER -t nat -A POSTROUTING -o $EXTINT -j MASQUERADE
> >
> > Playing DS over the internet ONLY works with this line added (10.0.1.20
is
> > my notebook):
> > $FILTER -t nat -A PREROUTING -i $EXTINT -p udp -d $EXTIP --dport
> > 2300:2400 -j DNAT --to 10.0.1.20
> > no else changes need to be made
> >
> > And here comes the next trouble. Flushing all rules and loading again
all
> > my previous rules + this new one did not change a thing! I had to
> > disconnect from the internet for some seconds and then reconnect and
load
> > the script again. Only then did the kernel get the changes and route
> > correctly. If I just flushed the rules and reloaded them, the kernel
gives
> > a damn about it and ignores the new rules. For example I had udp
2300:2400
> > directed to 10.0.1.50. I changed it in the script (so that it directs
them
> > to 10.0.1.20) and reloaded it. Still on tcpdump I could see that the
> > packets went to 10.0.1.50 and not 10.0.1.20 where they should be going
now!
>
> This is completly normal, because of connection tracking.
> Only the first udp packet is adjusted by the DNAT rule, after this every
> packet, after this the kernel "remembers" that there is a connection
between
> 10.0.1.20 and the (DS) server on the internet, and routes every packet
> automatically to your machine.
>
> copy & paste out off the iptables man page:
>
>    DNAT
>        This  target is only valid in the nat table, in the PREROUTING and
> OUTPUT chains, and user-defined chains which are only
>        called from those chains.  It specifies that the destination
address
> of the packet should be modified  (and  all  future
>        packets in this connection will also be mangled), and rules should
> cease being examined.  It takes one option:
>
> sorry, but i don't have any idea what you could do about it.
>
> cu, Christian Koenig.

Hi,

Thanks for your explanation.
Still I think masquerading has to be automatically done without specifying
DNAT rules, because an outgoing connection was already established.
When the kernel routes 10.0.1.20.2302 to myfriend.6073 then actually packets
from myfriend.6073 should be routed to 10.0.1.20.2302, not?
If it werent so I could not surf the net from my lan because basically its
the same. 10.0.1.20.someport is routed to wwwserver.80 and back without
problems.
I can play other games just fine aswell over the internet.

Besides, I think the thing with connection tracking isnt all that good when
the kernel doesnt recognize changed rules. Shouldnt changed rules lead to
changed behaviour?

Sincerely,
Andreas

