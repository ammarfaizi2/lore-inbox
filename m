Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964769AbVL3Qwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964769AbVL3Qwb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 11:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbVL3Qwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 11:52:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19135 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964769AbVL3Qwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 11:52:30 -0500
Date: Fri, 30 Dec 2005 08:51:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: gcoady@gmail.com, Lee Revell <rlrevell@joe-job.com>,
       Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] latency tracer, 2.6.15-rc7
In-Reply-To: <20051230080914.GA26643@elte.hu>
Message-ID: <Pine.LNX.4.64.0512300849590.3298@g5.osdl.org>
References: <1135726300.22744.25.camel@mindpipe>
 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
 <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu>
 <20051229100233.GA12056@redhat.com> <20051229101736.GA2560@elte.hu>
 <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe>
 <20051229202848.GC29546@elte.hu> <u8u8r1ttmtubpvd87sf9mq4fi2of0l6js4@4ax.com>
 <20051230080914.GA26643@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Dec 2005, Ingo Molnar wrote:
> 
> have you applied the zlib patches too? In particular this one should 
> make a difference:
> 
>     http://redhat.com/~mingo/latency-tracing-patches/patches/reduce-zlib-stack-hack.patch
> 
> If you didnt have this applied, could you apply it and retry with 
> stack-footprint-debugging again?

Ingo, instead of having a static work area and using locking, why not just 
move those fields into the "z_stream" structure, and thus make them be 
per-stream? The z_stream structure should already be allocated with 
kmalloc() or similar by the caller, so that also gets it off the stack 
without the locking thing.

Hmm?

		Linus
