Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWH2IJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWH2IJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 04:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWH2IJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 04:09:16 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:55002 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751191AbWH2IJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 04:09:14 -0400
Date: Tue, 29 Aug 2006 10:07:48 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Innocenti Maresin <qq@inCTV.ru>
cc: LKML <linux-kernel@vger.kernel.org>, netfilter@netfilter.org
Subject: Re: Q: remapping IP addresses for inbound and outbound traffic
In-Reply-To: <LKML-nat-0.qq@inCTV.ru>
Message-ID: <Pine.LNX.4.61.0608291001030.5247@yvahk01.tjqt.qr>
References: <LKML-nat-0.qq@inCTV.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>The software of this box needs to connect all hosts in both networks, and
>also to receive inbound TCP connections.  The evident way is to "remap"
>overlapping IPv4 area of one network to some "place" not used neither in it
>nor in other.  This means that, when we receive a packet from remapped area,
>the kernel should replace the source IP to an "internal representaion". 
>Versa, sending something to "internally represented" IP the kernel should
>replace such IP by its external value.  I clarify these terms so carefully
>because in news:comp.os.linux.networking some people state that I "use terms
>in strange ways" :)
>
>The question is: how to do it? Please, don't say quicky "iproute2" and
>"RTFM".  Iproute2 can do such things when *forwarding* packets.  I need no
>forwarding at all, no *connection* between 2 networks.  I need only to
>*serve* both networks, such that some "external" IPs need to be replaced by
>internally used IP and versa.  All this at one Linux box. No forwarding
>traffic. Only inbound and outbound.

I am working on a small module doing something like that, changing IP 
addresses before the NAT code sees them, in mangle.

  http://jengelh.hopto.org/f/xt_MAP-v0.tar.bz2

I still cannot get outgoing mangled packets (see command below) to reach 
their destination:

  iptables -t mangle -A POSTROUTING -d 134.76.13.21 -j MAP \
    --map-dest 134.76.13.28

ping and TCP packets seem to leave the box (tcpdump), but there are no 
responses (neither negative responses). The destination box's tcpdump also 
shows nothing.
netfilter list, am I missing something like recalculating IP checksums?



Jan Engelhardt
-- 
