Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUE3RiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUE3RiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 13:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbUE3RiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 13:38:24 -0400
Received: from adsl-63-204-64-251.dsl.scrm01.pacbell.net ([63.204.64.251]:39040
	"HELO juju.brown-dog.org") by vger.kernel.org with SMTP
	id S264261AbUE3Rhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 13:37:51 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.26 SMP Lockup
From: Jeff Coffin <linux-kernel@browndog.org>
Date: Sun, 30 May 2004 10:38:03 -0700
Message-ID: <m3zn7pizno.fsf@juju.brown-dog.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -


I've been getting lockups at random times for a while on this
hardware:

supermicro P3TDDE MB
2 x P3s 1.13 GHz
1G ECC SDRAM (HIGHMEM is enabled)


It's a hard lockup that doesn't respond to SysRq.  This is the first
time I've caught anything with the serial console.  Once before, I got
the beginnings of an oops, but not enough to be useful.  Sometimes it
happens a couple of times in a day, sometimes it will stay up for a
month or more.  I haven't found any way to force it yet.  The system
is a workstation, all filesystems are XFS FWIW.

The tainting is from the Cisco vpnclient (version 4.0.1) which I use
for work.  I'll try and get one without that loaded as well since I
know that usually means all bets are off.  I'll also try and get SysRq
P and T next time it locks, but usually SysRq doesn't appear to work.

Anyhow, here's the oops run through ksymoops:


--jeff

ksymoops 2.4.9 on i686 2.4.26.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.26/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to<1>Unable to handle kernel paging request at virtual address
fce6f1d4
c010a170
*pde = 00000000
Oops: 0002
EIP:    0010:[<c010a170>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: 3cad8800   ebx: 00000030   ecx: 00005575   edx: e000dd8c
esi: e000dd8c   edi: c0393efe   ebp: e000dd7c   esp: e000dd6c
ds: 0018   es: 0018   ss: 0018
Process  (pid: 1447181, stackpage=e000d000)
Stack: 61000000 060000fe 00000005 c03a7ce0 e000ddc4 c010966a e000dd8c 00000000
       00000005 00005575 000003fd c03a7ce0 c0393efe e000ddc4 c03a7c00 00000018
       00000018 c03a7c00 c022eb3a 00000010 00000002 000f4064 e000ddf0 c02346e0
Call Trace:    [<c010966a>] [<c022eb3a>] [<c02346e0>] [<c011f0b0>] [<c011f195>] [<c011f4e3>] [<c011f401>] [<c011a487>] [<c011a230>] [<c01095e0>] [<c011a285>]
Code: ff 80 d4 69 39 c0 f6 c3 c0 75 35 8b 0d 44 4d 32 c0 85 c9 74


>>EIP; c010a170 <do_nmi+20/b0>   <=====

>>edx; e000dd8c <_end+1fc519b4/38449c88>
>>esi; e000dd8c <_end+1fc519b4/38449c88>
>>edi; c0393efe <log_buf+557e/8000>
>>ebp; e000dd7c <_end+1fc519a4/38449c88>
>>esp; e000dd6c <_end+1fc51994/38449c88>

Trace; c010966a <nmi+1e/30>
Trace; c022eb3a <serial_in+1a/30>
Trace; c02346e0 <serial_console_write+80/210>
Trace; c011f0b0 <__call_console_drivers+60/70>
Trace; c011f195 <call_console_drivers+65/120>
Trace; c011f4e3 <release_console_sem+53/b0>
Trace; c011f401 <printk+141/180>
Trace; c011a487 <do_page_fault+257/564>
Trace; c011a230 <do_page_fault+0/564>
Trace; c01095e0 <error_code+34/3c>
Trace; c011a285 <do_page_fault+55/564>

Code;  c010a170 <do_nmi+20/b0>
00000000 <_EIP>:
Code;  c010a170 <do_nmi+20/b0>   <=====
   0:   ff 80 d4 69 39 c0         incl   0xc03969d4(%eax)   <=====
Code;  c010a176 <do_nmi+26/b0>
   6:   f6 c3 c0                  test   $0xc0,%bl
Code;  c010a179 <do_nmi+29/b0>
   9:   75 35                     jne    40 <_EIP+0x40>
Code;  c010a17b <do_nmi+2b/b0>
   b:   8b 0d 44 4d 32 c0         mov    0xc0324d44,%ecx
Code;  c010a181 <do_nmi+31/b0>
  11:   85 c9                     test   %ecx,%ecx
Code;  c010a183 <do_nmi+33/b0>
  13:   74 00                     je     15 <_EIP+0x15>

NMI Watchdog detected LOCKUP on CPU1, eip c011e4e2, registers:
CPU:    1
EIP:    0010:[<c011e4e2>]    Tainted: PF
EFLAGS: 00200086
eax: f3962930   ebx: c590d098   ecx: f09bb5f4   edx: c590d09c
esi: c590d008   edi: 00200296   ebp: d224dec4   esp: d224deb8
ds: 0018   es: 0018   ss: 0018
Process X (pid: 11167, stackpage=d224d000)
Stack: c590d098 c590d008 c590d000 d224ded8 c015572e 00000000 00000000 00000013
       d224df18 c0155a2b d224df04 00000000 d224c000 00000304 00040000 d224c000
       00003535 00000001 00000000 00000000 c590d000 00000000 f69c6560 f69c6580
Call Trace:    [<c015572e>] [<c0155a2b>] [<c0155eab>] [<c0110cd1>] [<c0108608>] [<c01094ef>]
Code: f3 90 7e f9 e9 49 e9 ff ff 80 3d 40 52 32 c0 00 f3 90 7e f5


>>EIP; c011e4e2 <.text.lock.fork+1b/129>   <=====

>>eax; f3962930 <_end+335a6558/38449c88>
>>ebx; c590d098 <_end+5550cc0/38449c88>
>>ecx; f09bb5f4 <_end+305ff21c/38449c88>
>>edx; c590d09c <_end+5550cc4/38449c88>
>>esi; c590d008 <_end+5550c30/38449c88>
>>ebp; d224dec4 <_end+11e91aec/38449c88>
>>esp; d224deb8 <_end+11e91ae0/38449c88>

Trace; c015572e <poll_freewait+2e/50>
Trace; c0155a2b <do_select+13b/230>
Trace; c0155eab <sys_select+34b/4f0>
Trace; c0110cd1 <restore_i387+91/d0>
Trace; c0108608 <restore_sigcontext+128/140>
Trace; c01094ef <system_call+33/38>

Code;  c011e4e2 <.text.lock.fork+1b/129>
00000000 <_EIP>:
Code;  c011e4e2 <.text.lock.fork+1b/129>   <=====
   0:   f3 90                     repz nop    <=====
Code;  c011e4e4 <.text.lock.fork+1d/129>
   2:   7e f9                     jle    fffffffd <_EIP+0xfffffffd>
Code;  c011e4e6 <.text.lock.fork+1f/129>
   4:   e9 49 e9 ff ff            jmp    ffffe952 <_EIP+0xffffe952>
Code;  c011e4eb <.text.lock.fork+24/129>
   9:   80 3d 40 52 32 c0 00      cmpb   $0x0,0xc0325240
Code;  c011e4f2 <.text.lock.fork+2b/129>
  10:   f3 90                     repz nop 
Code;  c011e4f4 <.text.lock.fork+2d/129>
  12:   7e f5                     jle    9 <_EIP+0x9>


1 warning issued.  Results may not be reliable.
