Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314232AbSEBCk5>; Wed, 1 May 2002 22:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314241AbSEBCk4>; Wed, 1 May 2002 22:40:56 -0400
Received: from dsl-213-023-038-139.arcor-ip.net ([213.23.38.139]:49050 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314232AbSEBCk4>;
	Wed, 1 May 2002 22:40:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Wed, 1 May 2002 04:41:17 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E172isy-0001rL-00@starship> <20020502034318.T11414@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E172k3S-0001sH-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 03:43, Andrea Arcangeli wrote:
> On Wed, May 01, 2002 at 03:26:22AM +0200, Daniel Phillips wrote:
> > For your information, the mem_map lives in *virtual* memory, it does not
> > need to change location, only the kernel page tables need to be updated,
> > to allow a section of kernel memory to be moved to a different physical
> > location.  For user memory, this was always possible, now it is possible
> > for kernel memory as well.  Naturally, it's not all you have to do to get
> > hotplug memory, but it's a big step in that direction.
> 
> what kernel pagetables?

The normal page tables that are used to map kernel memory.

> pagetables for space that you left free for what?

These page tables have not been left free for anything.  The nice thing about
page tables is that you can change the page table entries to point wherever
you want.  (I know you know this.)  This is what config_nonlinear supports,
and that is why it's called config_nonlinear.  When we want to remap part of
the kernel memory to a different piece of physical memory, we just need to
fill in some pte's.  The tricky part is knowing how to fill in the ptes, and
config_nonlinear takes care of that.

> You waste virtual space for that at the very least on x86 that is
> just very tigh, at this point kernel virtual space is more costly than
> physical space these days. And nevertheless most archs doesn't have
> pagetables at all to read and write the page structures. yes it's
> virtual memory but it's a direct mapping.

Most architectures?  That's quite possibly an exaggeration.  Some
architectures - MIPS32 for example - make this difficult or impossible,
and so what?  Those can't do software hotplug memory, sorry.

-- 
Daniel
