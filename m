Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130469AbQLEAGK>; Mon, 4 Dec 2000 19:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129855AbQLEAGB>; Mon, 4 Dec 2000 19:06:01 -0500
Received: from gw2-int.ensim.com ([38.186.181.2]:44540 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S129547AbQLEAFz>; Mon, 4 Dec 2000 19:05:55 -0500
From: Borislav Deianov <borislav@ensim.com>
Date: Mon, 4 Dec 2000 15:35:28 -0800
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, tytso@mit.edu
Subject: SCSI Oops (was test12-pre4)
Message-ID: <20001204153527.A5425@aero.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(cross-posted to linux-kernel and linux-scsi)

Hi,

The SCSI oops I reported last week is still present in test12-pre4.
This is on a Dell PowerEdge 6300. It has two Adaptec AIC-7890, one
Adaptec AIC-7860, and an AMI MegaRAID controller. There's nothing on
the 7890s, a CDROM and a tape drive on the 7890.

With all of the above enabled the kernel boots with no problems.
However, if I disable the two 7890s from the BIOS (to save 30 seconds
of boot time), I get an oops.

The decoded oops is below. Please email me directly for further
information.

Thanks,
Borislav

ksymoops 2.3.5 on i686 2.4.0-test12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12/ (default)
     -m linux-2.4.0-test12-pre4/System.map (specified)

activating NMI Watchdog ... done.
cpu: 0, clocks: 999937, slice: 199987
cpu: 1, clocks: 999937, slice: 199987
cpu: 2, clocks: 999937, slice: 199987
cpu: 3, clocks: 999937, slice: 199987
Unable to handle kernel NULL pointer dereference at virtual address 00000001
c019698f
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c019698f>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: f7dd0000   ebx: 000000ff   ecx: 00000000   edx: 000000ff
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c2139b80
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c2139000)
Stack: 00000000 f7dd0000 f7dd2878 f7dd2a34 00000028 ff000000 c01980c2 f7dd2878 
       f7dd0000 00000000 00000000 ffffffff 000000ff 00000000 f7dd2878 00000000 
       f7de3200 f7de3200 000000ff 001135d0 00000000 00000000 ff1aa8c3 c01aaec8 
Call Trace: [<ff000000>] [<c01980c2>] [<ff1aa8c3>] [<c01aaec8>] [<c01ab143>] [<c01ab3d8>] [<c018b613>] 
       [<c018b6a2>] [<c019025c>] [<c0191adc>] [<c0190f9b>] [<c018b872>] [<c018b772>] [<c018b1d8>] [<c01946a1>] 
       [<c012f494>] [<c01200ff>] [<c016ea3d>] [<c021f3f4>] [<c016eaca>] [<c018b1cc>] [<c01944c6>] [<c0105000>] 
       [<c017512b>] [<c01218a4>] [<c0112156>] [<c011a9f1>] [<c0105000>] [<c018c647>] [<c0105000>] [<c014f1e4>] 
       [<c0105000>] [<c0105000>] [<c018cd1d>] [<c0107031>] [<c0105000>] [<c0109153>] 
Code: 8a 57 01 88 d0 c0 e8 04 0f b6 d8 89 5c 24 10 88 d0 c0 e8 03 

>>EIP; c019698f <aic7xxx_match_scb+1f/98>   <=====
Trace; ff000000 <END_OF_CODE+6767307/????>
Trace; c01980c2 <aic7xxx_search_qinfifo+b2/3f4>
Trace; ff1aa8c3 <END_OF_CODE+6911bca/????>
Trace; c01aaec8 <aic7xxx_build_negotiation_cmnd+f4/20c>
Trace; c01ab143 <aic7xxx_buildscb+163/33c>
Trace; c01ab3d8 <aic7xxx_queue+bc/14c>
Trace; c018b613 <scsi_dispatch_cmd+9f/18c>
Trace; c018b6a2 <scsi_dispatch_cmd+12e/18c>
Trace; c019025c <scsi_old_done+0/5cc>
Trace; c0191adc <scsi_request_fn+370/39c>
Trace; c0190f9b <scsi_insert_special_req+77/8c>
Trace; c018b872 <scsi_do_req+c6/cc>
Trace; c018b772 <scsi_wait_req+72/ac>
Trace; c018b1d8 <scsi_wait_done+0/24>
Trace; c01946a1 <scan_scsis_single+e9/638>
Trace; c012f494 <__get_free_pages+14/24>
Trace; c01200ff <do_proc_doulongvec_minmax+10b/300>
Trace; c016ea3d <blk_init_free_list+19/64>
Trace; c021f3f4 <tvecs+13f38/15a44>
Trace; c016eaca <blk_init_queue+42/8c>
Trace; c018b1cc <scsi_initialize_queue+1c/28>
Trace; c01944c6 <scan_scsis+326/418>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c017512b <scrup+6b/108>
Trace; c01218a4 <update_process_times+20/94>
Trace; c0112156 <smp_apic_timer_interrupt+e6/f4>
Trace; c011a9f1 <printk+1a1/1b0>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c018c647 <scsi_register_host+1cf/2d8>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c014f1e4 <create_proc_entry+11c/12c>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c018cd1d <scsi_register_module+2d/5c>
Trace; c0107031 <init+31/1b0>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0109153 <kernel_thread+23/30>
Code;  c019698f <aic7xxx_match_scb+1f/98>
00000000 <_EIP>:
Code;  c019698f <aic7xxx_match_scb+1f/98>   <=====
   0:   8a 57 01                  mov    0x1(%edi),%dl   <=====
Code;  c0196992 <aic7xxx_match_scb+22/98>
   3:   88 d0                     mov    %dl,%al
Code;  c0196994 <aic7xxx_match_scb+24/98>
   5:   c0 e8 04                  shr    $0x4,%al
Code;  c0196997 <aic7xxx_match_scb+27/98>
   8:   0f b6 d8                  movzbl %al,%ebx
Code;  c019699a <aic7xxx_match_scb+2a/98>
   b:   89 5c 24 10               mov    %ebx,0x10(%esp,1)
Code;  c019699e <aic7xxx_match_scb+2e/98>
   f:   88 d0                     mov    %dl,%al
Code;  c01969a0 <aic7xxx_match_scb+30/98>
  11:   c0 e8 03                  shr    $0x3,%al

Kernel panic: Attempted to kill init!
activating NMI Watchdog ... done.
cpu: 0, clocks: 999948, slice: 199989
cpu: 1, clocks: 999948, slice: 199989
cpu: 2, clocks: 999948, slice: 199989
cpu: 3, clocks: 999948, slice: 199989

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
