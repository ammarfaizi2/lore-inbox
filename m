Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965190AbVLOJEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbVLOJEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbVLOJEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:04:11 -0500
Received: from mail.suse.de ([195.135.220.2]:24197 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932494AbVLOJEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:04:09 -0500
Date: Thu, 15 Dec 2005 10:04:01 +0100
From: Andi Kleen <ak@suse.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: "David S. Miller" <davem@davemloft.net>, sri@us.ibm.com, mpm@selenic.com,
       ak@suse.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC] Fine-grained memory priorities and PI
Message-ID: <20051215090401.GV23384@wotan.suse.de>
References: <20051215033937.GC11856@waste.org> <20051214.203023.129054759.davem@davemloft.net> <Pine.LNX.4.58.0512142318410.7197@w-sridhar.beaverton.ibm.com> <20051215.002120.133621586.davem@davemloft.net> <9E6D85FF-E546-4057-80EF-7479021AFAA1@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9E6D85FF-E546-4057-80EF-7479021AFAA1@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When processes request memory through any subsystem, their memory  
> priority would be passed through the kernel layers to the allocator,  
> along with any associated information about how to free the memory in  
> a low-memory condition.  As a result, I could configure my database  
> to have a much higher priority than SETI@home (or boinc or whatever),  
> so that when the database server wants to fill memory with clean DB  
> cache pages, the kernel will kill SETI@home for it's memory, even if  
> we could just leave some DB cache pages unfaulted.

Iirc most of the freeing happens in process context anyways,
so process priority information is already available. At least
for CPU cost it might even be taken into account during schedules
(Freeing can take up quite a lot of CPU time)

The problem with GFP_ATOMIC is though that someone else needs
to free the memory in advance for you because you cannot
do it yourself. 

(you could call it a kind of "parasite" in the normally
very cooperative society of memory allocators ...) 

That would mess up your scheme too. The priority 
cannot be expressed because it's more a case of 
"somewhen someone in the future might need it" 

> 
> Questions? Comments? "This is a terrible idea that should never have  
> seen the light of day"? Both constructive and destructive criticism  
> welcomed! (Just please keep the language clean! :-D)

This won't help for this problem here - even with perfect
priorities you could still get into situations where you
can't make any progress if progress needs more memory.

Only preallocating or prereservation can help you out of 
that trap.

-Andi

