Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278041AbRJ0IIj>; Sat, 27 Oct 2001 04:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278042AbRJ0IIY>; Sat, 27 Oct 2001 04:08:24 -0400
Received: from mail128.mail.bellsouth.net ([205.152.58.88]:37686 "EHLO
	imf28bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278041AbRJ0IIG>; Sat, 27 Oct 2001 04:08:06 -0400
Message-ID: <3BDA6B8F.FDC44349@mandrakesoft.com>
Date: Sat, 27 Oct 2001 04:08:47 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More ioctls for VIA sound driver, Flash 5 now fixed
In-Reply-To: <Pine.LNX.4.33.0110270256210.7888-100000@portland.hansa.lan> <3BDA6A4F.D73EC73A@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> So, the preferred allocation algorithm would be:
> 
>         if (OSS fragment size <= PAGE_SIZE)
>                 allocate chan->pgtbl[] in PAGE_SIZE chunks
>         else
>                 allocate chan->pgtbl[] in oss_frag_size chunks
> 
> Another key thing to rememeber is that pci_alloc_consistent usually
> returns a -minimum- of one page, so it's useless to allocate less than
> that, without switching the entire driver to the pci_pool_xxx API.

Another limitation, I just remembered:  Each scatter-gather buffer must
be a multiple of PAGE_SIZE (actually probably PAGE_CACHE_SIZE), in order
for mmap(2) support (via_mm_nopage) to work properly.

I would also like to point out that mmap support via
vm_operations_struct::nopage is also unique and new, and was suggested
by Linus as a much better mmap(2) approach than other drivers, which
using remap_page_range [a method which requires the one-big-buffer
allocation approach].

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

