Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVFETxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVFETxu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 15:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVFETxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 15:53:50 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57527
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261361AbVFETxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 15:53:48 -0400
Date: Sun, 05 Jun 2005 12:52:49 -0700 (PDT)
Message-Id: <20050605.125249.104050648.davem@davemloft.net>
To: nickpiggin@yahoo.com.au
Cc: herbert@gondor.apana.org.au, mbligh@mbligh.org, jschopp@austin.ibm.com,
       mel@csn.ul.ie, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy
 Version 12
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42A10ED2.7020205@yahoo.com.au>
References: <E1DeNiA-0008Ap-00@gondolin.me.apana.org.au>
	<42A10ED2.7020205@yahoo.com.au>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Sat, 04 Jun 2005 12:15:46 +1000

> Herbert Xu wrote:
> > With Dave's latest super-TSO patch, TCP over loopback will only be
> > doing order-0 allocations in the common case.  UDP and others may
> > still do large allocations but that logic is all localised in
> > ip_append_data.
> > 
> > So if we wanted we could easily remove most large allocations over
> > the loopback device.
> 
> I would be very interested to look into that. I would be
> willing to do benchmarks on a range of machines too if
> that would be of any use to you.

Even without the super-TSO patch, we never do larger than
PAGE_SIZE allocations for sendmsg() when the device is
scatter-gather capable (as indicated in netdev->flags).

Loopback does set this bit.

This PAGE_SIZE limit comes from net/ipv4/tcp.c:select_size().
