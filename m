Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbUBPDt1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 22:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265366AbUBPDt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 22:49:27 -0500
Received: from [220.249.10.10] ([220.249.10.10]:30085 "EHLO
	mail.goldenhope.com.cn") by vger.kernel.org with ESMTP
	id S265359AbUBPDtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 22:49:18 -0500
Date: Mon, 16 Feb 2004 11:49:09 +0800
From: lepton <lepton@mail.goldenhope.com.cn>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG]linux-2.4.24 with k8 numa support panic when init scsi
Message-ID: <20040216034909.GA11557@lepton.goldenhope.com.cn>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040208143740.GA25010@lepton.goldenhope.com.cn.suse.lists.linux.kernel> <p73y8rdk3ng.fsf@verdi.suse.de> <20040209035356.GA27697@lepton.goldenhope.com.cn> <20040210143208.7b1d9940.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210143208.7b1d9940.ak@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have do some test on weekend. The result is:

1. Compiling kernel with gcc 3.2:
   2.4.20 2.4.21: can boot, can mount reiserfs filesystem
   2.4.22: can boot, can mount reiserfs filesystem, but will panic
   when reboot. It is perhaps because of "reboot=triple" ? 
   2.4.23: panic when init scsi, like before.
   2.4.24: can boot, can mount reiserfs filesystem, but will panic when
   reboot.

2. Compiling kernel with gcc 3.3
   2.4.20: can not compile.... 
   2.4.21: can boot, can mount reiserfs filesystem
   2.4.22: can boot, can mount reiserfs filesystem, but will panic when
   reboot.
   2.4.23: panic when init scsi, like before
   2.4.24: panic when init scsi, like before

3. when panic, reboot=bios or reboot=triple both can not work.

   2.4.24 changes a little from 2.4.23, so it is strange system will
   panic in 2.4.23 and don't panic in 2.4.24 when using gcc 3.2
   Perhaps there is some random error?


The following is the panic message when reboot.

CPU 0 
Pid: 307, comm: reboot Not tainted
RIP: 0010:[<ffffffff8010c564>]
Using defaults from ksymoops -t elf32-i386 -a i386
RSP: 0000:00000100fbbe9e58  EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000fee1dead RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000017 RDI: 0000000000805000
RBP: 00000000ffffddac R08: 0000000000000000 R09: 0000000000010000
R10: 00000100fbbe8000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff8036f080(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 00000000a00e7a00 CR3: 0000000000101000 CR4: 00000000000006e0
Process reboot (pid: 307, stackpage=100fbbe9000)
Stack: 00000100fbbe9e58 0000000000000000 ffffffff8010c4df 00000000fee1dead 
       00000000ffffddac 0000000000000000 ffffffff80128ec3 000001007e9b4240 
       0000000000008914 0000000000000003 ffffffff801a0844 00000000006e7574 
       0000000000000000 fa00a8c000000002 0000000000000000 0000010000000078 
       00000100fba6b880 000001007ffe2400 ffffffff80159df9 00000100fba6b880 
       0000000000000216 000001007af2ed40 0000000000000216 000001007af2ed40 
       ffffffff80157761 00000100fba6b880 000001007e9b4240 000001007fffb240 
       ffffffff80143934 0000000000000000 000001007e9b4240 0000010003cb0740 
       0000000000000000 0000000000000000 ffffffff8014232e 0000000000000003 
       00000000ffffddbc 0000000000000000 ffffffff801423d5 00000000fee1dead 
Call Trace: [<ffffffff8010c4df>] [<ffffffff80128ec3>] 
       [<ffffffff801a0844>] [<ffffffff80159df9>] [<ffffffff80157761>] 
       [<ffffffff80143934>] [<ffffffff8014232e>] [<ffffffff801423d5>] 
       [<ffffffff8019b373>] 
Code: 0f 01 1d 45 26 17 00 cc b8 6b 00 00 00 c7 05 85 f6 19 00 6b 


>>EIP; ffffffff8010c564 <machine_restart+94/b0>   <=====

>>RBX; fee1dead Before first symbol
>>RDI; 00805000 Before first symbol
>>RBP; ffffddac Before first symbol
>>R09; 00010000 Before first symbol
>>R10; 100fbbe8000 Before first symbol

Trace; ffffffff8010c4df <machine_restart+f/b0>
Trace; ffffffff80128ec3 <sys_reboot+213/2a0>
Trace; ffffffff801a0844 <dev_ifsioc+d4/1b0>
Trace; ffffffff80159df9 <clear_inode+9/c0>
Trace; ffffffff80157761 <dput+21/1a0>
Trace; ffffffff80143934 <fput+104/150>
Trace; ffffffff8014232e <filp_close+ce/f0>
Trace; ffffffff801423d5 <sys_close+85/a0>
Trace; ffffffff8019b373 <ia32_syscall+67/71>

Code;  8010c564 Before first symbol
00000000 <_EIP>:
Code;  8010c564 Before first symbol
   0:   0f 01 1d 45 26 17 00      lidtl  0x172645
Code;  8010c56b Before first symbol
   7:   cc                        int3   
Code;  8010c56c Before first symbol
   8:   b8 6b 00 00 00            mov    $0x6b,%eax
Code;  8010c571 Before first symbol
   d:   c7 05 85 f6 19 00 6b      movl   $0x6b,0x19f685
Code;  8010c578 Before first symbol
  14:   00 00 00 

 <0>Kernel BUG at smp:321
invalid operand: 0000
CPU 0 
Pid: 306, comm: S90reboot Not tainted
RIP: 0010:[<ffffffff80117c04>]
RSP: 0000:000001007ae65dd8  EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 00000000a017121c RSI: 000001007ff18d40 RDI: 0000000000000002
RBP: 0000010082a74098 R08: 00000000fb4ea065 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 000001007ff18d40
R13: 00000000fb4ea067 R14: 0000000000000007 R15: 000001007e75fb88
FS:  0000000000000000(0000) GS:ffffffff8036f080(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 00000000a017121c CR3: 0000000000101000 CR4: 00000000000006e0
Process S90reboot (pid: 306, stackpage=1007ae65000)
Stack: 000001007ae65dd8 0000000000000000 00000100fbc23780 000001007ff18d40 
       ffffffff8012db5c 0000000000000001 00000000a017121c 000001007e7a6140 
       ffffffff8012e505 0000010080011028 00000000a017121c 000001007ff18d40 
       0000000000000001 000001007e7a6140 0000000000000007 000001007ae65f58 
       ffffffff8012e7d5 0000000000000000 00000000a017121c 000001007ae64000 
       000001007ff18d70 000001007ff18d40 ffffffff80199f1e 0000010082b66000 
       ffffffff801b3309 000001007ae65ec8 0000000000000007 0000000000000000 
       0000000000030002 000001007ff18d40 ffffffff8012f4e8 0000000000000002 
       0000000080152f64 0000000000000077 000000000000034b fffffffffffffff7 
       0000010003caa080 0000000000000022 00000100fbc23780 00000100fbc237c0 
Call Trace: [<ffffffff8012db5c>] [<ffffffff8012e505>] 
       [<ffffffff8012e7d5>] [<ffffffff80199f1e>] [<ffffffff801b3309>] 
       [<ffffffff8012f4e8>] [<ffffffff80127ab9>] [<ffffffff8010eb82>] 
Code: 0f 0b 95 e0 27 80 ff ff ff ff 41 01 65 8b 0c 25 24 00 00 00 


>>EIP; 80117c04 Before first symbol   <=====

>>RDX; a017121c Before first symbol
>>RSI; 7ff18d40 Before first symbol
>>RBP; 82a74098 Before first symbol
>>R08; fb4ea065 Before first symbol
>>R12; 7ff18d40 Before first symbol
>>R13; fb4ea067 Before first symbol
>>R15; 7e75fb88 Before first symbol

Trace; ffffffff8012db5c <do_wp_page+14c/3d0>
Trace; ffffffff8012e505 <do_no_page+55/230>
Trace; ffffffff8012e7d5 <handle_mm_fault+f5/130>
Trace; ffffffff80199f1e <do_page_fault+1ce/544>
Trace; ffffffff801b3309 <tty_ioctl+439/460>
Trace; ffffffff8012f4e8 <do_mmap_pgoff+338/5d0>
Trace; ffffffff80127ab9 <sys_rt_sigprocmask+159/180>
Trace; ffffffff8010eb82 <error_exit+0/5>

Code;  80117c04 Before first symbol
00000000 <_EIP>:
Code;  80117c04 Before first symbol   <=====
   0:   0f 0b                     ud2a      <=====
Code;  80117c06 Before first symbol
   2:   95                        xchg   %eax,%ebp
Code;  80117c07 Before first symbol
   3:   e0 27                     loopne 2c <_EIP+0x2c>
Code;  80117c09 Before first symbol
   5:   80 ff ff                  cmp    $0xff,%bh
Code;  80117c0c Before first symbol
   8:   ff                        (bad)  
Code;  80117c0d Before first symbol
   9:   ff 41 01                  incl   0x1(%ecx)
Code;  80117c10 Before first symbol
   c:   65 8b 0c 25 24 00 00      mov    %gs:0x24,%ecx
Code;  80117c17 Before first symbol
  13:   00 





On Tue, Feb 10, 2004 at 02:32:08PM +0100, Andi Kleen wrote:
> And it boots with numa=off ? 

> Try reboot=bios or reboot=triple

> If you used an NUMA kernel can you please check which kernel 
> revision (between 2.4.20 and 2.4.24) broke it?
> 
> I'm a bit suspicious of this compiler. Any chance you could try it with a gcc 3.2 too? 

> -Andi
