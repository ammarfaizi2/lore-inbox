Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269854AbRHIQqR>; Thu, 9 Aug 2001 12:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269859AbRHIQqH>; Thu, 9 Aug 2001 12:46:07 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:27772 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S269854AbRHIQpw>; Thu, 9 Aug 2001 12:45:52 -0400
Date: Thu, 9 Aug 2001 17:33:27 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: alloc_area_pte: page already exists
In-Reply-To: <20010809183634.K4895@athlon.random>
Message-ID: <Pine.LNX.3.96.1010809172609.6560B-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001, Andrea Arcangeli wrote:
> > task or something instead (there is no kernel context for the "calling"
> > process because the driver is asynchronous so the context which did the
> > alloc_kiovec etc. has exited when the irq comes later) and see if it works
> > better.
> 
> Ok.

I realised I'm not entirely sure on if it's ok to do such "dangerous"
functions inside, say, tq_immediate using queue_task even ? Doesn't that
run in the interrupt context also, upon exit of the interrupt before going
back ?

I haven't followed the latest bh/tasklet/softirq development really..

IOW I want the irq to "trigger" the freeing of the iovecs but it's ok if
it's done later, as long as it's done without any races :)

BTW how does vfree cope with not walking all tasks pgd's to remove the
relevant pte's ? Doesn't that give exactly this kind of problem ? (pte's
are there despite them being deallocated)

/Bjorn


