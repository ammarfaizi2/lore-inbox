Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315206AbSEIXAT>; Thu, 9 May 2002 19:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315208AbSEIXAS>; Thu, 9 May 2002 19:00:18 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:38663 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315206AbSEIXAQ>; Thu, 9 May 2002 19:00:16 -0400
Message-ID: <3CDAFF7C.57A59FB8@linux-m68k.org>
Date: Fri, 10 May 2002 01:00:12 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
In-Reply-To: <Pine.LNX.4.21.0205062053050.32715-100000@serv> <E175qT7-00087g-00@starship> <3CDAF2D4.C7F20249@linux-m68k.org> <E175wJO-0008Lz-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Daniel Phillips wrote:

> On Friday 10 May 2002 00:06, Roman Zippel wrote:
> > 1. My patch only modifies init code, I don't think it's really a problem
> > if it's slightly slower.
> 
> But why be slower when we don't have to.  And why slow down *all* architectures?
> 
> > 2. Above can now be written as "page = pfn_to_page(i +
> > (bdata->node_boot_start >> PAGE_SHIFT))". Nice, isn't it? :)
> 
> page++ is nicer yet.

Is memmap[i++] so much worse? Let me repeat, this is only executed once
at boot!

> > Why do you want to introduce another abstraction?
> 
> The abstraction is already there.  I didn't create the logical space, I identified
> it.

And it's called virtual address space.

>  There are places where the code is really manipulating logical addresses, not
> physical addresses, and these are not explicitly identified.  This makes the code
> cleaner and easier to read.

_Please_ show me an example.

> Look at drivers/char/mem.c, read_mem.  Clearly, the code is not dealing with
> physical addresses.  Yet it starts off with virt_to_phys, and thereafter works
> in zero-offset addresses.  Why?  Because it's clearer and more efficient to do
> that.  The generic part of my nonlinear patch clarifies this usage by rewriting
> it as virt_to_logical, which is really what's happening.

Are we looking at the same code??? Where is that zero-offset thingie? It
just works with virtual and physical addresses and needs to convert
between them.

> That's really what's happening in bootmem too.

That also works with just physical and virtual addresses. What are you
talking about???

bye, Roman
