Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTI3IBi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 04:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbTI3IBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 04:01:38 -0400
Received: from dyn-ctb-210-9-243-176.webone.com.au ([210.9.243.176]:13068 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261168AbTI3IBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 04:01:36 -0400
Message-ID: <3F793846.2000407@cyberone.com.au>
Date: Tue, 30 Sep 2003 18:01:10 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
References: <20030930073814.GA26649@mail.jlokier.co.uk>
In-Reply-To: <20030930073814.GA26649@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jamie Lokier wrote:

>This builds upon Andi Kleen's excellent patch for the AMD prefetch bug
>workaround.  It is applies to 2.6.0-test6.
>
>There are four changes on top of Andi's recent patch:
>
>   1. The workaround code is only included when compiling a kernel
>      optimised for AMD processors with the bug.  For kernels optimised
>      for a different processor, there is no code size overhead.
>
>      This will make some people happier.
>
>      It will make some people unhappier, because it means a generic
>      kernel on an AMD will run fine, but won't fixup _userspace_
>      prefetch faults.  More on this below.
>
>   2. Nevertheless, when a kernel _not_ optimised for those AMD processors
>      is run on one, the "alternative" mechanism now correctly replaces
>      prefetch instructions with nops.
>
>   3. The is_prefetch() instruction decoder now handles all cases of
>      funny GDT and LDT segments, checks limits and so on.  As far as I
>      can see, there are no further bugs or flaws in that part.
>
>   4. A consequence of the is_prefetch() change is that, despite the
>      longer C code (rarely used code, for segments), is_prefetch()
>      should run marginally faster now because the access_ok() calls are
>      not required.  They're subsumed into the segment limit
>      calculation.
> 
>Like Andi's patch, this removes 10k or so from current x86 kernels by
>removing the silly conditional from the prefetch() function.
>
>Controversial point coming up!
>

It sounds good Jamie, but could you possibly compile it in
unconditionally? Otherwise it introduces yet another caveat to the CPU
selection / build system. This can be addressed seperately.

I don't think anyone advocates attempting to handle this nicely with the
current CPU selection system, nor were they targeting this patch in
particular. It just kicked off a discussion about the shortfalls of the
selection system.


