Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUANRSg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 12:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbUANRLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 12:11:34 -0500
Received: from newpeace.netnation.com ([204.174.223.7]:16277 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP id S264469AbUANRHy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 12:07:54 -0500
Date: Wed, 14 Jan 2004 09:07:53 -0800
From: Simon Kirby <sim@netnation.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 SMP lockups
Message-ID: <20040114170753.GB8467@netnation.com>
References: <20040109210450.GA31404@netnation.com> <Pine.LNX.4.58L.0401101719400.1310@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0401101719400.1310@logos.cnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 05:32:55PM -0200, Marcelo Tosatti wrote:

> This sounds like a deadlock. I wonder why the NMI watchdog is not
> triggering.

Well, with the NMI watchdog working (nmi_watchdog=2), we just had another
occurrence.  This time, I had the serial console ready. :)

I'm guessing this is the same as the previous cases; however, this time
sysrq-P was able to print information from both CPUs.  I assume the NMI
watchdog unlocked interrupts from what would have been the stuck CPU?

NMI Watchdog detected LOCKUP on CPU0, eip c011c7cb, registers:
CPU:    0
EIP:    0010:[<c011c7cb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000086
eax: ddadf5d0   ebx: d8a2e000   ecx: 00000000   edx: d8a2fe50
esi: d8a2fe50   edi: 00000286   ebp: 00020690   esp: d8a2fe30
ds: 0018   es: 0018   ss: 0018
Process php4 (pid: 19197, stackpage=d8a2f000)
Stack: d8a2e000 d8a2fe50 ddadf5d0 c015a8e4 00000000 d8a2e000 00000000 00000000 
       00000000 d8a2e000 ddadf5d4 ddadf5d4 ddadf520 ddadf520 c1ce4178 c015b40b 
       ddadf520 0000c82f 00000018 0000ffff c1ce4178 00020690 f7b73c00 c015b881 
Call Trace:    [<c015a8e4>] [<c015b40b>] [<c015b881>] [<c0176e68>] [<c014e792>]
  [<c014ec7c>] [<c014f259>] [<c014f81e>] [<c01418ce>] [<c0141cf3>] [<c010926f>]
Code: f3 90 7e f9 e9 8d e9 ff ff 80 3d c0 a3 31 c0 00 f3 90 7e f5 

>>EIP; c011c7ca <.text.lock.fork+1a/120>   <=====
Trace; c015a8e4 <__wait_on_freeing_inode+74/a0>
Trace; c015b40a <find_inode+6a/80>
Trace; c015b880 <iget4+60/110>
Trace; c0176e68 <ext3_lookup+78/a0>
Trace; c014e792 <real_lookup+f2/140>
Trace; c014ec7c <link_path_walk+31c/6f0>
Trace; c014f258 <path_lookup+38/40>
Trace; c014f81e <open_namei+6e/690>
Trace; c01418ce <filp_open+3e/70>
Trace; c0141cf2 <sys_open+52/c0>
Trace; c010926e <system_call+32/38>
Code;  c011c7ca <.text.lock.fork+1a/120>
00000000 <_EIP>:
Code;  c011c7ca <.text.lock.fork+1a/120>   <=====
   0:   f3 90                     repz nop    <=====
Code;  c011c7cc <.text.lock.fork+1c/120>
   2:   7e f9                     jle    fffffffd <_EIP+0xfffffffd>
Code;  c011c7ce <.text.lock.fork+1e/120>
   4:   e9 8d e9 ff ff            jmp    ffffe996 <_EIP+0xffffe996>
Code;  c011c7d2 <.text.lock.fork+22/120>
   9:   80 3d c0 a3 31 c0 00      cmpb   $0x0,0xc031a3c0
Code;  c011c7da <.text.lock.fork+2a/120>
  10:   f3 90                     repz nop 
Code;  c011c7dc <.text.lock.fork+2c/120>
  12:   7e f5                     jle    9 <_EIP+0x9>

console shuts up ... 
 <6>SysRq : Show Regs
SysRq : Show State
SysRq : Changing Loglevel
Loglevel set to 1
SysRq : Show Regs
SysRq : Changing Loglevel
Loglevel set to 0
SysRq : Show Regs
SysRq : Changing Loglevel
Loglevel set to 9
SysRq : Emergency Sync
Syncing device 08:01 ... OK
Syncing device 08:05 ... OK
Syncing device 08:06 ... OK
Syncing device 08:07 ... OK
Done.
SysRq : Show Regs

Pid: 0, comm:              swapper
EIP: 0010:[<c0106f8c>] CPU: 1 EFLAGS: 00000246    Not tainted
EAX: 00000000 EBX: c0106f60 ECX: 00000000 EDX: c1c14000
ESI: c1c14000 EDI: c1c14000 EBP: ffffe000 DS: 0018 ES: 0018
CR0: 8005003b CR2: 409cd000 CR3: 36c30000 CR4: 000006d0
Call Trace:    [<c0107022>] [<c011d3e1>] [<c011d65f>]

>>EIP; c0106f8c <default_idle+2c/50>   <=====
Trace; c0107022 <cpu_idle+52/70>
Trace; c011d3e0 <call_console_drivers+60/120>
Trace; c011d65e <printk+14e/180>

SysRq : Show Regs

Pid: 0, comm:              swapper
EIP: 0010:[<c0106f8c>] CPU: 0 EFLAGS: 00000246    Not tainted
EAX: 00000000 EBX: c0106f60 ECX: 00000000 EDX: c0334000
ESI: c0334000 EDI: c0334000 EBP: ffffe000 DS: 0018 ES: 0018
CR0: 8005003b CR2: 40809000 CR3: 36473000 CR4: 000006d0
Call Trace:    [<c0107022>] [<c0105000>]

>>EIP; c0106f8c <default_idle+2c/50>   <=====
Trace; c0107022 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>

Hmm... It appears both CPUs are idling after the NMI, so maybe something
was just holding the fork lock for too long.  I'll post this anyway,
though, incase I'm missing something. 

I also have an entire sysrq-T, but it is for over 500 processes, so I
posted the entire serial capture log as well, as a few other things
here:

	http://blue.netnation.com/sim/ref/2.4.24_stuck_cpu/

Additional information available upon request.

Simon-
