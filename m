Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTEGCUT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 22:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTEGCUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 22:20:18 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:22407 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S262793AbTEGCTB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 22:19:01 -0400
From: Rusty Russell <rusty@au1.ibm.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] kmalloc_percpu 
In-reply-to: Your message of "Tue, 06 May 2003 15:04:11 +0530."
             <20030506093411.GB29352@in.ibm.com> 
Date: Wed, 07 May 2003 12:14:22 +1000
Message-Id: <20030507023127.7F0D21966B@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030506093411.GB29352@in.ibm.com> you write:
> On Tue, May 06, 2003 at 06:03:15PM +1000, Rusty Russell wrote:
> > In message <20030506050744.GA29352@in.ibm.com> you write:
> > .. 
> > Doesn't break with sparce CPU #s, but yes, it is inefficient.
> > 
> 
> If you don't reduce NR_CPUS with CONFIG_NR_CPUS, you waste space (32
> bit folks won't like it) and if you say change CONFIG_NR_CPUS to 2,
> and we have cpuid 4 on a 2 way you break right?

You misunderstand, I think: on *all* archs, smp_processor_id() <
NR_CPUS is an axiom.  Always has been.

The generic solution involved cpu_possible(), but it's too early in
boot for that: attempts to make it a requirement have to change
numerous archs.  Not that I'm against that change...

Of course, an arch can override this default allocator, and may have
more info with which to do optimal allocation.

> If we have to address these issues at all, why can't we use the
> simpler kmalloc_percpu patch which I posted in the morning and avoid
> so much complexity and arch dependency?

Because we still need the __alloc_percpu for DECLARE_PER_CPU support
in modules 8(

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
