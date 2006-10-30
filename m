Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965274AbWJ3WUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965274AbWJ3WUB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 17:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965349AbWJ3WUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 17:20:01 -0500
Received: from mx3.cs.washington.edu ([128.208.3.132]:26079 "EHLO
	mx3.cs.washington.edu") by vger.kernel.org with ESMTP
	id S965274AbWJ3WUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 17:20:00 -0500
Date: Mon, 30 Oct 2006 14:19:39 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org,
       Michael Hipp <Michael.Hipp@student.uni-tuebingen.de>,
       Karsten Keil <kkeil@suse.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>,
       isdn4linux@listserv.isdn4linux.de, starvik@axis.com, dev-etrax@axis.com
Subject: Re: [PATCH] ISDN: Avoid a potential NULL ptr deref in ippp
In-Reply-To: <200610302117.24760.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64N.0610301410350.17544@attu2.cs.washington.edu>
References: <200610302117.24760.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006, Jesper Juhl wrote:

> 
> There's a potential problem in isdn_ppp.c::isdn_ppp_decompress().
> dev_alloc_skb() may fail and return NULL. If it does we will be passing a
> NULL skb_out to ipc->decompress() and may also end up
> dereferencing a NULL pointer at 
>     *proto = isdn_ppp_strip_proto(skb_out);
> Correct this by testing 'skb_out' against NULL early and bail out.
> 

Good catch.  There's also been a potential NULL pointer on 
etrax_ethernet_init in drivers/net/cris/eth_v10.c.  RxDescList[i].skb 
calls dev_alloc_skb and does not check its return value before 
dereferencing it for the RxDescList[i].descr.buf virt_to_phys conversion.

(Mikael Starvik Cc'd)

		David
