Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbUKEMhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbUKEMhK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 07:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbUKEMhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 07:37:10 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:6568 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262662AbUKEMhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 07:37:01 -0500
From: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Organization: -ENOENT
To: Andi Kleen <ak@muc.de>
Subject: Re: 2.6.10-rc1-mm3
Date: Fri, 5 Nov 2004 13:36:19 +0100
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20041105001328.3ba97e08.akpm@osdl.org> <20041105021758.09d582bf.akpm@osdl.org> <20041105104832.GA93999@muc.de>
In-Reply-To: <20041105104832.GA93999@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411051336.19625.l_allegrucci@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 November 2004 11:48, Andi Kleen wrote:
> On Fri, Nov 05, 2004 at 02:17:58AM -0800, Andrew Morton wrote:
> > Lorenzo Allegrucci <l_allegrucci@yahoo.it> wrote:
> > >
> > > On Friday 05 November 2004 09:13, Andrew Morton wrote:
> > >  > 
> > >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/
> > > 
> > >  ------------[ cut here ]------------
> > >  kernel BUG at mm/memory.c:156!
> > >  invalid operand: 0000 [#1]
> > >  PREEMPT 
> > >  Modules linked in: ipv6 tun dm_mod emu10k1 sound soundcore ac97_codec unix
> > >  CPU:    0
> > >  EIP:    0060:[clear_page_range+276/304]    Not tainted VLI
> > >  EFLAGS: 00010206   (2.6.10-rc1-mm3) 
> > >  EIP is at clear_page_range+0x114/0x130
> > >  eax: daffc000   ebx: 00483fff   ecx: c03b7088   edx: daffc000
> > >  esi: 00000000   edi: 00080000   ebp: dca51ed0   esp: dca51ea8
> > >  ds: 007b   es: 007b   ss: 0068
> > >  Process shmt04 (pid: 4854, threadinfo=dca51000 task=de374510)
> > 
> > hm, I thought I ran ltp.  Andi, this is due to the 4level patches.  I can
> > reproduce it with non-PAE x86.  But testing was interrupted by the apparent
> > suicide of an IDE disk :(
> 
> Ok, I think that was a BUG_ON I added later to check for something.
> I think problem is that last is off by one at this point. That is ok.
> I think it's safe to just remove it.
> 
> I will do a non PAE i386 LTP run with this now.  Lorenzo can you
> check it solves the problem for you?
> 
> -Andi
> 
> Remove bogus BUG_ON.
> 
> Signed-off-by: Andi Kleen <ak@muc.de>
> 
> 
> diff -u linux-2.6.10rc1-mm3/mm/memory.c-o linux-2.6.10rc1-mm3/mm/memory.c
> --- linux-2.6.10rc1-mm3/mm/memory.c-o 2004-11-05 11:42:00.000000000 +0100
> +++ linux-2.6.10rc1-mm3/mm/memory.c 2004-11-05 11:45:37.000000000 +0100
> @@ -153,7 +153,6 @@
>    return;
>   }
>   BUG_ON(addr & ~PGDIR_MASK);
> - BUG_ON(end & ~PGDIR_MASK);
>   pgd_start = pml4_pgd_offset(pml4, addr);
>   free = 0;
>   pgd = pgd_start;
> 
> 

The above patch solves the problem for me.

-- 
I route therefore you are
