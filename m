Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290617AbSARHWD>; Fri, 18 Jan 2002 02:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290618AbSARHVx>; Fri, 18 Jan 2002 02:21:53 -0500
Received: from brick.homesquared.com ([216.177.65.65]:25476 "EHLO
	brick.homesquared.com") by vger.kernel.org with ESMTP
	id <S290617AbSARHVr>; Fri, 18 Jan 2002 02:21:47 -0500
Message-ID: <3C47CD5A.1070101@coplanar.net>
Date: Thu, 17 Jan 2002 23:23:06 -0800
From: Jeremy Jackson <jerj@coplanar.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Yinlei Yu <yinlei_yu@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is there anyway to use 4M pages on x86 linux in user level?
In-Reply-To: <F198nwpGR881Np7vXee0002516d@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I brought this to the list once about a half a year ago. One item I got 
in feedback was that
it would require a reverse-mapping allocator (for the cases of mappings 
to ram) to be able to coalesce/rearrange pages to
make room for contiguous 4M pages. Such an allocator now exists... 
search an LKML archive for "rmap".

In the case of non-swappable memory, the allocator is not an issue. In 
fact the kernel does use 4M pages to map the kernel itsself 
(non-swappable and contiguous) and the 1:1 mapping of physical memory on 
non-himem kernels.(not 100% sure about that part) I immagine this could 
be easily extended to things like the bt848, the framebuffer on all 
video cards (ok not ISA-VGA), and any mmio regions sufficiently large 
enough. ( or redo BIOS PCI setup so regions are at least 4M apart...)

As for reduced TLB misses... I just read the specs for decoding the MSRs 
on AMD processors to determine cache organization, and it turns out that 
they have separate TLBs for 4k vs 4M pages. So you actually get more TLB 
entries by using 4M pages...

Now I guess we need to start thinking about extent based filesystems and 
how to page in/out 4M pages...mmap files...


Yinlei Yu wrote:

> Hi,
>
> I am working on a project that keep accessing lots of memory 
> randomly(say 500MB-1.5GB) and we do have such amount of memory 
> installed so there's almost no page faults while running the entire 
> program. Since x86 architecutre has a 4M page feature, is it possible 
> to make use of these big pages instead of 4K pages in my program (a 
> user-level application) so I can expect much fewer TLB misses due to 
> the reduced number of TLB entries? Thanks very much!
>
>
>
>
>
>
> _________________________________________________________________
> Join the world's largest e-mail service with MSN Hotmail. 
> http://www.hotmail.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/




