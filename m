Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269249AbRHGSGU>; Tue, 7 Aug 2001 14:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269248AbRHGSGJ>; Tue, 7 Aug 2001 14:06:09 -0400
Received: from Huntington-Beach.Blue-Labs.org ([208.179.59.198]:1898 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S269249AbRHGSGA>; Tue, 7 Aug 2001 14:06:00 -0400
Message-ID: <3B702E09.8030207@blue-labs.org>
Date: Tue, 07 Aug 2001 14:06:01 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: landley@webofficenow.com
CC: linux-kernel@vger.kernel.org
Subject: Re: RP_FILTER runs too late
In-Reply-To: <3B6F8E17.9090100@blue-labs.org> <01080620523409.04153@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh I have it working, there is just one workaround requirement and one 
nit with rp_filter.  rp_filter has to be disabled and that is an SNAT 
item.  The workaround for a "pre-routing" snat is to setup ip route 
rules, tag the packets, and finally nat them.  It accomplishes the task 
I need but is in my opinion a hack.

I'd rather see SNAT available in pre-routing and have rp_filter run 
against the packet before it hits the netfilter code.

-d

Rob Landley wrote:

>On Tuesday 07 August 2001 02:43, David Ford wrote:
>
>>I finally figured out why my SNAT setup wasn't working.  I had 1 in
>>eth0/rp_filter and that was silently breaking it.
>>
>>This discussion follows the scripts located at website
>>http://blue-labs.org/ , rc.networking and rc.firewalling.  Both are live
>>meaning you'll see any changes I make.
>>
>>Here's the scoop.  I run a VPN from here to my colo server...but I don't
>>want all my traffic going through the VPN.  So I need to finagle a
>>method of NAT.  Now because the NAT code runs behind the routing code,
>>packets are already heading the wrong direction when they get their
>>headers changed.  Because of that you need to tag them with a mark and
>>implement routing rules based on that mark.  As an aside note, all that
>>could be avoided if SNAT would just be available in PREROUTING.
>>
>>Ok. Now that packets are flowing through the right interfaces, things
>>look good but wait...the reply packets are vanishing without a trace.
>>
>>The culprit is the rp_filter on eth0.  The packet comes in, gets the
>>header rewritten then gets chomped by rp_filter.  I'm not quite sure why
>>because the src is still an external IP and the destination before and
>>after is still an internal IP.
>>
>>Wouldn't the rp_filter be more effective if it came ahead of the nat
>>code?  As it is now, it's useless on that interface.
>>
>>David
>>
>
>I just put up some firewall rules as part of the Dynamic Virtual Private 
>Networking project on sourceforge at http://dvpn.sourceforge.net.  It shows 
>both source and destination nat, port forwarding outside of a box, and a 
>couple other fun goodies.  Not necessarily your kind of VPN, but maybe it'll 
>help...
>
>I'm not sure what you're trying to do, but I got everything I tried to work...
>
>Rob
>



