Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUINV6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUINV6p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269488AbUINV4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:56:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11678 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269218AbUINVrj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 17:47:39 -0400
Date: Tue, 14 Sep 2004 17:06:03 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Neil Schemenauer <nas@arctrix.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Possible dcache BUG: debugging patch
Message-ID: <20040914200603.GL30422@logos.cnet>
References: <20040914211301.GA18197@mems-exchange.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914211301.GA18197@mems-exchange.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Neil,

IIRC Gene's problem was hardware misconfiguration. 

And your trace doesnt seem to look similar to his (different location inside
prune_dcache from what I remember).

Anyway, how hard is for you to reproduce this? 

Yes 2.6.9-rc1-mm5 contains the remove_inode_buffers BUGs to catch NULL 
list pointers, you can try that, but it might be unrelated. 

Ingo was also seeing this oopses he said, but he didnt replied. Ingo?

On Tue, Sep 14, 2004 at 05:13:01PM -0400, Neil Schemenauer wrote:
> Hi Marcelo,
> 
> One of our AMD K7 machines seems to be running into the dcache bug.
> I'm attaching the oops trace.  Is it possible to apply your BUG
> patch to the 2.6.7 or 2.6.8.1 kernel or should I use 2.6.9-rc1-mm5?
> 
> Best regards,
> 
>   Neil
> 
> 
> ======================================================================
> 
> Unable to handle kernel paging request at virtual address 705f6573
>  printing eip:
> c01539c6
> *pde = 00000000
> Oops: 0002 [#1]
> Modules linked in: via_rhine crc32 binfmt_capwrap
> CPU:    0
> EIP:    0060:[prune_dcache+38/288]    Not tainted
> EFLAGS: 00010212   (2.6.7) 
> EIP is at prune_dcache+0x26/0x120
> eax: c038edd4   ebx: c0601ec4   ecx: c8601e50   edx: 705f6573
> esi: c05e8be0   edi: 00000061   ebp: f7ffea48   esp: f7d92f0c
> ds: 007b   es: 007b   ss: 0068
> Process kswapd0 (pid: 32, threadinfo=f7d92000 task=f7dc6050)
> Stack: 00000080 00000000 f7d92000 c0153d92 c0131417 02c47800 00000000 00030260 
>        000000eb 00000000 000000d0 000000c0 c038dca4 00000001 0000000a c038db80 
>        c01324b3 00000000 f7d92f9c 000000a0 00000000 000000c0 000000c0 000000c0 
> Call Trace:
>  [shrink_dcache_memory+18/32] shrink_dcache_memory+0x12/0x20
>  [shrink_slab+311/368] shrink_slab+0x137/0x170
>  [balance_pgdat+419/496] balance_pgdat+0x1a3/0x1f0
>  [kswapd+182/192] kswapd+0xb6/0xc0
>  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
>  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
>  [kswapd+0/192] kswapd+0x0/0xc0
>  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
> 
> Code: 89 02 89 49 04 89 09 a1 d8 ed 38 c0 0f 18 00 90 ff 0d e0 ed 
