Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbUCJR6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 12:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUCJR6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 12:58:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20369 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262725AbUCJR6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 12:58:41 -0500
Message-ID: <404F5744.1040201@pobox.com>
Date: Wed, 10 Mar 2004 12:58:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Intersil Prism54 wireless driver
References: <20040304023524.GA19453@bougret.hpl.hp.com> <20040310165548.A24693@infradead.org> <20040310172114.GA8867@bougret.hpl.hp.com> <404F5097.4040406@pobox.com> <20040310175200.GA9531@bougret.hpl.hp.com>
In-Reply-To: <20040310175200.GA9531@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> 	You misunderstood. The HostAP driver has a pretty much
> complete generic 802.11 stack. However, other driver can't depend on
> that code until it's in the kernel.
> 	By "big 802.11 reorg", I meant "make the other driver depend
> on HostAP 802.11 code".
> 	Of course, I'm quite partial to the HostAP code because I'm
> more familiar with it and I believe it's the most advanced (host WEP,
> 802.1x, WPA, AP...). Other candidated are linux-wlan-ng or the *BSD
> stack (by the way of the MadWifi driver).

Ah!  I did indeed misunderstand.

Yes, it would be good to end the cycle of re-implementing 802.11 over 
and over again ;-)

So here is my suggested plan:
* I merge prism54 upstream
* I create wireless-2.6 queue
* somebody (you, Jouni(sp?)) submits HostAP to me
* I merge HostAP
* submit rtnetlink patches to me
* start working on generic 802.11 stack in wireless-2.6 queue
* at the same time, migrate away from iw_handler to "wireless_ops" (i.e. 
something like ethtool_ops)
* once things have stabilized again, merge upstream

I'm not sure about the order of the last few steps, you know better than 
I what dependencies exist.

	Jeff



