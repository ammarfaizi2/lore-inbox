Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTHSIUB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 04:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbTHSIUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 04:20:01 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:24078 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S263752AbTHSIT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 04:19:56 -0400
Message-ID: <05f501c3662a$9ba72d30$c801a8c0@llewella>
From: "Bas Bloemsaat" <bloemsaa@xs4all.nl>
To: "Bill Davidsen" <davidsen@tmr.com>, "David S. Miller" <davem@redhat.com>
Cc: "Willy Tarreau" <willy@w.ods.org>, <alan@lxorguk.ukuu.org.uk>,
       <carlosev@newipnet.com>, <lamont@scriptkiddie.org>,
       <marcelo@conectiva.com.br>, <netdev@oss.sgi.com>,
       <linux-net@vger.kernel.org>, <layes@loran.com>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1030818171100.2101C-100000@gatekeeper.tmr.com>
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Date: Tue, 19 Aug 2003 09:58:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Okay, I'll show my ignorance and ask... the Documentation for arp_filter
> says source routing must be used. Is there some flag I'm missing, or a way
> to avoid having a rule per address, or is the 8 bit rule number larger in
> 2.6, or ??? Or is having a lot of IPs on one machine not an imaginable
> case?

I'll include a conversation I had with David, yesterday. Maybe it clear
things up:

Someone: Replying again... Alan does mention in the paragraph you've quoted
Someone: to use arpfilter, which works for every case imaginable.

Me: No it doesn't. When I have two nics on DHCP on the same ethernet
segment, it
M: cannot be made to work. I don't know the ip addresses beforehand. And if
if
M: I would get them with scripting and crafted some rules on the fly,
there's
M: no way I can be sure I'll get the same IP's on a renew, so I'd have to
check
M: often.

David: You don't understand how 'arpfilter' works.
D: It's a netfilter module that allows you to block ARP packets
D: going in and out of the system using any criteria you want.
D: It can block on device, on src MAC address, on destination
D: MAC address, whatever you want.

Me: Maybe you could explain to me how to filter out all ARP
M: responses to an IP not bound to that mac address, of letting through all
the
M: ARP responses for an IP bound to that mac, without specifying the IP
address
M: (because that can change, sometimes quite often). I really do not see it.

D: You wouldn't use 'arpfiler' for that.

D: You would use the 'arp_filter' sysctl on your devices and
D: proper setting of the preferred source in the routes on
D: your machine.

M: For that I'd still need the IP address. Don't I? And I don't have that
until
M: later, and it is prone to change.
M: So I have a feeling you are sending me in circles.

D: You need to change routes when the IP address changes, so all I'm
D: asking you to do is setup your routes correctly at those points
D: in time.

M: Which is on dhcp renew. Which calls for a rewrite of dhcpclient, or a
daemon
M: that monitors it.

D: Sure, if software is setting routes manually and it isn't
D: doing so the way you want it to it'll need changes.

In other words: it keeps being done the way it is now, never mind people
having problems with it. Never mind the changing it doesn't break anything.
Never mind I cannot come up with a scenario that actually benefits from the
current situation over the new situation.

IP Multipathing does not qualify. The current way actually violates IP
multipathing: Multipathing calls for two seperate, fixed internal IP's which
are seperated from each other. Multipathing requires you to restore the IP
address to it's preferred interface if it comes up again. In multipathing,
all IP's have preferred interfaces, not one left by chance. Remember that
multipathing doesn't need to be symmetric. It may very way have a fat pipe
on one end, and a smaller backup pipe.

All of this is not satisfied with the current, broken, linux arp. So we're
still short of an example that benefits from the current situation

Regards,
Bas


