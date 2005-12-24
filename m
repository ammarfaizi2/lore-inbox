Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVLXT6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVLXT6o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 14:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVLXT6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 14:58:44 -0500
Received: from mail.dvmed.net ([216.237.124.58]:455 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750704AbVLXT6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 14:58:43 -0500
Message-ID: <43ADA862.6010906@pobox.com>
Date: Sat, 24 Dec 2005 14:58:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Manfred Spraul <manfred@colorfullife.com>,
       Ayaz Abdulla <AAbdulla@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] forcedeth: fix random memory scribbling bug
References: <43AD4ADC.8050004@colorfullife.com> <Pine.LNX.4.64.0512241145520.14098@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512241145520.14098@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Linus Torvalds wrote: > However, that > > "skb->end -
	skb->data" > > calculation is a bit strange. It correctly maps the
	whole skb, but nod > wouldn't it make more sense to use the length we
	actually tell the card to > use? > > In other words, wouldn't it be a
	whole lot more sensible and logical to > use > > np->rx_buf_sz > >
	instead? That's the value we use for allocation and that's the size we
	> tell the card we have. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> However, that
> 
> 	"skb->end - skb->data"
> 
> calculation is a bit strange. It correctly maps the whole skb, but 

nod


> wouldn't it make more sense to use the length we actually tell the card to 
> use? 
> 
> In other words, wouldn't it be a whole lot more sensible and logical to 
> use
> 
> 	np->rx_buf_sz
> 
> instead? That's the value we use for allocation and that's the size we 
> tell the card we have.

That's the sort of thing I prefer.


> Of course, on the alloc path, it seems to add an additional 
> "NV_RX_ALLOC_PAD" thing, so maybe the "end-data" thing makes sense.

None of the other ethernet drivers do 'end - data', which is why I 
hesitated quite a bit on this change.

	Jeff


