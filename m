Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267342AbTBPTKe>; Sun, 16 Feb 2003 14:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbTBPTKe>; Sun, 16 Feb 2003 14:10:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49164 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267342AbTBPTKc>; Sun, 16 Feb 2003 14:10:32 -0500
Date: Sun, 16 Feb 2003 11:17:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: Fw: 2.5.61 oops running SDET
In-Reply-To: <26480000.1045422382@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302161115290.2874-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Feb 2003, Martin J. Bligh wrote:
> 
> Well, I did the stupid safe thing, and it hangs the box once we get up to 
> a load of 32 with SDET. Below is what I did, the only other issue I can
> see in here is that task_mem takes mm->mmap_sem which is now nested inside
> the task_lock inside tasklist_lock ... but I can't see anywhere that's a
> problem from a quick search

Ho - you can _never_ nest a semaphore inside a spinlock - if the semaphore 
sleeps, the spinlock will cause a lockup regardless of any reverse nesting 
issues.. So I guess the old "get_task_mm()" code is requried anyway.

		Linus

