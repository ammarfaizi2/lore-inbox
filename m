Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314411AbSEIWGR>; Thu, 9 May 2002 18:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314413AbSEIWGQ>; Thu, 9 May 2002 18:06:16 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:14095 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S314411AbSEIWGQ>; Thu, 9 May 2002 18:06:16 -0400
Message-ID: <3CDAF2D4.C7F20249@linux-m68k.org>
Date: Fri, 10 May 2002 00:06:12 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
In-Reply-To: <Pine.LNX.4.21.0205062053050.32715-100000@serv> <E175Tp9-0003ny-00@starship> <3CD9B098.14E394D3@linux-m68k.org> <E175qT7-00087g-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Daniel Phillips wrote:

> Where you ignore the distinction between logical and physical, it costs you
> execution time, as where you wrote  page = virt_to_page(phys_to_virt((i <<
> PAGE_SHIFT) + bdata->node_boot_start)) where formerly we just had page++.
> This in generic code too.  Unless you have an #ifdef CONFIG_SOMETHING there I
> recommend this code *not* be merged because it penalizes the common case for
> the sake of your arch.  And it's unnecessary even for your arch, as I've
> demonstrated.

1. My patch only modifies init code, I don't think it's really a problem
if it's slightly slower.
2. Above can now be written as "page = pfn_to_page(i +
(bdata->node_boot_start >> PAGE_SHIFT))". Nice, isn't it? :)

> > > You do have a config option, it's CONFIG_SINGLE_MEMORY_CHUNK.
> >
> > That was our cheap answer to avoid the loops.
> 
> My cheap answer is to turn the option off.  So why don't I need a config
> option again?

You know, what that option does?

> > I don't need that, because I create a contiguous _virtual_ address
> > space.
> 
> Again, we're arguing about what?  So do I.  The relationship between virtual
> and logical, for me, is just logical = virtual - PAGE_OFFSET, a meme you'll
> find in many places in the kernel source already, often obscured by the
> impression that physical addresses are really being manipulated when in fact
> nothing of the kind is going on - the simple truth is, the arithmetic gets
> easier then you work zero-based instead of PAGE_OFFSET based.

Why do you want to introduce another abstraction? If the logical address
is basically the same as the virtual address, just use the virtual
address. What difference should that offset make? Could you show me
please one single example?

> So now that we know we're both doing the same thing, could we please stop
> doing the catholics vs the protestants thing and maybe cooperate?

I'm an atheist. >:-)

bye, Roman
