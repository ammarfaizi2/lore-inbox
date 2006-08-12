Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbWHLPJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWHLPJR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 11:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWHLPJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 11:09:17 -0400
Received: from av5835.comex.ru ([217.10.43.53]:1015 "EHLO irc.inctv.ru")
	by vger.kernel.org with ESMTP id S964855AbWHLPJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 11:09:16 -0400
From: Innocenti Maresin <qq@inCTV.ru>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Q: remapping IP addresses for inbound and outbound traffic
Message-ID: <LKML-nat-0.qq@inCTV.ru>
Content-Type: text/plain; charset=US-ASCII; Format=Flowed
Date: Sat, 12 Aug 2006 11:09:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! 

Let one Linux box have two interfaces to IPv4 networks, 
and for some IP both networks have the host with this IP address, e.g. from RFC1918. 
Or even both use the same IPv4 address block. 
We can say that one IP from the first network 
and numerically the same IP from the second "means" different hosts. 

The software of this box needs to connect all hosts in both networks, 
and also to receive inbound TCP connections. 
The evident way is to "remap" overlapping IPv4 area of one network 
to some "place" not used neither in it nor in other. 
This means that, when we receive a packet from remapped area, 
the kernel should replace the source IP to an "internal representaion". 
Versa, sending something to "internally represented" IP 
the kernel should replace such IP by its external value. 
I clarify these terms so carefully because in news:comp.os.linux.networking 
some people state that I "use terms in strange ways" :) 

The question is: how to do it? 
Please, don't say quicky "iproute2" and "RTFM". 
Iproute2 can do such things when *forwarding* packets. 
I need no forwarding at all, no *connection* between 2 networks. 
I need only to *serve* both networks, 
such that some "external" IPs need to be replaced by internally used IP and versa. 
All this at one Linux box.
No forwarding traffic. Only inbound and outbound. 

So, suppose that I try to use FastNAT/iproute2 on Linux 2.4, 
a "dummy NAT address" is an "internally represented" in my terms, 
and "via" address (in iproute2 terms) is my "external". 
Then, by iproute2 idiots' design, I can't locally send packet 
to so named "dummy NAT address". 
I even can't use connect() on it, the kernel says "Invalid argument". 
So, I really can't use my "internal addresses". 

Ipfilter also cannot solve this problem. 
There is no means to translate inbound packets' source address 
(there is no INPUT chain in -t nat and PREROUTING can't do SNAT), 
but services need to see packets as coming from internally represented IP. 


There is some more or less trivial ideas:

* Use IPv6 (IMHO it's possible, but I seek yet for simpler solution);

* Use extra hardware - I am not willing to do so for many reasons;

* Read docs more carefully ;) - I read relevant ip-cref sections, 
 but FastNAT feature is poorly documented in this Kuznetsov's paper, 
 many anothers docs cite Kuznetsov and generally give even less details;

* Modify the kernel sources - Of course, I will, 
 but it's not evident for me that the trouble caused by some few errors, 
 I'm not sure that kernel may use a "dummy NAT address" 
 as destination of locally generated packets without major changes.


Maybe, somebody knows about "non-official" kernel patches?

P.S. please send me Cc when replying to this message.


-- 

qq~~~~\
/ /\   \
\  /_/ /
 \____/
