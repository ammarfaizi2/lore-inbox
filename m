Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314210AbSEBB0B>; Wed, 1 May 2002 21:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314211AbSEBB0A>; Wed, 1 May 2002 21:26:00 -0400
Received: from dsl-213-023-038-139.arcor-ip.net ([213.23.38.139]:410 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314210AbSEBB0A>;
	Wed, 1 May 2002 21:26:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Wed, 1 May 2002 03:26:22 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E172gnj-0001pS-00@starship> <20020502024740.P11414@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E172isy-0001rL-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 02:47, Andrea Arcangeli wrote:
> >   - Leads forward to interesting possibilities such as hot plug memory.
> >     (Because pinned kernel memory can be remapped to an alternative
> >     region of physical memory if desired)
> 
> You cannot handle hot plug with nonlinear, you cannot take the mem_map
> contigous when somebody plugins new memory, you've to allocate the
> mem_map in the new node, discontigmem allows that, nonlinear doesn't.

You have not read and understood the patch, which this comment demonstrates.

For your information, the mem_map lives in *virtual* memory, it does not
need to change location, only the kernel page tables need to be updated,
to allow a section of kernel memory to be moved to a different physical
location.  For user memory, this was always possible, now it is possible
for kernel memory as well.  Naturally, it's not all you have to do to get
hotplug memory, but it's a big step in that direction.

> At the very least you should waste some tons of memory of unused mem_map
> for all the potential memory that you're going to plugin, if you want to
> handle hot-plug with nonlinear.

Eh.  No.

It's not useful for me to keep correcting you on your misunderstanding of
what config_nonlinear actually does.  Please read Jonathan Corbet's
excellent writeup in lwn, it's written in a very understandable fashion.

-- 
Daniel
