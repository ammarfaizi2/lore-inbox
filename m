Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbUC2WDR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUC2WDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:03:17 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:57473 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S263152AbUC2WDK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:03:10 -0500
Message-ID: <40689E95.7010108@tmr.com>
Date: Mon, 29 Mar 2004 17:09:25 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Jad Saklawi <jad@saklawi.info>, linux-kernel@vger.kernel.org,
       hisham@hisham.cc, llug-users@greencedars.org
Subject: Re: Fwd: MAC / IP conflict
References: <405D239B.30602@mail.portland.co.uk> <40679ED8.1060502@tmr.com> <20040329045942.GC1276@alpha.home.local>
In-Reply-To: <20040329045942.GC1276@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hi,
> 
> On Sun, Mar 28, 2004 at 10:58:16PM -0500, Bill Davidsen wrote:
> 
>>Jad Saklawi wrote:
>>
>>>----- Forwarded message from Hisham Mardam Bey -----
>>>  Date: Sun, 21 Mar 2004 13:52:59 +0200
>>>
>>>In short, I need to detect when someone on the network uses my MAC and
>>>my IP address.
>>>
>>>Longer story follows. I am on a LAN which might have some potentially
>>>dangerous users. Those users might spoof my MAC address and additionally
>>>use my IP address, thus forcing my box to go offline, and not be able to
>>>communicate with my gateway. What I need is a passive way to check for
>>>something of the sort, and perhaps a notofication into syslog (the
>>>latter is not very important).
>>
>>Use arpwatch, it detects ALL changes of IP<=>MAC mapping.
> 
> 
> It won't tell him when someone else uses both IP and MAC. The real solution
> is to lock the MAC on the switch if possible. Another one is to use a second
> host to launch regular ARP requests and count how many replies it gets. Note
> that it is also possible to do this from his host, but he will need arping
> and tcpdump in promiscuous mode, because the reply address will have to be
> a fake one (MAC and IP) so that the switch forwards the reply on all ports.

If he sees the packet it should alert on the local MAC or IP on an 
external packet. As noted you won't get the external packet in all cases.
> 
> Completely passive solution will not always detect the event. The attacker
> might send packets to another host or even to the switch itself, which will
> not propagate to other ports (eg: ethernet loopback with SA=DA= his MAC).
> But if they make a mistake, then listening to all incoming packets and logging
> their source MAC when it's the same as his host might work. This can be
> implemented very easily with arptables but just for ARP requests. ebtables
> might be better suited, but needs to configure a bridge which is dangerous.

I like the idea of sending ARP after changing the MAC. I would hope to 
have an option in the switch which prevents MAC takeover by locking the 
MAC to a port as long as the link is up. This doesn't prevent sending a 
packet to another host with the real (evil) MAC and spoofed IP, to set 
the arptable in a single host. In the long run help from the switch is 
probably needed to do it right.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
