Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270609AbRHIXDe>; Thu, 9 Aug 2001 19:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270606AbRHIXDY>; Thu, 9 Aug 2001 19:03:24 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:34063 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S268693AbRHIXDO>; Thu, 9 Aug 2001 19:03:14 -0400
Date: Thu, 9 Aug 2001 23:50:42 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: alloc_area_pte: page already exists
In-Reply-To: <20010809190434.P4895@athlon.random>
Message-ID: <Pine.LNX.3.96.1010809234824.9949A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001, Andrea Arcangeli wrote:
> > IOW I want the irq to "trigger" the freeing of the iovecs but it's ok if
> > it's done later, as long as it's done without any races :)
> 
> Your design looks suspect, but you can do that safely (at least as far
> as vfree is concerned) with keventd's schedule_task().

Ok will try

The design is shit but needed in this application... 

> > BTW how does vfree cope with not walking all tasks pgd's to remove the
> > relevant pte's ? Doesn't that give exactly this kind of problem ? (pte's
> 
> vfree as usual walks the pgd/pmd to reach the pte. It knows the
> pgd/pmd/pte cannot go away and it serlializes against vmalloc with the
> vmlist_lock, it sounds ok.

So what happens when the kernel accesses the non-existant pte's or when
the vmalloc space runs out ?

/Bjorn

