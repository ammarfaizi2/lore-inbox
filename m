Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319193AbSIJPC6>; Tue, 10 Sep 2002 11:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319195AbSIJPC6>; Tue, 10 Sep 2002 11:02:58 -0400
Received: from horkos.telenet-ops.be ([195.130.132.45]:30124 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S319193AbSIJPC4>; Tue, 10 Sep 2002 11:02:56 -0400
Subject: Re: 2.4.19: Oops -> problem with aha152x driver
From: Frederik Himpe <fhimpe@pandora.be>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: fischer@norbit.de
In-Reply-To: <1031596539.2580.12.camel@Jupiter>
References: <1031596539.2580.12.camel@Jupiter>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 10 Sep 2002 17:07:35 +0200
Message-Id: <1031670457.2291.11.camel@Jupiter>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-09 at 20:35, Frederik Himpe wrote:
<snip kernel oops with aha152x driver for Adaptec AVA-1505AE ISA card)

Sorry, the oops I sent was not complete, here is a complete one. It
seems that the aha152x driver is the problem. If I compile the aha152x
module from 2.4.18, I don't get the oops.

ksymoops 2.4.5 on i686 2.4.19-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-xfs/ (default)
     -m /boot/System.map-2.4.19-xfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

cpu: 0, clocks: 1002236, slice: 501118
SGI XFS snapshot 2.4.19-2002-08-03_04:15_UTC with ACLs, realtime, quota, no debug enabled
Unable to handle kernel NULL pointer dereference at virtual address 0000001b
d08f22a0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d08f22a0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000000   ebx: c5db5000   ecx: cedb8000   edx: c5a0caa0
esi: cf6e0400   edi: 00000004   ebp: c5c65d88   esp: c5c65d6c
ds: 0018   es: 0018   ss: 0018
Process xsane (pid: 2196, stackpage=c5c65000)
Stack: cfffc0c0 00000020 c010d098 00000297 00000293 c12e0ab4 c5db5000 c5c65da4 
       d08f23c0 c5db5000 00000000 00000000 00000000 d08d9f70 c5c65de0 d08d9684 
       c5db5000 d08d9f70 d08de760 00000004 c12e0b16 c12e0a60 c12e0ab4 ceba4ca0 
Call Trace:    [<c010d098>] [<d08f23c0>] [<d08d9f70>] [<d08d9684>] [<d08d9f70>]
  [<d08de760>] [<d08e22ce>] [<d08e1765>] [<d08e17f9>] [<d08d9a7a>] [<d23ea2e0>]
  [<d23e90b2>] [<d23ea2e0>] [<d23e8df3>] [<d23e8bd7>] [<c013ce3c>] [<c0109307>]
Code: 0f b6 50 1b 8b 14 95 d8 b5 30 c0 2b 82 9c 00 00 00 c1 f8 02 


>>EIP; d08f22a0 <[aha152x]aha152x_internal_queue+100/1f0>   <=====

>>ebx; c5db5000 <_end+5a8213c/1059d19c>
>>ecx; cedb8000 <_end+ea8513c/1059d19c>
>>edx; c5a0caa0 <_end+56d9bdc/1059d19c>
>>esi; cf6e0400 <_end+f3ad53c/1059d19c>
>>ebp; c5c65d88 <_end+5932ec4/1059d19c>
>>esp; c5c65d6c <_end+5932ea8/1059d19c>

Trace; c010d098 <call_do_IRQ+5/d>
Trace; d08f23c0 <[aha152x]aha152x_queue+30/40>
Trace; d08d9f70 <[scsi_mod]scsi_done+0/d0>
Trace; d08d9684 <[scsi_mod]scsi_dispatch_cmd+124/390>
Trace; d08d9f70 <[scsi_mod]scsi_done+0/d0>
Trace; d08de760 <[scsi_mod]scsi_times_out+0/d0>
Trace; d08e22ce <[scsi_mod]scsi_request_fn+18e/310>
Trace; d08e1765 <[scsi_mod]__scsi_insert_special+55/80>
Trace; d08e17f9 <[scsi_mod]scsi_insert_special_req+29/30>
Trace; d08d9a7a <[scsi_mod]scsi_do_req+da/1c0>
Trace; d23ea2e0 <[sg]sg_cmd_done_bh+0/370>
Trace; d23e90b2 <[sg]sg_common_write+202/290>
Trace; d23ea2e0 <[sg]sg_cmd_done_bh+0/370>
Trace; d23e8df3 <[sg]sg_new_write+1c3/280>
Trace; d23e8bd7 <[sg]sg_write+2f7/350>
Trace; c013ce3c <sys_write+9c/130>
Trace; c0109307 <system_call+33/38>

Code;  d08f22a0 <[aha152x]aha152x_internal_queue+100/1f0>
00000000 <_EIP>:
Code;  d08f22a0 <[aha152x]aha152x_internal_queue+100/1f0>   <=====
   0:   0f b6 50 1b               movzbl 0x1b(%eax),%edx   <=====
Code;  d08f22a4 <[aha152x]aha152x_internal_queue+104/1f0>
   4:   8b 14 95 d8 b5 30 c0      mov    0xc030b5d8(,%edx,4),%edx
Code;  d08f22ab <[aha152x]aha152x_internal_queue+10b/1f0>
   b:   2b 82 9c 00 00 00         sub    0x9c(%edx),%eax
Code;  d08f22b1 <[aha152x]aha152x_internal_queue+111/1f0>
  11:   c1 f8 02                  sar    $0x2,%eax


1 warning issued.  Results may not be reliable.


