Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266819AbSKHRWK>; Fri, 8 Nov 2002 12:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266822AbSKHRWJ>; Fri, 8 Nov 2002 12:22:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32516 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266819AbSKHRWI>; Fri, 8 Nov 2002 12:22:08 -0500
Date: Fri, 8 Nov 2002 09:28:39 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: William Lee Irwin III <wli@holomorphy.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       <linux-ia64@linuxia64.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       <rusty@rustcorp.com.au>, <dhowells@redhat.com>, <mingo@elte.hu>
Subject: Re: [Linux-ia64] reader-writer livelock problem
In-Reply-To: <Pine.LNX.4.44.0211080918220.4298-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0211080927050.4298-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Nov 2002, Linus Torvalds wrote:
> 
> NOTE! I'm not saying the existing practice is necessarily a good tradeoff,
> and maybe we should just make sure to find all such cases and turn the
> read_lock() calls into read_lock_irqsave() and then make the rw-locks
> block readers on pending writers. But it's certainly more work and cause
> for subtler problems than just naively changing the rw implementation.

Actually, giving this som emore thought, I really suspect that the
simplest solution is to alloc a separate "fair_read_lock()", and paths
that need to care about fairness (and know they don't have the irq issue)  
can use that, slowly porting users over one by one...

		Linus

