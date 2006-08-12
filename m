Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbWHLPmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWHLPmU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 11:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbWHLPmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 11:42:20 -0400
Received: from smtp8.libero.it ([193.70.192.92]:913 "EHLO smtp8.libero.it")
	by vger.kernel.org with ESMTP id S932551AbWHLPmT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 11:42:19 -0400
From: "Giampaolo Tomassoni" <g.tomassoni@libero.it>
To: "LKML" <linux-kernel@vger.kernel.org>
Subject: R: remapping IP addresses for inbound and outbound traffic
Date: Sat, 12 Aug 2006 17:42:20 +0200
Message-ID: <NBBBIHMOBLOHKCGIMJMDOEBFFMAA.g.tomassoni@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-reply-to: <LKML-nat-0.qq@inCTV.ru>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess you can't do this, since a believe there is a single linux arp table. It is not per-interface.

If you had hosts with unique IPs on both nets, that would be another story: you could use some sort of VPN or Bridge functionality. You could also be able to avoid packets passing through the bridged/VPNed interfaces thanks to iptables.

Cheers,

Giampaolo

> -----Messaggio originale-----
> Da: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]Per conto di Innocenti
> Maresin
> Inviato: sabato 12 agosto 2006 17.09
> A: LKML
> Oggetto: Q: remapping IP addresses for inbound and outbound traffic
> 
> 
> Hello! 
> 
> Let one Linux box have two interfaces to IPv4 networks, 
> and for some IP both networks have the host with this IP address, 
> e.g. from RFC1918. 
> Or even both use the same IPv4 address block. 
> We can say that one IP from the first network 
> and numerically the same IP from the second "means" different hosts. 
> 
> The software of this box needs to connect all hosts in both networks, 
> and also to receive inbound TCP connections. 
> The evident way is to "remap" overlapping IPv4 area of one network 
> to some "place" not used neither in it nor in other. 
> This means that, when we receive a packet from remapped area, 
> the kernel should replace the source IP to an "internal representaion". 
> Versa, sending something to "internally represented" IP 
> the kernel should replace such IP by its external value. 
> I clarify these terms so carefully because in 
> news:comp.os.linux.networking 
> some people state that I "use terms in strange ways" :) 
> 
> The question is: how to do it? 
> Please, don't say quicky "iproute2" and "RTFM". 
> Iproute2 can do such things when *forwarding* packets. 
> I need no forwarding at all, no *connection* between 2 networks. 
> I need only to *serve* both networks, 
> such that some "external" IPs need to be replaced by internally 
> used IP and versa. 
> All this at one Linux box.
> No forwarding traffic. Only inbound and outbound. 
> 
> So, suppose that I try to use FastNAT/iproute2 on Linux 2.4, 
> a "dummy NAT address" is an "internally represented" in my terms, 
> and "via" address (in iproute2 terms) is my "external". 
> Then, by iproute2 idiots' design, I can't locally send packet 
> to so named "dummy NAT address". 
> I even can't use connect() on it, the kernel says "Invalid argument". 
> So, I really can't use my "internal addresses". 
> 
> Ipfilter also cannot solve this problem. 
> There is no means to translate inbound packets' source address 
> (there is no INPUT chain in -t nat and PREROUTING can't do SNAT), 
> but services need to see packets as coming from internally 
> represented IP. 
> 
> 
> There is some more or less trivial ideas:
> 
> * Use IPv6 (IMHO it's possible, but I seek yet for simpler solution);
> 
> * Use extra hardware - I am not willing to do so for many reasons;
> 
> * Read docs more carefully ;) - I read relevant ip-cref sections, 
>  but FastNAT feature is poorly documented in this Kuznetsov's paper, 
>  many anothers docs cite Kuznetsov and generally give even less details;
> 
> * Modify the kernel sources - Of course, I will, 
>  but it's not evident for me that the trouble caused by some few errors, 
>  I'm not sure that kernel may use a "dummy NAT address" 
>  as destination of locally generated packets without major changes.
> 
> 
> Maybe, somebody knows about "non-official" kernel patches?
> 
> P.S. please send me Cc when replying to this message.
> 
> 
> -- 
> 
> qq~~~~\
> / /\   \
> \  /_/ /
>  \____/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

