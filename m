Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313946AbSEFBHp>; Sun, 5 May 2002 21:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314034AbSEFBHo>; Sun, 5 May 2002 21:07:44 -0400
Received: from dsl-213-023-038-176.arcor-ip.net ([213.23.38.176]:46781 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313946AbSEFBHo>;
	Sun, 5 May 2002 21:07:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Mon, 6 May 2002 03:07:07 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020502180632.I11414@dualathlon.random> <E174Vq8-0004BK-00@starship> <20020506015505.B14956@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E174Wy4-0004C2-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 May 2002 02:55, Russell King wrote:
> On Mon, May 06, 2002 at 01:54:52AM +0200, Daniel Phillips wrote:
> > I must be guilty of not explaining clearly.  Suppose you have the following
> > physical memory map:
> > 
> > 	          0: 128 MB
> > 	  8000,0000: 128 MB
> > 	1,0000,0000: 128 MB
> > 	1,8000,0000: 128 MB
> > 	2,0000,0000: 128 MB
> > 	2,8000,0000: 128 MB
> > 	3,0000,0000: 128 MB
> > 	3,8000,0000: 128 MB
> > 
> > The total is 1 GB of installed ram.  Yet the kernel's 1G virtual space,
> > can only handle 128 MB of it.
> 
> I see no problem with the above with the existing discontigmem stuff.
> discontigmem does *not* require a linear relationship between kernel
> virtual and physical memory.  I've been running kernels for a while
> on such systems.

Look, you've got this:

#define __phys_to_virt(ppage) ((unsigned long)(ppage) + PAGE_OFFSET - PHYS_OFFSET)

So, since __phys_to_virt (and hence phys_to_virt and __va) is clearly linear, the
relation __pa(__va(kva)) == kva cannot hold.  Perhaps that doesn't bother you?

-- 
Daniel
