Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130105AbRATQaX>; Sat, 20 Jan 2001 11:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130391AbRATQaO>; Sat, 20 Jan 2001 11:30:14 -0500
Received: from pak145.pakuni.net ([205.138.121.145]:37362 "EHLO
	postal.paktronix.com") by vger.kernel.org with ESMTP
	id <S130105AbRATQaJ>; Sat, 20 Jan 2001 11:30:09 -0500
Date: Sat, 20 Jan 2001 10:24:15 -0600 (CST)
From: "Matthew G. Marsh" <mgm@paktronix.com>
To: depaan@bibleinfo.com
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4, iproute2 and routing rules that refuse to match
In-Reply-To: <0101181351280C.02284@orion>
Message-ID: <Pine.LNX.4.10.10101201012140.2187-100000@netmonster.pakint.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Andrew wrote:

> Greetings,

[snip]

Hi! 
 
> But when I ping 172.x.x.1, my router's address, I get nothing. Hopping
> over to the router's terminal and running tcpdump shows me that the packets
> are indeed arriving but they aren't making it. As it ends up, they are 

yes. Always will. Note that lo (loopback is a valid interface on the
system and that the systems IP addresses belong to the system not to the
interface. Having said that mouthfull let me illustrate:

ETH0 = 172.16.1.1/24

To appropriately route out all packets from the LOCAL machine (internal
responses) to ETH0 the following rule and route/table exist:

ip rule add from 172.16.1.1 dev lo table outeth0 prio 2000

ip route add 172.16.1.0/24 dev eth0 table outeth0 src 172.16.1.1 \
	 proto static

Or whatever default/network you would wish to add. The problem is that the
machine is trying to respond but you have no rule that permits the
response. BTW that is one of the reasons for the default rules.

> It's almost as if there is a bug in the rule matching code somewhere
> which doesn't properly handle this specific condition. But then again,
> why would this bug manifest itself across so many different kernels, including
> 2.4.0 in which I understand the networking has been completely rewritten?

No bug - just that the full scope of the policy routing (RPDB) changes are
quite fundamental WRT the "traditional" IP implementations. Alexey, etal,
actually do it "right" according to the RFC's and the sense of the
IPv4/v6 specifications.
 
> One important gotcha I found when testing is after every change you make,
> you have to run "ip route flush cache" to make it take effect. I've
> been down that road already, we're not dealing with that here.

yep.
 
> You can review my postings about this issue in the lartc advanced routing
> mailing list archives by looking through q4 of 2000 for the following
> subject lines:

hmmm - mebbe I should join that list... eh - I get too much mail now...
;-} 

> (http://mailman.ds9a.nl/pipermail/lartc/2000q4/author.html)
> 
> [LARTC] A complicated routing scenario (for me at least)  
> [LARTC] Backup Route   Andrew 
> [LARTC] A bug in ip?   Andrew 
> [LARTC] simple routing problem... (what am I missing?)   Andrew 
> [LARTC] Can't one filter based on a single destination address?   Andrew 
> [LARTC] Advanced Routing problem (Can someone PLEASE answer this!)   Andrew 
> 
> Thanks in advance for any help. If this advanced routing is going to be of
> any use to me, I need to get this resoved. The only other option I know of
> is to buy another $10,000 cisco router (not very appealing to say the least).

Npt needed - I have a router (P90/64M) with 6 interfaces (3 Internet, 2
LAN, 1 Wireless) that is doing wierder things than that... Works very
well.

> -Andrew

Hate to bang a drum in public so if you would like a good reference to a
book on this subject email me directly. 

--------------------------------------------------
Matthew G. Marsh,  President
Paktronix Systems LLC
1506 North 59th Street
Omaha  NE  68104
Phone: (402) 932-7250
Email: mgm@paktronix.com
WWW:  http://www.paktronix.com
--------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
