Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268011AbUHNDr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268011AbUHNDr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 23:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268021AbUHNDrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 23:47:19 -0400
Received: from marc2.theaimsgroup.com ([63.238.77.172]:57276 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id S268012AbUHNDnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 23:43:49 -0400
Date: Fri, 13 Aug 2004 23:43:45 -0400 (EDT)
From: Hank Leininger <hlein@progressive-comp.com>
X-X-Sender: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.26 OOPS in __kmem_cache_alloc
Message-ID: <010408121718530.12915@timmy.spinoli.org>
X-Marks-The: Spot
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[1.] One line summary of the problem:

2.4.26 OOPS in __kmem_cache_alloc

[2.] Full description of the problem/report:

The primary MARC server has been out of production for, oh, about
four months while I beat my head bloody trying to figure out why it's
been so unstable.  Random lockups, almost always hard lockups with no
errors to the console, etc.  Very very very rarely, an oops.  The system
was rock-solid for the first 4 months of its life (built from parts),
and then suddenly everything went to sh*t since April.

At first it appeared that the power supplies--which were re-used pulls
from an old retired system--were underpowered and had just given up.  So
I replaced them with overkill PS's.  But the random lockups continued.
At first I suspected hardware had been damaged by the PS's as they
flaked out, and went on to replace temporarily or permanently the CPUs,
CPU fans, memory, all internal cables, hard drive controllers.  Still
the system was completely unstable.  Installed a different hard drive as
the boot/OS disk--just long enough to trigger a lockup.  Replaced the
motherboard with a different brand, and different chipset NIC and video
card in the process, moving to a different case.  But the lockups
continue.  At this point I have replaced literally everything but the
operating system...

The last change was the motherboard+case, after which the system was
stable that way for 31 days--a record.  So I thought I'd found the
problem; the old motherboard.  Until I woke this morning to an OOPS out
the serial console, and a completely locked box.

To stress-test the system as I've been swapping hardware, I found that
no contrived workload/benchmark/test-tool I could find could reproduce
the crashes (and nothing like memtest86, etc found any problems); it
would pass any test I threw at it until I put it back to its real
workload.  So, I've been doing a complete full-text database reindex
from scratch (fixing historic bad things like searches splitting on _
characters, for instance, which requires a full rebuild anyway).  The
full-text-index process taxes all three of CPU, memory, and disk, and in
whatever magic combination required to trigger crashes...

So far there have only been two OOPS's I could capture; all other times
the lockups were completely hard and completely silent.  The new one is
the one that just occurred; the older one was about about two months ago
now; I discounted at the time because I still so strongly suspected
hardware.  In fact I doubt that one: I wrote it out by hand at the time,
and now trying to ksymoops it, I get a lot of END_OF_CODE+'s, which
makes me think that may have been before I recompiled the kernel to
support the different disk controller I put in later--in other words, I
may no longer have the kernel it was against, and the ksymoops output
for the older OOPS may be a bunch of garbage :(

[ It is always possible that there were multiple problems in April, and
  by swapping hardware I've gotten away from some HW-related, but still
  some other SW-related problems persist. ]

[3.] Keywords (i.e., modules, networking, kernel):

2.4.26
grsec
oops
ext3
software raid
mysql
__kmem_cache_alloc

[4.] Kernel version (from /proc/version):

Linux version 2.4.26-grsec (hlein@marc1.theaimsgroup.com) (gcc version 3.2.3) #1 SMP Wed Jun 16 17:58:18 EDT 2004

(I believe the symptoms started before I'd upgraded from 2.4.25.)

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

First OOPS (just happened; reliable):

ksymoops 2.4.9 on i686 2.4.26-grsec.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.26-grsec/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000021
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01f20fb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: c16060c0   ebx: 00000000   ecx: 00000050   edx: dea47a80
esi: 00000000   edi: 000000f0   ebp: 00000001   esp: d426ddf8
ds: 0018   es: 0018   ss: 0018
Process mysqld (pid: 16022, stackpage=d426d000)
Stack: 00000000 c17dc000 c1715e00 00000000 00000000 00001000 00000001 c01febba
       c16060c0 000000f0 c01fec78 00000001 c17bd8c0 c1715e00 00000905 c116ba10
       00000000 0000f4c4 c01fef15 c116ba10 00001000 00000001 0000000c c116ba10
Call Trace:    [<c01febba>] [<c01fec78>] [<c01fef15>] [<c01ff8a3>] [<c01f4035>]
  [<c01ea9ce>] [<c022b620>] [<c01eaf70>] [<c01eb11d>] [<c01eaf70>] [<c01fc1f3>]
  [<c01bf3c3>]
Code: 8b 5c 24 20 f7 c7 01 00 00 00 0f 84 f5 00 00 00 f6 43 30 01


>>EIP; c01f20fb <__kmem_cache_alloc+b/130>   <=====

>>eax; c16060c0 <_end+127ce70/206a7e10>
>>edx; dea47a80 <_end+1e6be830/206a7e10>
>>esp; d426ddf8 <_end+13ee4ba8/206a7e10>

Trace; c01febba <get_unused_buffer_head+5a/b0>
Trace; c01fec78 <create_buffers+28/f0>
Trace; c01fef15 <create_empty_buffers+25/70>
Trace; c01ff8a3 <block_read_full_page+2d3/2f0>
Trace; c01f4035 <__alloc_pages+65/280>
Trace; c01ea9ce <do_generic_file_read+1ee/4c0>
Trace; c022b620 <ext3_get_block+0/90>
Trace; c01eaf70 <file_read_actor+0/f0>
Trace; c01eb11d <generic_file_read+bd/1c0>
Trace; c01eaf70 <file_read_actor+0/f0>
Trace; c01fc1f3 <sys_read+a3/150>
Trace; c01bf3c3 <system_call+33/50>

Code;  c01f20fb <__kmem_cache_alloc+b/130>
00000000 <_EIP>:
Code;  c01f20fb <__kmem_cache_alloc+b/130>   <=====
   0:   8b 5c 24 20               mov    0x20(%esp,1),%ebx   <=====
Code;  c01f20ff <__kmem_cache_alloc+f/130>
   4:   f7 c7 01 00 00 00         test   $0x1,%edi
Code;  c01f2105 <__kmem_cache_alloc+15/130>
   a:   0f 84 f5 00 00 00         je     105 <_EIP+0x105>
Code;  c01f210b <__kmem_cache_alloc+1b/130>
  10:   f6 43 30 01               testb  $0x1,0x30(%ebx)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000030
c01f2200
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01f2200>]    Not tainted
EFLAGS: 00010046
eax: c160651c   ebx: 00000000   ecx: 00000000   edx: 08254c40
esi: d66d457c   edi: 00000020   ebp: d426dc14   esp: d426db8c
ds: 0018   es: 0018   ss: 0018
Process mysqld (pid: 16022, stackpage=d426d000)
Stack: 00000000 00000000 0000000e d426dc14 d66d457c 00000021 d426dc14 c01dfbb8
       c160651c 00000020 00000000 d66d4000 00000000 00000021 c01dfbf1 00000021
       d426dc14 d66d457c 00000021 00000000 d66d4000 c01dfd28 00000021 d426dc14
Call Trace:    [<c01dfbb8>] [<c01dfbf1>] [<c01dfd28>] [<c01e03a3>] [<c01d8b3a>]
  [<c01d90ab>] [<c01bfb06>] [<c01cfe06>] [<c01d0978>] [<c01d0830>] [<c01bf679>]
  [<c01f20fb>] [<c01febba>] [<c01fec78>] [<c01fef15>] [<c01ff8a3>] [<c01f4035>]
  [<c01ea9ce>] [<c022b620>] [<c01eaf70>] [<c01eb11d>] [<c01eaf70>] [<c01fc1f3>]
  [<c01bf3c3>]
Code: f6 43 30 01 0f 84 16 ff ff ff 0f 0b d6 04 c2 5c 35 c0 e9 09


>>EIP; c01f2200 <__kmem_cache_alloc+110/130>   <=====

>>eax; c160651c <_end+127d2cc/206a7e10>
>>esi; d66d457c <_end+1634b32c/206a7e10>
>>ebp; d426dc14 <_end+13ee49c4/206a7e10>
>>esp; d426db8c <_end+13ee493c/206a7e10>

Trace; c01dfbb8 <send_signal+118/120>
Trace; c01dfbf1 <deliver_signal+31/a0>
Trace; c01dfd28 <send_sig_info+c8/e0>
Trace; c01e03a3 <do_notify_parent+83/d0>
Trace; c01d8b3a <exit_notify+ea/390>
Trace; c01d90ab <do_exit+2cb/310>
Trace; c01bfb06 <die+86/90>
Trace; c01cfe06 <do_page_fault+286/540>
Trace; c01d0978 <pax_do_page_fault+148/1a0>
Trace; c01d0830 <pax_do_page_fault+0/1a0>
Trace; c01bf679 <page_fault+39/60>
Trace; c01f20fb <__kmem_cache_alloc+b/130>
Trace; c01febba <get_unused_buffer_head+5a/b0>
Trace; c01fec78 <create_buffers+28/f0>
Trace; c01fef15 <create_empty_buffers+25/70>
Trace; c01ff8a3 <block_read_full_page+2d3/2f0>
Trace; c01f4035 <__alloc_pages+65/280>
Trace; c01ea9ce <do_generic_file_read+1ee/4c0>
Trace; c022b620 <ext3_get_block+0/90>
Trace; c01eaf70 <file_read_actor+0/f0>
Trace; c01eb11d <generic_file_read+bd/1c0>
Trace; c01eaf70 <file_read_actor+0/f0>
Trace; c01fc1f3 <sys_read+a3/150>
Trace; c01bf3c3 <system_call+33/50>

Code;  c01f2200 <__kmem_cache_alloc+110/130>
00000000 <_EIP>:
Code;  c01f2200 <__kmem_cache_alloc+110/130>   <=====
   0:   f6 43 30 01               testb  $0x1,0x30(%ebx)   <=====
Code;  c01f2204 <__kmem_cache_alloc+114/130>
   4:   0f 84 16 ff ff ff         je     ffffff20 <_EIP+0xffffff20>
Code;  c01f220a <__kmem_cache_alloc+11a/130>
   a:   0f 0b                     ud2a
Code;  c01f220c <__kmem_cache_alloc+11c/130>
   c:   d6                        (bad)
Code;  c01f220d <__kmem_cache_alloc+11d/130>
   d:   04 c2                     add    $0xc2,%al
Code;  c01f220f <__kmem_cache_alloc+11f/130>
   f:   5c                        pop    %esp
Code;  c01f2210 <__kmem_cache_alloc+120/130>
  10:   35 c0 e9 09 00            xor    $0x9e9c0,%eax

 kernel BUG at slab.c:1238!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01f220a>]    Not tainted
EFLAGS: 00010202
eax: c1607690   ebx: c2341880   ecx: 0000067c   edx: c0103c08
esi: 00000020   edi: 00000020   ebp: de27a180   esp: d426d880
ds: 0018   es: 0018   ss: 0018
Process mysqld (pid: 16022, stackpage=d426d000)
Stack: 56494e55 41535245 00000246 de8c0140 00000020 00000202 de27a180 c02bd1e2
       c1607690 00000020 de3f9d60 0000000d 00000040 e0a34ac3 00000640 00000020
       d426c000 00000000 00000318 0000003c 0000000f 0000000e 00000001 04000001
Call Trace:    [<c02bd1e2>] [<e0a34ac3>] [<e0a34688>] [<c01c0ec9>] [<c01c10db>]
  [<c01c3bd8>] [<c01bdfc5>] [<c01df18c>] [<c01dead6>] [<c01dad54>] [<c01dac03>]
  [<c01da9ce>] [<c01c112c>] [<c01c3bd8>] [<c01bdfc3>] [<c01d9688>] [<c01d90ab>]
  [<c01bfb06>] [<c01cfe06>] [<c02c1ae3>] [<c02d6c25>] [<c02e36e2>] [<c02e3a88>]
  [<c01d0978>] [<c01d0830>] [<c01bf679>] [<c01f2200>] [<c01dfbb8>] [<c01dfbf1>]
  [<c01dfd28>] [<c01e03a3>] [<c01d8b3a>] [<c01d90ab>] [<c01bfb06>] [<c01cfe06>]
  [<c01d0978>] [<c01d0830>] [<c01bf679>] [<c01f20fb>] [<c01febba>] [<c01fec78>]
  [<c01fef15>] [<c01ff8a3>] [<c01f4035>] [<c01ea9ce>] [<c022b620>] [<c01eaf70>]
  [<c01eb11d>] [<c01eaf70>] [<c01fc1f3>] [<c01bf3c3>]
Code: 0f 0b d6 04 c2 5c 35 c0 e9 09 ff ff ff 89 f6 8d bc 27 00 00


>>EIP; c01f220a <__kmem_cache_alloc+11a/130>   <=====

>>eax; c1607690 <_end+127e440/206a7e10>
>>ebx; c2341880 <_end+1fb8630/206a7e10>
>>edx; c0103c08 <cache_sizes+48/c0>
>>ebp; de27a180 <_end+1def0f30/206a7e10>
>>esp; d426d880 <_end+13ee4630/206a7e10>

Trace; c02bd1e2 <alloc_skb+c2/1e0>
Trace; e0a34ac3 <[via-rhine]via_rhine_rx+183/430>
Trace; e0a34688 <[via-rhine]via_rhine_interrupt+148/180>
Trace; c01c0ec9 <handle_IRQ_event+69/a0>
Trace; c01c10db <do_IRQ+8b/e0>
Trace; c01c3bd8 <call_do_IRQ+5/d>
Trace; c01bdfc5 <__read_lock_failed+5/14>
Trace; c01df18c <.text.lock.timer+45/79>
Trace; c01dead6 <timer_bh+66/e0>
Trace; c01dad54 <bh_action+54/80>
Trace; c01dac03 <tasklet_hi_action+63/a0>
Trace; c01da9ce <do_softirq+ce/d0>
Trace; c01c112c <do_IRQ+dc/e0>
Trace; c01c3bd8 <call_do_IRQ+5/d>
Trace; c01bdfc3 <__read_lock_failed+3/14>
Trace; c01d9688 <.text.lock.exit+59/151>
Trace; c01d90ab <do_exit+2cb/310>
Trace; c01bfb06 <die+86/90>
Trace; c01cfe06 <do_page_fault+286/540>
Trace; c02c1ae3 <dev_queue_xmit+133/330>
Trace; c02d6c25 <ip_output+55/90>
Trace; c02e36e2 <tcp_ack_saw_tstamp+22/50>
Trace; c02e3a88 <tcp_clean_rtx_queue+328/330>
Trace; c01d0978 <pax_do_page_fault+148/1a0>
Trace; c01d0830 <pax_do_page_fault+0/1a0>
Trace; c01bf679 <page_fault+39/60>
Trace; c01f2200 <__kmem_cache_alloc+110/130>
Trace; c01dfbb8 <send_signal+118/120>
Trace; c01dfbf1 <deliver_signal+31/a0>
Trace; c01dfd28 <send_sig_info+c8/e0>
Trace; c01e03a3 <do_notify_parent+83/d0>
Trace; c01d8b3a <exit_notify+ea/390>
Trace; c01d90ab <do_exit+2cb/310>
Trace; c01bfb06 <die+86/90>
Trace; c01cfe06 <do_page_fault+286/540>
Trace; c01d0978 <pax_do_page_fault+148/1a0>
Trace; c01d0830 <pax_do_page_fault+0/1a0>
Trace; c01bf679 <page_fault+39/60>
Trace; c01f20fb <__kmem_cache_alloc+b/130>
Trace; c01febba <get_unused_buffer_head+5a/b0>
Trace; c01fec78 <create_buffers+28/f0>
Trace; c01fef15 <create_empty_buffers+25/70>
Trace; c01ff8a3 <block_read_full_page+2d3/2f0>
Trace; c01f4035 <__alloc_pages+65/280>
Trace; c01ea9ce <do_generic_file_read+1ee/4c0>
Trace; c022b620 <ext3_get_block+0/90>
Trace; c01eaf70 <file_read_actor+0/f0>
Trace; c01eb11d <generic_file_read+bd/1c0>
Trace; c01eaf70 <file_read_actor+0/f0>
Trace; c01fc1f3 <sys_read+a3/150>
Trace; c01bf3c3 <system_call+33/50>

Code;  c01f220a <__kmem_cache_alloc+11a/130>
00000000 <_EIP>:
Code;  c01f220a <__kmem_cache_alloc+11a/130>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01f220c <__kmem_cache_alloc+11c/130>
   2:   d6                        (bad)
Code;  c01f220d <__kmem_cache_alloc+11d/130>
   3:   04 c2                     add    $0xc2,%al
Code;  c01f220f <__kmem_cache_alloc+11f/130>
   5:   5c                        pop    %esp
Code;  c01f2210 <__kmem_cache_alloc+120/130>
   6:   35 c0 e9 09 ff            xor    $0xff09e9c0,%eax
Code;  c01f2215 <__kmem_cache_alloc+125/130>
   b:   ff                        (bad)
Code;  c01f2216 <__kmem_cache_alloc+126/130>
   c:   ff 89 f6 8d bc 27         decl   0x27bc8df6(%ecx)

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.




Older OOPS, less reliable (in fact may be utter crap):

ksymoops 2.4.9 on i686 2.4.26-grsec.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.26-grsec/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

invalid operand: 0000
CPU:    0
EIP:    0010:[<c023bcbd>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000005c   ebx: ce4aaac0   ecx: 00000000   edx: f623df58
esi: cd357600   edi: cd3575d0   ebp: d5705990   esp: f5e6de4c
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 2458, stackpage=f5ebd000)
Stack: c0340620 c033f013 c033ee79 0000073e c033f041 ce4aaac0 cd357600 c0237639
       ce4aaac0 00000040 f5e6dea0 00000ea5 f63f4000 c9765694 00000000 00000000
       00000000 00000000 c90171c0 d96c3630 00000ea0 c93f96c0 d751f8c0 cebb4440
Call Trace:    [<c0237639>] [<c0239c15>] [<c0239a80>] [<c01bd62e>] [<c0239aa0>]
Code: 0f 0b 3e 07 79 ee 33 c0 e9 48 ff ff ff 8d b6 00 00 00 00 8b


>>EIP; c023bcbd <__jbd_unexpected_dirty_buffer+4d/a0>   <=====

>>ebx; ce4aaac0 <_end+e121870/206a7e10>
>>esi; cd357600 <_end+cfce3b0/206a7e10>
>>edi; cd3575d0 <_end+cfce380/206a7e10>
>>ebp; d5705990 <_end+1537c740/206a7e10>

Trace; c0237639 <journal_commit_transaction+bd9/12e0>
Trace; c0239c15 <journal_cancel_revoke+45/f0>
Trace; c0239a80 <journal_revoke+20/170>
Trace; c01bd62e <arch_kernel_thread+2e/40>
Trace; c0239aa0 <journal_revoke+40/170>

Code;  c023bcbd <__jbd_unexpected_dirty_buffer+4d/a0>
00000000 <_EIP>:
Code;  c023bcbd <__jbd_unexpected_dirty_buffer+4d/a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c023bcbf <__jbd_unexpected_dirty_buffer+4f/a0>
   2:   3e                        ds
Code;  c023bcc0 <__jbd_unexpected_dirty_buffer+50/a0>
   3:   07                        pop    %es
Code;  c023bcc1 <__jbd_unexpected_dirty_buffer+51/a0>
   4:   79 ee                     jns    fffffff4 <_EIP+0xfffffff4>
Code;  c023bcc3 <__jbd_unexpected_dirty_buffer+53/a0>
   6:   33 c0                     xor    %eax,%eax
Code;  c023bcc5 <__jbd_unexpected_dirty_buffer+55/a0>
   8:   e9 48 ff ff ff            jmp    ffffff55 <_EIP+0xffffff55>
Code;  c023bcca <__jbd_unexpected_dirty_buffer+5a/a0>
   d:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c023bcd0 <__jbd_unexpected_dirty_buffer+60/a0>
  13:   8b 00                     mov    (%eax),%eax

Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<00000000>]    Not tainted
EFLAGS: 00010082
eax: 00000001   ebx: f083ed40   ecx: c342b0c0   edx: ce4aaac0
esi: f083ed40   edi: f796a840   ebp: 00000008   esp: f5cbfcb8
ds: 0018   es: 0018   ss: 0018
Process cp (pid: 2492, stackpage=f5cbf000)
Stack: c01f9bf0 ce4aaac0 00000001 f8a17f60 f083ed40 c0285ad1 f083ed40 00000001
       f8a17f50 f796a840 f8a17fe0 f796a840 f8a17f50 00000292 00000001 f8a211d5
       f796a840 00000001 f8a17f50 00000060 f8a17f50 f796a840 f8a17ea0 f8a109e7
Call Trace:    [<c01f9bf0>] [<f8a17f60>] [<c0285ad1>] [<f8a17f50>] [<f8a17fe0>]
  [<f8a17f50>] [<f8a211d5>] [<f8a17f50>] [<f8a17f50>] [<f8a17ea0>] [<f8a109e7>]
  [<f8a17f50>] [<f8a17f50>] [<f8a17f50>] [<f8a0b796>] [<f8a17f50>] [<f8a10950>]
  [<c01c0ec9>] [<c01c10db>] [<c01c3bd8>] [<c023bf1c>] [<f8a10950>] [<c0234cf4>]
  [<c022b88b>] [<c01c3bd8>] [<c022b581>] [<c022bc37>] [<c022b860>] [<c01ecaa1>]
  [<c01ed06f>] [<c0228c29>] [<c01fbe83>] [<c01bf3c3>]
Code: BAD EIP VALUE


>>EIP; 00000000 Before first symbol

>>ecx; c342b0c0 <_end+30a1e70/206a7e10>
>>edx; ce4aaac0 <_end+e121870/206a7e10>

Trace; c01f9bf0 <bounce_end_io_read+d0/f0>
Trace; f8a17f60 <END_OF_CODE+17fc2dd5/????>
Trace; c0285ad1 <account_io_end+31/50>
Trace; f8a17f50 <END_OF_CODE+17fc2dc5/????>
Trace; f8a17fe0 <END_OF_CODE+17fc2e55/????>
Trace; f8a17f50 <END_OF_CODE+17fc2dc5/????>
Trace; f8a211d5 <END_OF_CODE+17fcc04a/????>
Trace; f8a17f50 <END_OF_CODE+17fc2dc5/????>
Trace; f8a17f50 <END_OF_CODE+17fc2dc5/????>
Trace; f8a17ea0 <END_OF_CODE+17fc2d15/????>
Trace; f8a109e7 <END_OF_CODE+17fbb85c/????>
Trace; f8a17f50 <END_OF_CODE+17fc2dc5/????>
Trace; f8a17f50 <END_OF_CODE+17fc2dc5/????>
Trace; f8a17f50 <END_OF_CODE+17fc2dc5/????>
Trace; f8a0b796 <END_OF_CODE+17fb660b/????>
Trace; f8a17f50 <END_OF_CODE+17fc2dc5/????>
Trace; f8a10950 <END_OF_CODE+17fbb7c5/????>
Trace; c01c0ec9 <handle_IRQ_event+69/a0>
Trace; c01c10db <do_IRQ+8b/e0>
Trace; c01c3bd8 <call_do_IRQ+5/d>
Trace; c023bf1c <journal_destroy_journal_head_cache+2c/60>
Trace; f8a10950 <END_OF_CODE+17fbb7c5/????>
Trace; c0234cf4 <do_get_write_access+504/650>
Trace; c022b88b <ext3_getblk+1db/330>
Trace; c01c3bd8 <call_do_IRQ+5/d>
Trace; c022b581 <ext3_get_block_handle+261/300>
Trace; c022bc37 <ext3_prepare_write+a7/250>
Trace; c022b860 <ext3_getblk+1b0/330>
Trace; c01ecaa1 <precheck_file_write+21/2a0>
Trace; c01ed06f <do_generic_file_write+34f/4b0>
Trace; c0228c29 <ext3_check_dir_entry+69/f0>
Trace; c01fbe83 <generic_file_llseek+b3/e0>
Trace; c01bf3c3 <system_call+33/50>


1 warning issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

I wish :(

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux marc1.theaimsgroup.com 2.4.26-grsec #1 SMP Wed Jun 16 17:58:18 EDT
2004 i686 unknown unknown GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.25
e2fsprogs              1.35
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.3
Procps                 2.0.16
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         w83627hf eeprom w83781d i2c-proc i2c-isa
i2c-viapro i2c-dev i2c-core via-rhine crc32

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2500+
stepping        : 0
cpu MHz         : 1852.081
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3696.23

Was previously: two Athlon MP 2400's.

[7.3.] Module information (from /proc/modules):

w83627hf               12688   0 (unused)
eeprom                  3888   0 (unused)
w83781d                20656   0 (unused)
i2c-proc                6548   0 [w83627hf eeprom w83781d]
i2c-isa                  756   0 (unused)
i2c-viapro              3432   0
i2c-dev                 4160   0
i2c-core               14948   0 [w83627hf eeprom w83781d i2c-proc i2c-isa i2c-viapro i2c-dev]
via-rhine              13680   1
crc32                   2848   0 [via-rhine]

On the other motherboard, was eepro100 instead of via-rhine, and
slightly different i2c / sensors modules.

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

marc1:~(9)$ cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0290-0297 : w83697hf
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-5007 : viapro-smbus
d000-d00f : 3ware Inc 3ware 7000-series ATA-RAID
  d000-d00f : 3ware Storage Controller
d400-d41f : VIA Technologies, Inc. USB
d800-d81f : VIA Technologies, Inc. USB (#2)
dc00-dc1f : VIA Technologies, Inc. USB (#3)
e000-e00f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE
e400-e4ff : VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller
e800-e8ff : VIA Technologies, Inc. VT6102 [Rhine-II]
  e800-e8ff : via-rhine
marc1:~(10)$ cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d0fff : Extension ROM
000f0000-000fffff : System ROM
00100000-1feeffff : System RAM
  001bb000-00343f24 : Kernel code
1fef0000-1fef2fff : ACPI Non-volatile Storage
1fef3000-1fefffff : ACPI Tables
d0000000-d7ffffff : VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : PCI device 10de:0311 (nVidia Corporation)
e0000000-e1ffffff : PCI Bus #01
  e0000000-e0ffffff : PCI device 10de:0311 (nVidia Corporation)
e3000000-e37fffff : 3ware Inc 3ware 7000-series ATA-RAID
e3800000-e380000f : 3ware Inc 3ware 7000-series ATA-RAID
e3801000-e38010ff : VIA Technologies, Inc. USB 2.0
e3802000-e38020ff : VIA Technologies, Inc. VT6102 [Rhine-II]
  e3802000-e38020ff : via-rhine
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

Have also had the same symptoms with two Silicon Image CMD/SI680
controllers, instead of the 3Ware 7506 listed above.

[7.5.] PCI information ('lspci -vvv' as root)

marc1:~(2)# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge (rev 80)
        Subsystem: ABIT Computer Corp.: Unknown device 140f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [80] AGP version 3.5
                Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198 (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
        Subsystem: 3ware Inc 3ware 7000-series ATA-RAID
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2250ns min), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at d000 [size=16]
        Region 1: Memory at e3800000 (32-bit, non-prefetchable) [size=16]
        Region 2: Memory at e3000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 140f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 140f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 140f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin C routed to IRQ 21
        Region 4: I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 140f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 21
        Region 0: Memory at e3801000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: ABIT Computer Corp.: Unknown device 140f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: ABIT Computer Corp.: Unknown device 140f
        Control: I/O+ Mem+ BusMaster+ SpecCASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 20
        Region 4: I/O ports at e000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 50)
        Subsystem: ABIT Computer Corp.: Unknown device 140f
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 22
        Region 0: I/O ports at e400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
        Subsystem: ABIT Computer Corp.: Unknown device 140f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at e3802000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0311 (rev a1) (prog-if 00 [VGA])
        Subsystem: LeadTek Research Inc.: Unknown device 2952
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 3

[7.6.] SCSI information (from /proc/scsi/scsi)

marc1:~(3)# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: 3ware    Model: Logical Disk 0   Rev: 1.0
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: 3ware    Model: Logical Disk 1   Rev: 1.0
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: 3ware    Model: Logical Disk 2   Rev: 1.0
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: 3ware    Model: Logical Disk 3   Rev: 1.0
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff


Disks are four Maxtor 6Y200P0 drives, in a 3Ware RDC-400 hot-swap drive
cage, attached to the 3Ware 7506.  They are all in JBOD mode, using
software raid (RAID1 for / and /var, and RAID5 for data partitions),
since software RAID5 won all performance tests I did vs the 7506 (which
made me wonder why I'd dropped the $$$ for it, but never mind).

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

As stated this is the second motherboard the system's been on:
originally and for most of its life it was on a Tyan Tiger S2466 board,
with two Athlon MP 2400+ CPUs and three 1GB ECC DIMMs.

I doubt the GRsec patch has had anything to do with these problems, but
I'll upgrade to a virgin 2.4.27 anyway, and resume beating on the
system...

The system is running Slackware 9.1.0+patches.

I have another system which is similar in many ways: Tyan Tiger S2466,
2xAthlon MP 2600+'s, 3x 1GB ECC DIMM, 3Ware 7000 with 2 disks in HW
RAID1, 2.4.26-grsec, Slackware 9.1.0+patches.  That one is my primary
workstation, and has been rock-solid (cross fingers).  I've never
subjected it to the same exact workload as kills this one consistently,
though.

Here's the software-raid setup:

marc1:/proc(6)$ cat mdstat
Personalities : [linear] [raid0] [raid1] [raid5]
read_ahead 1024 sectors
md1 : active raid1 sdd1[2] sdc1[0] sdb1[3] sda1[1]
      2939776 blocks [4/4] [UUUU]

md3 : active raid1 sdd3[1] sdc3[2] sdb3[3] sda3[0]
      8795520 blocks [4/4] [UUUU]

md5 : active raid5 sdd5[3] sdc5[2] sdb5[1] sda5[0]
      139813248 blocks level 5, 128k chunk, algorithm 2 [4/4] [UUUU]

md6 : active raid5 sdd6[3] sdc6[2] sdb6[1] sda6[0]
      139789056 blocks level 5, 128k chunk, algorithm 2 [4/4] [UUUU]

md7 : active raid5 sdd7[3] sdc7[2] sdb7[1] sda7[0]
      139789056 blocks level 5, 128k chunk, algorithm 2 [4/4] [UUUU]

md8 : active raid5 sdd8[3] sdc8[2] sdb8[1] sda8[0]
      139861248 blocks level 5, 128k chunk, algorithm 2 [4/4] [UUUU]

unused devices: <none>


Here is the current .config (again, this has changed slightly since the
original, during my testing && hardware swapping):

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHIO=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
# CONFIG_X86_NUMA is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_ISA is not set
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_OOM_KILLER is not set
# CONFIG_PM is not set
# CONFIG_APM is not set

#
# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_RELAXED_AML is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_CISS_MONITOR_THREAD is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=7777
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_STATS=y

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_IRC is not set
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STEALTH=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_FTP=m
# CONFIG_IP_NF_MANGLE is not set
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
#   IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=m

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=m

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=m
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=m
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_MEDLEY is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=4
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=y
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_MEGARAID2 is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=y
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_FORCEDETH is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_SUNDANCE_MMIO is not set
# CONFIG_TLAN is not set
CONFIG_VIA_RHINE=m
CONFIG_VIA_RHINE_MMIO=y
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=512

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set

#
# Input core support is needed for gameports
#

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_KCS=m
CONFIG_IPMI_WATCHDOG=m

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
CONFIG_SOFT_WATCHDOG=m
# CONFIG_W83877F_WDT is not set
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_MACHZ_WDT is not set
CONFIG_AMD7XX_TCO=m
# CONFIG_SCx200 is not set
# CONFIG_SCx200_GPIO is not set
CONFIG_AMD_RNG=y
# CONFIG_INTEL_RNG is not set
CONFIG_HW_RANDOM=y
# CONFIG_AMD_PM768 is not set
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set

#
# Direct Rendering Manager (XFree86 DRI support)
#
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_OBMOUSE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_MINIX_FS=m
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_XFS_FS is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_TRACE is not set
# CONFIG_XFS_DEBUG is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Support for USB gadgets
#
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_LOG_BUF_SHIFT=17

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_SHA1 is not set
CONFIG_CRYPTO_SHA256=y
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

#
# Grsecurity
#
CONFIG_GRKERNSEC=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_SHA256=y
# CONFIG_GRKERNSEC_LOW is not set
# CONFIG_GRKERNSEC_MID is not set
# CONFIG_GRKERNSEC_HI is not set
CONFIG_GRKERNSEC_CUSTOM=y

#
# PaX Control
#
# CONFIG_GRKERNSEC_PAX_SOFTMODE is not set
CONFIG_GRKERNSEC_PAX_EI_PAX=y
CONFIG_GRKERNSEC_PAX_PT_PAX_FLAGS=y
CONFIG_GRKERNSEC_PAX_NO_ACL_FLAGS=y
# CONFIG_GRKERNSEC_PAX_HAVE_ACL_FLAGS is not set
# CONFIG_GRKERNSEC_PAX_HOOK_ACL_FLAGS is not set

#
# Address Space Protection
#
CONFIG_GRKERNSEC_PAX_NOEXEC=y
CONFIG_GRKERNSEC_PAX_PAGEEXEC=y
CONFIG_GRKERNSEC_PAX_SEGMEXEC=y
CONFIG_GRKERNSEC_PAX_EMUTRAMP=y
CONFIG_GRKERNSEC_PAX_EMUSIGRT=y
CONFIG_GRKERNSEC_PAX_MPROTECT=y
# CONFIG_GRKERNSEC_PAX_NOELFRELOCS is not set
CONFIG_GRKERNSEC_PAX_ASLR=y
CONFIG_GRKERNSEC_PAX_RANDKSTACK=y
CONFIG_GRKERNSEC_PAX_RANDUSTACK=y
CONFIG_GRKERNSEC_PAX_RANDMMAP=y
CONFIG_GRKERNSEC_PAX_RANDEXEC=y
# CONFIG_GRKERNSEC_KMEM is not set
# CONFIG_GRKERNSEC_IO is not set
# CONFIG_GRKERNSEC_PROC_MEMMAP is not set
# CONFIG_GRKERNSEC_HIDESYM is not set

#
# Role Based Access Control Options
#
# CONFIG_GRKERNSEC_ACL_HIDEKERN is not set
CONFIG_GRKERNSEC_ACL_MAXTRIES=3
CONFIG_GRKERNSEC_ACL_TIMEOUT=30

#
# Filesystem Protections
#
CONFIG_GRKERNSEC_PROC=y
# CONFIG_GRKERNSEC_PROC_USER is not set
CONFIG_GRKERNSEC_PROC_USERGROUP=y
CONFIG_GRKERNSEC_PROC_GID=18
# CONFIG_GRKERNSEC_PROC_ADD is not set
CONFIG_GRKERNSEC_LINK=y
CONFIG_GRKERNSEC_FIFO=y
CONFIG_GRKERNSEC_CHROOT=y
CONFIG_GRKERNSEC_CHROOT_MOUNT=y
CONFIG_GRKERNSEC_CHROOT_DOUBLE=y
CONFIG_GRKERNSEC_CHROOT_PIVOT=y
CONFIG_GRKERNSEC_CHROOT_CHDIR=y
CONFIG_GRKERNSEC_CHROOT_CHMOD=y
CONFIG_GRKERNSEC_CHROOT_FCHDIR=y
CONFIG_GRKERNSEC_CHROOT_MKNOD=y
CONFIG_GRKERNSEC_CHROOT_SHMAT=y
CONFIG_GRKERNSEC_CHROOT_UNIX=y
CONFIG_GRKERNSEC_CHROOT_FINDTASK=y
CONFIG_GRKERNSEC_CHROOT_NICE=y
CONFIG_GRKERNSEC_CHROOT_SYSCTL=y
CONFIG_GRKERNSEC_CHROOT_CAPS=y

#
# Kernel Auditing
#
# CONFIG_GRKERNSEC_AUDIT_GROUP is not set
# CONFIG_GRKERNSEC_EXECLOG is not set
CONFIG_GRKERNSEC_RESLOG=y
CONFIG_GRKERNSEC_CHROOT_EXECLOG=y
# CONFIG_GRKERNSEC_AUDIT_CHDIR is not set
CONFIG_GRKERNSEC_AUDIT_MOUNT=y
CONFIG_GRKERNSEC_AUDIT_IPC=y
CONFIG_GRKERNSEC_SIGNAL=y
CONFIG_GRKERNSEC_FORKFAIL=y
CONFIG_GRKERNSEC_TIME=y
CONFIG_GRKERNSEC_PROC_IPADDR=y
# CONFIG_GRKERNSEC_AUDIT_TEXTREL is not set

#
# Executable Protections
#
CONFIG_GRKERNSEC_EXECVE=y
# CONFIG_GRKERNSEC_DMESG is not set
CONFIG_GRKERNSEC_RANDPID=y
# CONFIG_GRKERNSEC_TPE is not set

#
# Network Protections
#
CONFIG_GRKERNSEC_RANDNET=y
CONFIG_GRKERNSEC_RANDISN=y
CONFIG_GRKERNSEC_RANDID=y
CONFIG_GRKERNSEC_RANDSRC=y
CONFIG_GRKERNSEC_RANDRPC=y
# CONFIG_GRKERNSEC_SOCKET is not set

#
# Sysctl support
#
CONFIG_GRKERNSEC_SYSCTL=y

#
# Logging options
#
CONFIG_GRKERNSEC_FLOODTIME=1
CONFIG_GRKERNSEC_FLOODBURST=4


Um.... help :-P

Thanks,

Hank Leininger <hlein@progressive-comp.com>
E407 AEF4 761E D39C D401  D4F4 22F8 EF11 861A A6F1
-----BEGIN PGP SIGNATURE-----

iD8DBQFBHYpxIvjvEYYapvERAhw/AJ0QWVmMPOK9e74IYW6xB12Sf7bNBQCfesh+
8RtIjVL95cp0wBpeRATYGhI=
=Q5F/
-----END PGP SIGNATURE-----
