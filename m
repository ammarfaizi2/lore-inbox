Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264799AbUEKPqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264799AbUEKPqs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 11:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264796AbUEKPqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 11:46:48 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2688 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264799AbUEKPqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 11:46:21 -0400
Date: Tue, 11 May 2004 16:52:15 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405111552.i4BFqFMN000112@81-2-122-30.bradfords.org.uk>
To: Ray Bryant <raybry@sgi.com>, Silviu Marin-Caea <silviu@genesys.ro>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40A0EFC0.1040609@sgi.com>
References: <fa.n6pggn5.84en31@ifi.uio.no>
 <40A0EFC0.1040609@sgi.com>
Subject: Re: dynamic allocation of swap disk space
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Ray Bryant <raybry@sgi.com>:
> 
> 
> Silviu Marin-Caea wrote:
> >
> > 
> > My desktop has been thrashing the disk for a couple of hours because
> > the swap space was exhausted.  And I have the ambition to leave it alone
> > to see if it ever comes out of the thrashing.  Of course, it's not usable
> > at all during this time, I'm writing this on the laptop.
> > 
> >
> 
> You've got a couple problems mixed together here.
> 
> (1)  Swap space fills up because you have overcommitted memory.  In principle, 
> filling up swap space has nothing to do with "thrashing".
> (2)  "thrashing" is a characteristic of a poorly performing program in a
> demand paging virtual memory system typically caused by trying to run a 
> program with a resident size that is smaller than required.  Systems can 
> thrash without filling up swap space.  It is true that systems can thrash AND 
> fill up swap space, but it is not always so.
> 
> You either need (1)  more main memory, (2) reduce the number of programs you 
> are running simultaneously, or (3) better behaving programs, or all three. 
> Increasing the amount of swap space will just use more disk.  It won't cause 
> your system to stop thrashing since that is driven by what is going on in 
> memory, not what is going on on the disk.

Not necessarily.  Increasing swap can allow more physical RAM to be used for
caching data from disk.

Imagine a system with limited physical RAM, and limited swap space, running a
process which causes a lot of filesystem activity on the same physical disk
as is being used for swap.  If the total RAM, both physical and swap is almost
completely full, increasing the swap space may allow some data from physical
RAM to be swapped out, in favour of caching filesystem data from the disk.

Without knowing more details of the original poster's machine, it's difficult
to give specific advice about how to solve the problem.

John.
