Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVLKUC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVLKUC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 15:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVLKUC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 15:02:59 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:52379 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750783AbVLKUC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 15:02:58 -0500
Date: Sun, 11 Dec 2005 21:02:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm] fix SLOB on x64
Message-ID: <20051211200203.GA19322@elte.hu>
References: <20051211141217.GA5912@elte.hu> <20051211180551.GW8637@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211180551.GW8637@waste.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Matt Mackall <mpm@selenic.com> wrote:

> On Sun, Dec 11, 2005 at 03:12:17PM +0100, Ingo Molnar wrote:
> > 
> > this patch fixes 32-bitness bugs in mm/slob.c. Successfully booted x64 
> > with SLOB enabled. (i have switched the PREEMPT_RT feature to use the 
> > SLOB allocator exclusively, so it must work on all platforms)
> 
> The patch looks fine, but what's this about using SLOB exclusively?  
> Fragmentation performance of SLOB is miserable on anything like a 
> modern desktop, I think SLOB only makes sense for small machines. The 
> locking also suggests dual core at most.

well, this is only an -rt artifact: the SLOB needs zero modifications to 
work on PREEMPT_RT, while SLAB needed a risky 66K monster patch. Until 
someone simplifies the SLAB conversion to PREEMPT_RT, i'll use the SLOB.

i havent noticed any significant slowdown due to the SLOB. In any case, 
we'll give it some workout which should further speed up its upstream 
integration - it's looking good so far.

	Ingo
