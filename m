Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316678AbSGZA1B>; Thu, 25 Jul 2002 20:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSGZA1B>; Thu, 25 Jul 2002 20:27:01 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:29179 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S316678AbSGZA1A>;
	Thu, 25 Jul 2002 20:27:00 -0400
Date: Thu, 25 Jul 2002 20:30:07 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpqarray broken since 2.5.19
Message-ID: <20020726003007.GA17013@www.kroptech.com>
References: <20020721152804.GA6273@www.kroptech.com> <20020724133959.GD5159@suse.de> <20020725003235.GA5345@www.kroptech.com> <20020725103940.GA8761@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020725103940.GA8761@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 12:39:40PM +0200, Jens Axboe wrote:
> Could you please repeat the expirement with the 2.5.28 just released,
> and record any oopses :-)

Done. Same behavior. It oopses when I insmod if I build as a module. Just
hardlocks, no oops, if I build it in statically. Below is the decoded oops
from the module case. I couldn't get module symbols since it dies when I
insmod so let me know if the trace looks fishy.

--Adam
 
ksymoops 2.4.1 on i686 2.5.28.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.28/ (default)
     -m /boot/System.map-2.5.28 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol GPLONLY___wake_up_sync not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_idle_cpu not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_set_cpus_allowed not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000000
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<ca89b725>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: c784fe80   ecx: 00000001   edx: 00000000
esi: c889cc00   edi: c889cc00   ebp: c9679e20   esp: c9679db8
ds: 0018   es: 0018   ss: 0018
Stack: 00000002 00000286 c0365e40 00000000 00000001 c784fe80 24000001 00000005 
       c9679e20 c0108e9a 00000005 c889cc00 c9679e20 c9679e20 c03608a0 00000005 
       c784fe80 c0109082 00000005 c9679e20 c784fe80 00000000 c8fbf980 c8fbf980 
Call Trace: [<c0108e9a>] [<c0109082>] [<c0107978>] [<c0167a6c>] [<c0153a1f>] 
   [<c012bf10>] [<c0262ec1>] [<c01319f3>] [<c0131b9c>] [<c0148bf3>] [<c02674d7>] 
   [<c0163360>] [<c013b094>] [<c0148f99>] [<c02635d4>] [<c013b213>] [<c0107033>] 
Code: f0 fe 08 0f 88 fa 14 00 00 83 e1 01 0f 84 01 02 00 00 e9 ea 

>>EIP; ca89b725 <END_OF_CODE+a4c0185/????>   <=====
Trace; c0108e9a <handle_IRQ_event+3a/60>
Trace; c0109082 <do_IRQ+a2/110>
Trace; c0107978 <common_interrupt+18/20>
Trace; c0167a6c <.text.lock.inode+eb/ff>
Trace; c0153a1f <__mark_inode_dirty+2f/c0>
Trace; c012bf10 <generic_file_write+3b0/760>
Trace; c0262ec1 <sys_recvfrom+a1/100>
Trace; c01319f3 <__alloc_pages+53/1f0>
Trace; c0131b9c <__get_free_pages+c/50>
Trace; c0148bf3 <__pollwait+33/a0>
Trace; c02674d7 <datagram_poll+27/d3>
Trace; c0163360 <ext3_file_write+0/60>
Trace; c013b094 <do_readv_writev+204/2e0>
Trace; c0148f99 <do_select+259/270>
Trace; c02635d4 <sys_socketcall+154/200>
Trace; c013b213 <sys_writev+43/54>
Trace; c0107033 <syscall_call+7/b>
Code;  ca89b725 <END_OF_CODE+a4c0185/????>
00000000 <_EIP>:
Code;  ca89b725 <END_OF_CODE+a4c0185/????>   <=====
   0:   f0 fe 08                  lock decb (%eax)   <=====
Code;  ca89b728 <END_OF_CODE+a4c0188/????>
   3:   0f 88 fa 14 00 00         js     1503 <_EIP+0x1503> ca89cc28 <END_OF_CODE+a4c1688/????>
Code;  ca89b72e <END_OF_CODE+a4c018e/????>
   9:   83 e1 01                  and    $0x1,%ecx
Code;  ca89b731 <END_OF_CODE+a4c0191/????>
   c:   0f 84 01 02 00 00         je     213 <_EIP+0x213> ca89b938 <END_OF_CODE+a4c0398/????>
Code;  ca89b737 <END_OF_CODE+a4c0197/????>
  12:   e9 ea 00 00 00            jmp    101 <_EIP+0x101> ca89b826 <END_OF_CODE+a4c0286/????>

 <0>Kernel panic: Aiee, killing interrupt handler!

5 warnings issued.  Results may not be reliable.

