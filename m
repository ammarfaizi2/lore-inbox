Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSH3WfC>; Fri, 30 Aug 2002 18:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSH3WfC>; Fri, 30 Aug 2002 18:35:02 -0400
Received: from pD952CCAE.dip.t-dialin.net ([217.82.204.174]:55537 "EHLO
	akira.comlounge.net") by vger.kernel.org with ESMTP
	id <S311025AbSH3We6>; Fri, 30 Aug 2002 18:34:58 -0400
Date: Sat, 31 Aug 2002 00:39:13 +0200
From: Diego Biurrun <diego@biurrun.de>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Oops after removing PCMCIA modem with low latency patch
Message-ID: <20020830223913.GB412@maxx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

I just tried your 2.4.19-low-latency patch on a stock 2.4.19 kernel and
my box oopses when I manually remove my PCMCIA modem.  I know I should
probably use cardctl eject, but I guess the kernel should not oops in
any case and other PCMCIA cards do not have that problem.

I spent the whole day trying to debug the oops because minicom and my
serial console do not seem to want to get along.  I suspect a hardware
bug somewhere, I always got garbled output.  I managed to capture the
output once but was not able to reproduce the correct settings again, so
apologies if I cannot provide the correct information.

Back to topic: I figured you might be interested in this, so I am
sending you the output of ksymoops.  If you need more information I will
be more than happy to provide it.
Thanks for your work on the Linux kernel.
Regards

Diego Biurrun


My system:
Toshiba Satellite 320CDT
Pentium MMX 233 96MB RAM

output of cardctl ident:
Socket 0:
  product info: "Kingston", "KNE-CB4TX", "", "1.00"
  manfid: 0x0186, 0x0101
  function: 6 (network)
Socket 1:
  product info: "ROCKWELL", "RFI AnyCom-Eco 336 PC Card", "021", "A"
  manfid: 0x0175, 0x0000
  function: 2 (serial)

output of lspci -v:

00:00.0 Host bridge: Toshiba America Info Systems 601 (rev a0)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: bus master, medium devsel, latency 0

00:04.0 VGA compatible controller: Chips and Technologies F65555 HiQVPro (rev c6) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: stepping, medium devsel
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at <unassigned> [disabled] [size=256K]

00:0b.0 USB Controller: NEC Corporation USB (rev 02) (prog-if 10 [OHCI])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at fcfff000 (32-bit, non-prefetchable) [size=4K]

00:11.0 Communication controller: Toshiba America Info Systems FIR Port (rev 21)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: bus master, slow devsel, latency 64, IRQ 11
	I/O ports at ffe0 [size=32]

00:13.0 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: bus master, slow devsel, latency 0, IRQ 11
	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=14, subordinate=14, sec-latency=0
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

00:13.1 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: bus master, slow devsel, latency 0, IRQ 11
	Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=15, subordinate=15, sec-latency=0
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001

14:00.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: Kingston Technologies: Unknown device 0002
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at 4000 [size=128]
	Memory at 10800000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at 10400000 [size=256K]


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=output

ksymoops 2.4.5 on i586 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at sched.c:577!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0112de9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 00000018   ebx: c024a000   ecx: c3378000   edx: 00000001
esi: 00000000   edi: c3147280   ebp: c024be18   esp: c024bdf4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c024b000)
Stack: c01ed4de c024a000 00000000 c3147280 c11f2ba0 00000001 00000000 c024a000 
       c0164127 c024be20 c0113d15 c35b753c c013272f c3147280 00000000 c0215860 
       c35b753c c0142647 c3147280 c3147280 c0143046 c3147280 c35447a0 c34a1ec0 
Call Trace:    [<c0164127>] [<c0113d15>] [<c013272f>] [<c0142647>] [<c0143046>]
  [<c0165bad>] [<c0140cc3>] [<c01643b0>] [<c01649ba>] [<c0164a0f>] [<c016e1ef>]
  [<c0115aa3>] [<c01159e7>] [<c0181136>] [<c725cd4a>] [<c725cd1c>] [<c011c94f>]
  [<c0119482>] [<c01193b6>] [<c01191ca>] [<c0109b9d>] [<c0106d10>] [<c010bd28>]
  [<c0106d10>] [<c0106d33>] [<c0106d97>] [<c0105000>] [<c0105027>]
Code: 0f 0b 41 02 d6 d4 1e c0 83 c4 04 8b 4d f4 c1 e1 05 81 c1 40 


>>EIP; c0112de9 <schedule+4d/2f4>   <=====

>>ebx; c024a000 <init_task_union+0/2000>
>>ecx; c3378000 <_end+30e93ac/6f9f3ac>
>>edi; c3147280 <_end+2eb862c/6f9f3ac>
>>ebp; c024be18 <init_task_union+1e18/2000>
>>esp; c024bdf4 <init_task_union+1df4/2000>

Trace; c0164127 <_devfs_walk_path+5f/d4>
Trace; c0113d15 <set_running_and_schedule+1d/24>
Trace; c013272f <invalidate_inode_buffers+1b/88>
Trace; c0142647 <clear_inode+b/b0>
Trace; c0143046 <iput+d6/1ac>
Trace; c0165bad <devfs_d_iput+59/68>
Trace; c0140cc3 <dput+c3/124>
Trace; c01643b0 <free_dentry+3c/44>
Trace; c01649ba <_devfs_unregister+36/74>
Trace; c0164a0f <devfs_unregister+17/24>
Trace; c016e1ef <tty_unregister_devfs+43/50>
Trace; c0115aa3 <release_console_sem+73/78>
Trace; c01159e7 <printk+ff/114>
Trace; c0181136 <unregister_serial+5e/7c>
Trace; c725cd4a <[serial_cs]serial_release+2e/80>
Trace; c725cd1c <[serial_cs]serial_release+0/80>
Trace; c011c94f <timer_bh+26b/384>
Trace; c0119482 <bh_action+1a/40>
Trace; c01193b6 <tasklet_hi_action+4a/70>
Trace; c01191ca <do_softirq+5a/ac>
Trace; c0109b9d <do_IRQ+a1/b4>
Trace; c0106d10 <default_idle+0/28>
Trace; c010bd28 <call_do_IRQ+5/d>
Trace; c0106d10 <default_idle+0/28>
Trace; c0106d33 <default_idle+23/28>
Trace; c0106d97 <cpu_idle+3f/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105027 <rest_init+27/28>

Code;  c0112de9 <schedule+4d/2f4>
00000000 <_EIP>:
Code;  c0112de9 <schedule+4d/2f4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0112deb <schedule+4f/2f4>
   2:   41                        inc    %ecx
Code;  c0112dec <schedule+50/2f4>
   3:   02 d6                     add    %dh,%dl
Code;  c0112dee <schedule+52/2f4>
   5:   d4 1e                     aam    $0x1e
Code;  c0112df0 <schedule+54/2f4>
   7:   c0 83 c4 04 8b 4d f4      rolb   $0xf4,0x4d8b04c4(%ebx)
Code;  c0112df7 <schedule+5b/2f4>
   e:   c1 e1 05                  shl    $0x5,%ecx
Code;  c0112dfa <schedule+5e/2f4>
  11:   81 c1 40 00 00 00         add    $0x40,%ecx

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

--h31gzZEtNLTqOjlF--
