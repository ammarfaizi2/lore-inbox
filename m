Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315547AbSEHXL3>; Wed, 8 May 2002 19:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315548AbSEHXL2>; Wed, 8 May 2002 19:11:28 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:7429 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315547AbSEHXL1>; Wed, 8 May 2002 19:11:27 -0400
Message-ID: <3CD9B098.14E394D3@linux-m68k.org>
Date: Thu, 09 May 2002 01:11:20 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
In-Reply-To: <Pine.LNX.4.21.0205062053050.32715-100000@serv> <E175Tp9-0003ny-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Daniel Phillips wrote:

> Your patch preserves a linear relationship between physical and virtual
> memory, because you do both the ptov and vtop lookup in the same array.  As
> such, you don't provide the functionality I provide of being able to fit a
> large amount of physical memory into a small amount of virtual memory, and
> you can't join all your separate pgdat's into one, as I do.

Read the source again. arch/m68k/mm/motorola.c:map_chunk() maps all
memory areas into single virtual area (virtaddr is static there and only
increased starting from PAGE_OFFSET). In paging_init() there is only a
single call to free_area_init().

> and replace the four direct table lookup with loops.

The loops are only an implementation detail and can be replaced with
another algorithm.

> you've accidently
> repeated the last four lines of mm_vtop.  Finally, it looks like your
> ZTWO_VADDR hack in mm_ptov would also cease to be a special case, at least,

That stuff is obsolete since ages, it should be replaced with BUG().

> You do have a config option, it's CONFIG_SINGLE_MEMORY_CHUNK.

That was our cheap answer to avoid the loops.

>  You just didn't
> attempt to create the contiguous logical address space as I did, so you
> didn't need to go outside your arch.

I don't need that, because I create a contiguous _virtual_ address
space.

bye, Roman
