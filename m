Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTIRAnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 20:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbTIRAnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 20:43:05 -0400
Received: from dsl092-233-042.phl1.dsl.speakeasy.net ([66.92.233.42]:23455
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id S262914AbTIRAnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 20:43:01 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: VANDROVE@vc.cvut.cz
X-Envelope-Sender: oliver@klozoff.com
Message-ID: <3F68FEEC.5020809@klozoff.com>
Date: Wed, 17 Sep 2003 20:40:12 -0400
From: Stevie-O <oliver@klozoff.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Aliasing physical memory using virtual memory (from a d
References: <80BC15566D@vcnet.vc.cvut.cz>
In-Reply-To: <80BC15566D@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

> On 17 Sep 03 at 19:36, Stevie-O wrote:
> 
>>My thinking is this: I want to use __get_free_pages(1) 80 times to get the
>>160 pages, then passed those 80 pieces to the card (it's known the card can
>>handle requests with that many pieces).  Then I want to create a *virtually*
>>contiguous 160-page mapping, so the postprocessing code in the driver can
>>view the 80 2-page sub-buffers as one big consecutive 160-page buffer. 
>>Doing this would (a) make for more efficient use of memory, and (b) leave
>>the larger piles of contiguous pages to the drivers of cards that actually
>>require them.
> 
> 
> If you'll use __get_free_pages(0) 160 times, you should be able to use
> vmap() in 2.[456].x.
Actually, I specified __get_free_pages(1) 80 times because I don't know if the 
card's SG can actually support 160 separate buffers (I'm certain it can do at 
least 80 though).

I grepped my 2.4 kernel source for 'vmap' and the only results that seemed 
meaningful were vmap_pte_range or vmap_pmd_range in mips/mm/umap.c and 
mips64/mm/umap.c. Is this documented somewhere? I suffer from the 'i'm new at 
this, but this looks possible' syndrome. I don't actually know how anything is 
accomplished.

Btw, am I right about kmalloc(35000) effectively grabbing 64K?

> 
> I must say that I do not understand why it checks for 
> size > (max_mapnr << PAGE_SHIFT) in 2.4.x, or for count > num_physpages
> in 2.6.x (as there is nothing wrong with mapping same page several
> thousand times, or is it bad? with 32MB host you have plenty of
> unused VA space in the kernel...), but it should not hurt you as you
> need distinct physical pages.
> 
> On other side, maybe that using SG even for driver operations is not
> that complicated. Do not forget that on bigmem boxes you have only
> 128MB area for vmalloc/vmap/ioremap, so you can quickly find that
> there is not 640KB continuous area available.

-- 
- Stevie-O

Real Programmers use COPY CON PROGRAM.EXE

