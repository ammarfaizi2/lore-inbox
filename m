Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbTEFISU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 04:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTEFIRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 04:17:49 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:54406 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S262430AbTEFIRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 04:17:23 -0400
From: Rusty Russell <rusty@au1.ibm.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] kmalloc_percpu 
In-reply-to: Your message of "Tue, 06 May 2003 10:37:44 +0530."
             <20030506050744.GA29352@in.ibm.com> 
Date: Tue, 06 May 2003 18:03:15 +1000
Message-Id: <20030506082949.F2A3217DE0@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030506050744.GA29352@in.ibm.com> you write:
> On Mon, May 05, 2003 at 08:46:58AM +0000, Andrew Morton wrote:
> Andrew,
> Here is a comparision of kmalloc_percpu techniques as I see it,
> 
> Current Implementation:
> 1. Two dereferences to get to the per-cpu data 
> 2. Allocates for cpu_possible cpus only, and can deal with sparse cpu nos
>  
> Rusty's Implementation
> 1. One extra memory reference (__per_cpu_offset) 
> 2. allocates for NR_CPUS and probably breaks with sparse cpu nos?
> 3. Let you do per-cpu data in modules
> 4. fragmentation

And #3 is, in fact, the one I care about.  The extra memory reference
is already probably cachehot (all static per-cpu use it), and might be
in a register on some archs.

Doesn't break with sparce CPU #s, but yes, it is inefficient.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
