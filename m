Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTFHKC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 06:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbTFHKC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 06:02:27 -0400
Received: from mail.ithnet.com ([217.64.64.8]:26633 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261308AbTFHKCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 06:02:25 -0400
Date: Sun, 8 Jun 2003 12:15:37 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: willy@w.ods.org, gibbs@scsiguy.com, marcelo@conectiva.com.br,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030608121537.7b1b68ba.skraw@ithnet.com>
In-Reply-To: <20030606091759.GC23608@namesys.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030606091759.GC23608@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jun 2003 13:17:59 +0400
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Fri, Jun 06, 2003 at 11:04:08AM +0200, Stephan von Krawczynski wrote:
> > > No, it did crashed in allocation code (you skipped one trace line):
> > > Jun  5 16:53:55 admin kernel: Call Trace:    [__kmem_cache_alloc+107/304]
> > > [kmem_cache_grow+508/624]
> > > [__kmem_cache_alloc+125/304]+[get_mem_for_virtual_node+87/224]
> > > [fix_nodes+198/1008]
> > > 
> > > And the EIP is in kmem_cache_alloc_batch, sounds like it tripped on bad
> > > pointer or something like this. So something is corrupting slab lists it
> > > seems.
> > I agree with you. Only problem is: how can I find out what caused the problem.
> 
> Probably by careful code observations.
> 
> > The only thing I can tell is that the box never hangs when using only HDs on
> > the aic & 3ware controllers. As soon as I begin to use a SDLT drive on aic
> > things get fishy.
> 
> You do not have reiserfs filesystem on a tape drive, right? ;)
> But thhat reduces the region to review to parts thqt deal with tape devices and
> tape-specific stuff, it seems.
> 
> Bye,
>     Oleg

Hello all,

in the meantime I got another oops and it looks like this:

ksymoops 2.4.8 on i686 2.4.21-rc7-aic.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-rc7-aic/ (default)
     -m /boot/System.map-2.4.21-rc7-aic (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jun  8 10:48:49 linux kernel: Oops: 0000
Jun  8 10:48:49 linux kernel: CPU:    1
Jun  8 10:48:49 linux kernel: EIP:    0010:[<c013755e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jun  8 10:48:49 linux kernel: EFLAGS: 00010006
Jun  8 10:48:49 linux kernel: eax: 5a005139   ebx: 5a005139   ecx: edb89c21   edx: 00000060
Jun  8 10:48:49 linux kernel: esi: 00000021   edi: 0000005c   ebp: c342fecc   esp: e4007d74
Jun  8 10:48:49 linux kernel: ds: 0018   es: 0018   ss: 0018
Jun  8 10:48:49 linux kernel: Process tar (pid: 17369, stackpage=e4007000)
Jun  8 10:48:49 linux kernel: Stack: c342fed4 c342fedc c342fecc 00000246 00000070 effa58a0 c01382eb c342fecc
Jun  8 10:48:49 linux kernel:        c3467800 00000070 00000000 c1000020 effa58a0 effa58a0 c013f7d9 c342fecc
Jun  8 10:48:49 linux kernel:        00000070 00000000 c013f8a5 c349d418 f6fc1200 00000000 00000000 c1000020
Jun  8 10:48:49 linux kernel: Call Trace:    [<c01382eb>] [<c013f7d9>] [<c013f8a5>] [<c01b8f73>] [<c01b929e>]
Jun  8 10:48:49 linux kernel:   [<c01b936c>] [<c0145596>] [<c0139fc2>] [<c013069e>] [<c017c4e0>] [<c013124f>]
Jun  8 10:48:49 linux kernel:   [<c0131531>] [<c0131ad0>] [<c0131d20>] [<c0131ad0>] [<c0141c0b>] [<c010782f>]
Jun  8 10:48:49 linux kernel: Code: 8b 44 81 18 0f af da 8b 51 0c 89 41 14 01 d3 40 0f 84 89 00


>>EIP; c013755e <kmem_cache_alloc_batch+4e/110>   <=====

>>ecx; edb89c21 <_end+2d7f78e1/38547d20>
>>ebp; c342fecc <_end+309db8c/38547d20>
>>esp; e4007d74 <_end+23c75a34/38547d20>

Trace; c01382eb <__kmem_cache_alloc+6b/130>
Trace; c013f7d9 <alloc_bounce_bh+19/a0>
Trace; c013f8a5 <create_bounce+45/190>
Trace; c01b8f73 <__make_request+3d3/640>
Trace; c01b929e <generic_make_request+be/140>
Trace; c01b936c <submit_bh+4c/70>
Trace; c0145596 <block_read_full_page+2c6/2e0>
Trace; c0139fc2 <__alloc_pages+42/190>
Trace; c013069e <generic_buffer_fdatasync+5e/110>
Trace; c017c4e0 <reiserfs_get_block+0/12c0>
Trace; c013124f <generic_file_readahead+af/1a0>
Trace; c0131531 <do_generic_file_read+1c1/470>
Trace; c0131ad0 <file_read_actor+0/110>
Trace; c0131d20 <generic_file_read+140/160>
Trace; c0131ad0 <file_read_actor+0/110>
Trace; c0141c0b <sys_read+9b/180>
Trace; c010782f <system_call+33/38>

Code;  c013755e <kmem_cache_alloc_batch+4e/110>
00000000 <_EIP>:
Code;  c013755e <kmem_cache_alloc_batch+4e/110>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c0137562 <kmem_cache_alloc_batch+52/110>
   4:   0f af da                  imul   %edx,%ebx
Code;  c0137565 <kmem_cache_alloc_batch+55/110>
   7:   8b 51 0c                  mov    0xc(%ecx),%edx
Code;  c0137568 <kmem_cache_alloc_batch+58/110>
   a:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c013756b <kmem_cache_alloc_batch+5b/110>
   d:   01 d3                     add    %edx,%ebx
Code;  c013756d <kmem_cache_alloc_batch+5d/110>
   f:   40                        inc    %eax
Code;  c013756e <kmem_cache_alloc_batch+5e/110>
  10:   0f 84 89 00 00 00         je     9f <_EIP+0x9f>


1 warning issued.  Results may not be reliable.


This is the second oops inside kmem_cache_alloc_batch, the problem can be talked of as reproducable.
This is a 2.4.21-rc7+aic20030603 kernel.

Regards,
Stephan
