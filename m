Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUH1C1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUH1C1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 22:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268102AbUH1C1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 22:27:48 -0400
Received: from 67.107.199.112.ptr.us.xo.net ([67.107.199.112]:51192 "EHLO
	hathawaymix.org") by vger.kernel.org with ESMTP id S266155AbUH1C1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 22:27:47 -0400
From: Shane Hathaway <shane@hathawaymix.org>
To: Chris Leech <chris.leech@gmail.com>
Subject: Re: [PATCH] e1000 rx buffer allocation
Date: Fri, 27 Aug 2004 20:27:48 -0600
User-Agent: KMail/1.6.2
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.60.0408261727170.9545@orangutan.jungle> <20040826181843.342da7a3.davem@redhat.com> <41b516cb04082711363a009dbc@mail.gmail.com>
In-Reply-To: <41b516cb04082711363a009dbc@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408272027.49059.shane@hathawaymix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 August 2004 12:36 pm, Chris Leech wrote:
> As for moving the allocations out of the hard interrupt context, e1000
> was one of several drivers that tried that a few years back by using
> tasklets.  What I found is that if you split the allocation from the
> receive processing, it's far to easy to generate an interrupt load
> which starves the skb allocations.  The result is that you
> continuously use all of the buffers then stall while they all get
> replaced, and performance is horrible.  But if the patch works for
> your network load ...

We're getting 6000 interrupts per second, but the box handles it with ease.  
We're getting zero loss now, but I guess with slower hardware or fewer 
buffers, scheduling would be a problem.

> A better approach for improving jumbo frame allocations might be to
> use multiple smaller buffers for each receive, something the PRO/1000
> hardware can do but the e1000 driver has never taken advantage of.

Yes, that would be a far better solution.  I had no idea the card could do 
that.  Are there specs on this hardware somewhere?  Although my patch works, 
I don't want to stick with a temporary solution.

Shane
