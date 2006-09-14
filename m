Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWINXc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWINXc4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWINXcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:32:55 -0400
Received: from mercury.sdinet.de ([193.103.161.30]:11490 "EHLO
	mercury.sdinet.de") by vger.kernel.org with ESMTP id S932129AbWINXcz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:32:55 -0400
Date: Fri, 15 Sep 2006 01:32:53 +0200 (CEST)
From: Sven-Haegar Koch <haegar@sdinet.de>
To: xixi lii <xixi.limeng@gmail.com>
cc: Linux-Kernel-Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: UDP question.
In-Reply-To: <a885b78b0609140900x385c9453n9ef25a936524dff7@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609150129150.21941@mercury.sdinet.de>
References: <a885b78b0609140900x385c9453n9ef25a936524dff7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006, xixi lii wrote:

> This result can't satisfy me, so I add another network adapter, and
> try the code blow:
>
> //////
> socket1 = socket(AF_INET, SOCK_DGRAM, .....)
> socket2 = socket(AF_INET, SOCK_DGRAM, .....)
> bind socket1.network adapter1...
> bind socket2 network adapter2
> time = time(NULL);
> while (1)
> {
> sendto(socket1, "", 1, 0, dstaddr1, addrlen);
> sendto(socket2, "", 1, 0, dstaddr2, addrlen);
> count += 2;
> }
> time = time(NULL) - time;
> avg = count / time;
> ///////////////////
>
> But I get the result is also 75000 packet per second, WHY?


> It look like that when send a packet to bond dev, bond use current
> slave and send packet, then change current slave to next. What is the
> essence different between the bond and my code (use two network
> adapters)?
>
> Any suggestions?

I am not really sure, but I think the bind to an adapter under linux only 
chooses the source ip, not really the adapter used to send the packets.

Did you check that the two destination ips have routes through different 
interfaces, and not go out through the same one?

(You should even be able to verify this with tcpdump, if you get packets 
on one interface and nothing on the second)

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)
