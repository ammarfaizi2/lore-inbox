Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262976AbSJBFsb>; Wed, 2 Oct 2002 01:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262977AbSJBFsb>; Wed, 2 Oct 2002 01:48:31 -0400
Received: from cts04.webone.com.au ([210.9.240.37]:43823 "EHLO
	cts04.webone.com.au") by vger.kernel.org with ESMTP
	id <S262976AbSJBFsa>; Wed, 2 Oct 2002 01:48:30 -0400
Date: Wed, 2 Oct 2002 15:53:50 +1000
To: phillips@arcor.de
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: 2.4.19 OOPS in kswapd __remove_from_queues
Message-ID: <20021002155350.A9160@beernut.flames.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021001155510Z16452-14291+912@humbolt.nl.linux.org>
From: Kevin Easton <s3159795@student.anu.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Oct 1, 2002 at 17:55:31 +0200, Daniel Phillips wrote:
> Hi Kevin,
> 
> Did you try the patch below?  What happened, if anything?

[snip kswapd oops & patch]

Yes.. unfortunately, since I posted the original patch, I've seen multiple 
oopsen in several different places.  I should probably mention here that I'm
running the pdc202xx.c driver as a plain IDE controller, with linux software
RAID-1 and ext3 on that.  The instability seems to trigger after copying
a large amount of data to the partitions on that RAID array (several hundred
MB usually).  When I copy data to a drive that's on the other (plain VIA) 
motherboard IDE controller, it doesn't trigger a crash.

Here's the one I got after applying the patch (painstakingly typed in by 
hand :)

ksymoops 2.4.5 on i686 2.4.20-pre7.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.20-pre7/ (specified)
     -m /mnt/usr/src/kernel-source-2.4.20-pre7-patched/System.map (specified)

Unable to handle kernel paging request at virtual address 52749c4f
52749c4f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<52749c4f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 52749c4f   ebx: a125c383     ecx: 00000000       edx: c15b1800
esi: 00000046   edi: cef8c1c0     ebp: dc2431c0       esp: c0297ea8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0297000)
Stack: c01c70ce dc2431c0 00000001 cef8c1c0 c2d5a9c0 00000001 00000001 c01c71f0
       cef8c1c0 00000001 c2d5a9c0 c15a1240 00000008 c0188bd1 c2d5a9c0 00000001
       c15a1240 00000086 c15a3080 c02e8860 c01952ca c15a1240 00000001 c02e889c
Call Trace:    [<c01c70ce>] [<c01c71f0>] [<c0188bd1>] [<c01952ca>] [<c019b66a>]
  [<c0196ecd>] [<c019b600>] [<c0109b3f>] [<c0109cbe>] [<c0106c20>] [<c0106c20>]
  [<c0106c20>] [<c0106c20>] [<c0106c43>] [<c0106cb2>] [<c0105000>] [<c0105027>]
Code:  Bad EIP value.


>>EIP; 52749c4f Before first symbol   <=====

>>eax; 52749c4f Before first symbol
>>ebx; a125c383 Before first symbol
>>edx; c15b1800 <_end+12bf0cc/205408cc>
>>edi; cef8c1c0 <_end+ec99a8c/205408cc>
>>ebp; dc2431c0 <_end+1bf50a8c/205408cc>
>>esp; c0297ea8 <init_task_union+1ea8/2000>

Trace; c01c70ce <raid1_end_bh_io+7e/120>
Trace; c01c71f0 <raid1_end_request+80/90>
Trace; c0188bd1 <end_that_request_first+61/c0>
Trace; c01952ca <ide_end_request+5a/a0>
Trace; c019b66a <ide_dma_intr+6a/b0>
Trace; c0196ecd <ide_intr+bd/120>
Trace; c019b600 <ide_dma_intr+0/b0>
Trace; c0109b3f <handle_IRQ_event+2f/60>
Trace; c0109cbe <do_IRQ+6e/b0>
Trace; c0106c20 <default_idle+0/30>
Trace; c0106c20 <default_idle+0/30>
Trace; c0106c20 <default_idle+0/30>
Trace; c0106c20 <default_idle+0/30>
Trace; c0106c43 <default_idle+23/30>
Trace; c0106cb2 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>
Trace; c0105027 <rest_init+27/30>

 <0>Kernel panic: Aiee, killing interrupt handler!


