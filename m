Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbUBXSsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbUBXSsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:48:12 -0500
Received: from mailgate.terastack.com ([195.173.195.66]:32004 "EHLO
	mail.synaxia.com") by vger.kernel.org with ESMTP id S262401AbUBXSqr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:46:47 -0500
Message-ID: <AD4480A509455343AEFACCC231BA850FF0FE5A@ukexchange>
From: Martin Dorey <mdorey@bluearc.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: Martin Dorey <mdorey@bluearc.com>
Subject: init_dev accesses out-of-bounds tty index
Date: Tue, 24 Feb 2004 18:15:11 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(nvidia) tainted kernel warning so you may wish to stop reading here.

I've tried to just raise a bug (my first), but I get this every time:

> Bugzilla has suffered an internal error. Please save this page and send it
to THE MAINTAINER HAS NOT YET BEEN SET with details of what you were doing
at the time this message appeared. 
> URL: http://bugzilla.kernel.org/post_bug.cgi
> A legal Architecture was not set.	

I couldn't see any Architecture field for me to fill out.  So I'll revert to
using a FAQ proforma:

[1.] One line summary of the problem:

init_dev accesses out-of-bounds tty index

[2.] Full description of the problem/report:

Much like http://www.ussg.iu.edu/hypermail/linux/kernel/0310.1/0741.html I
got an oops and then seemingly couldn't fork new processes.  I couldn't
login and Ctrl-Alt-Del from the console didn't reboot.  This has happened
three times now in the week since I upgraded from a 2.4 kernel to 2.6.2 (and
never happened before) so I figured it might be worth reporting even though
the kernel is tainted by nvidia.

This seems to be the repeatable stack:

Feb 24 02:09:18 doozer kernel: EIP:    0060:[init_dev+31/1367]    Tainted:
PF
...
Feb 24 02:09:18 doozer kernel:  [dput+34/603] dput+0x22/0x25b
Feb 24 02:09:18 doozer kernel:  [in_group_p+37/45] in_group_p+0x25/0x2d
Feb 24 02:09:18 doozer kernel:  [ext3_permission+172/404]
ext3_permission+0xac/0x194
Feb 24 02:09:18 doozer kernel:  [tty_open+144/900] tty_open+0x90/0x384
Feb 24 02:09:18 doozer kernel:  [chrdev_open+291/657]
chrdev_open+0x123/0x291
Feb 24 02:09:18 doozer kernel:  [get_empty_filp+104/219]
get_empty_filp+0x68/0xdb
Feb 24 02:09:18 doozer kernel:  [dentry_open+338/546]
dentry_open+0x152/0x222
Feb 24 02:09:18 doozer kernel:  [filp_open+98/100] filp_open+0x62/0x64
Feb 24 02:09:18 doozer kernel:  [sys_open+91/139] sys_open+0x5b/0x8b
Feb 24 02:09:18 doozer kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

[3.] Keywords (i.e., modules, networking, kernel):

I've not much idea.

[4.] Kernel version (from /proc/version):

Linux version 2.6.2 (root@doozer) (gcc version 3.3.3 (Debian)) #9 SMP Mon
Feb 23 15:00:28 GMT 2004

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Feb 24 02:05:01 doozer /USR/SBIN/CRON[28598]: (martind) CMD (ping -c 4 kenny
> /dev/null || ~/bin/doozer-to-kenny)
Feb 24 02:05:17 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 24 02:05:49 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 24 02:06:21 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 24 02:07:25 doozer last message repeated 2 times
Feb 24 02:07:57 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 24 02:08:01 doozer /USR/SBIN/CRON[29700]: (mail) CMD (  if [ -x
/usr/sbin/exim -a -f /etc/exim/exim.conf ]; th
en /usr/sbin/exim -q ; fi)
Feb 24 02:08:29 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 24 02:09:01 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Feb 24 02:09:18 doozer kernel: Unable to handle kernel paging request at
virtual address 00e000b2
Feb 24 02:09:18 doozer kernel:  printing eip:
Feb 24 02:09:18 doozer kernel: c024758a
Feb 24 02:09:18 doozer kernel: *pde = 00000000
Feb 24 02:09:18 doozer kernel: Oops: 0000 [#1]
Feb 24 02:09:18 doozer kernel: CPU:    0
Feb 24 02:09:18 doozer kernel: EIP:    0060:[init_dev+31/1367]    Tainted:
PF
Feb 24 02:09:18 doozer kernel: EFLAGS: 00010246
Feb 24 02:09:18 doozer kernel: EIP is at init_dev+0x1f/0x557
Feb 24 02:09:18 doozer kernel: eax: 00e0001b   ebx: ca89ca80   ecx: c0452e1c
edx: 00008802
Feb 24 02:09:18 doozer kernel: esi: 00e00016   edi: ca89ca80   ebp: 00e0001b
esp: c3ee5e98
Feb 24 02:09:18 doozer kernel: ds: 007b   es: 007b   ss: 0068
Feb 24 02:09:18 doozer kernel: Process sh (pid: 30151, threadinfo=c3ee4000
task=ea661310)
Feb 24 02:09:18 doozer kernel: Stack: 00e0001b 00000000 f7c1c480 f18f8005
00000003 f18f8005 00000000 f7fe8240
Feb 24 02:09:18 doozer kernel:        00000000 f7c63380 c27d411c c0174d4d
f7c63380 c0134dfd 00000005 c01a5da8
Feb 24 02:09:18 doozer kernel:        ca89ca80 00e00016 ca89ca80 00500000
c0248497 00e00016 00e0001b c3ee5f00
Feb 24 02:09:18 doozer kernel: Call Trace:
Feb 24 02:09:18 doozer kernel:  [dput+34/603] dput+0x22/0x25b
Feb 24 02:09:18 doozer kernel:  [in_group_p+37/45] in_group_p+0x25/0x2d
Feb 24 02:09:18 doozer kernel:  [ext3_permission+172/404]
ext3_permission+0xac/0x194
Feb 24 02:09:18 doozer kernel:  [tty_open+144/900] tty_open+0x90/0x384
Feb 24 02:09:18 doozer kernel:  [chrdev_open+291/657]
chrdev_open+0x123/0x291
Feb 24 02:09:18 doozer kernel:  [get_empty_filp+104/219]
get_empty_filp+0x68/0xdb
Feb 24 02:09:18 doozer kernel:  [dentry_open+338/546]
dentry_open+0x152/0x222
Feb 24 02:09:18 doozer kernel:  [filp_open+98/100] filp_open+0x62/0x64
Feb 24 02:09:18 doozer kernel:  [sys_open+91/139] sys_open+0x5b/0x8b
Feb 24 02:09:18 doozer kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 24 02:09:18 doozer kernel:
Feb 24 02:09:18 doozer kernel: Code: 8b 86 9c 00 00 00 8b 1c a8 85 db 74 62
8b 83 a0 00 00 00 a9

I've not yet found the necessary incantation to make /proc/ksyms spring into
existence for the benefit of ksymoops but I did some disassembly on one of
the earlier instances:

Feb 19 12:19:19 doozer kernel: Unable to handle kernel paging request at
virtual address 006000dc
Feb 19 12:19:19 doozer kernel:  printing eip:
Feb 19 12:19:19 doozer kernel: c023b9ef
Feb 19 12:19:19 doozer kernel: *pde = 00000000
Feb 19 12:19:19 doozer kernel: Oops: 0000 [#1]
Feb 19 12:19:19 doozer kernel: CPU:    0
Feb 19 12:19:19 doozer kernel: EIP:    0060:[init_dev+31/1344]    Tainted:
PF
Feb 19 12:19:19 doozer kernel: EFLAGS: 00010246
Feb 19 12:19:19 doozer kernel: EIP is at init_dev+0x1f/0x540
Feb 19 12:19:19 doozer kernel: eax: 00600041   ebx: d3896000   ecx: c043dad8
edx: 00008802
Feb 19 12:19:19 doozer kernel: esi: 00600040   edi: f566ba40   ebp: 00600041
esp: d3897e98
Feb 19 12:19:19 doozer kernel: ds: 007b   es: 007b   ss: 0068
Feb 19 12:19:19 doozer kernel: Process sh (pid: 1805, threadinfo=d3896000
task=f77d66a0)
Feb 19 12:19:19 doozer kernel: Stack: 00600041 00000000 e0b7c780 e9586005
00299a31 00000003 00000000 d3897f70
Feb 19 12:19:19 doozer kernel:        f7ff4280 d3897f00 00000000 f7cfe9c0
c0169ce2 c012cfc5 00000005 c019983d
Feb 19 12:19:19 doozer kernel:        d3896000 00600040 f566ba40 00500000
c023c788 00600040 00600041 d3897f00
Feb 19 12:19:19 doozer kernel: Call Trace:
Feb 19 12:19:19 doozer kernel:  [dput+34/528] dput+0x22/0x210
Feb 19 12:19:19 doozer kernel:  [in_group_p+37/48] in_group_p+0x25/0x30
Feb 19 12:19:19 doozer kernel:  [ext3_permission+173/416]
ext3_permission+0xad/0x1a0
Feb 19 12:19:19 doozer kernel:  [tty_open+152/880] tty_open+0x98/0x370
Feb 19 12:19:19 doozer kernel:  [tty_open+0/880] tty_open+0x0/0x370
Feb 19 12:19:19 doozer kernel:  [chrdev_open+230/528] chrdev_open+0xe6/0x210
Feb 19 12:19:19 doozer kernel:  [open_namei+165/1024] open_namei+0xa5/0x400
Feb 19 12:19:19 doozer kernel:  [dentry_open+322/528]
dentry_open+0x142/0x210
Feb 19 12:19:19 doozer kernel:  [filp_open+98/112] filp_open+0x62/0x70
Feb 19 12:19:19 doozer kernel:  [sys_open+91/144] sys_open+0x5b/0x90
Feb 19 12:19:19 doozer kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 19 12:19:19 doozer kernel:
Feb 19 12:19:19 doozer kernel: Code: 8b 86 9c 00 00 00 8b 1c a8 85 db 74 60
8b 83 a0 00 00 00 a9

$ gdb /usr/src/linux-2.6.2/vmlinux
(gdb) x/10i init_dev
0xc023b8d0 <init_dev>:  push   %ebp
0xc023b8d1 <init_dev+1>:        push   %edi
0xc023b8d2 <init_dev+2>:        push   %esi
0xc023b8d3 <init_dev+3>:        push   %ebx
0xc023b8d4 <init_dev+4>:        sub    $0x40,%esp
0xc023b8d7 <init_dev+7>:        mov    0x58(%esp,1),%ebp
0xc023b8db <init_dev+11>:       mov    0x54(%esp,1),%esi
0xc023b8df <init_dev+15>:       movl   $0x0,0x18(%esp,1)
0xc023b8e7 <init_dev+23>:       mov    %ebp,(%esp,1)
0xc023b8ea <init_dev+26>:       call   0xc023b890 <down_tty_sem>
(gdb)
0xc023b8ef <init_dev+31>:       mov    0x9c(%esi),%eax

static int init_dev(struct tty_driver *driver, int idx,
	struct tty_struct **ret_tty)
{
	struct tty_struct *tty, *o_tty;
	struct termios *tp, **tp_loc, *o_tp, **o_tp_loc;
	struct termios *ltp, **ltp_loc, *o_ltp, **o_ltp_loc;
	int retval=0;

	/*
	 * Check whether we need to acquire the tty semaphore to avoid
	 * race conditions.  For now, play it safe.
	 */
	down_tty_sem(idx);

	/* check whether we're reopening an existing tty */
	tty = driver->ttys[idx];

[6.] A small shell script or example program which triggers the
     problem (if possible)

It's not happened enough times that I know what the active ingredient is.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

doozer:/usr/src/linux-2.6.2$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux doozer 2.6.2 #9 SMP Mon Feb 23 15:00:28 GMT 2004 i686 GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.35-WIP
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.15
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         nvidia ipv6 eepro100 mii
doozer:/usr/src/linux-2.6.2$

[7.2.] Processor information (from /proc/cpuinfo):

doozer:/usr/src/linux-2.6.2$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 2606.420
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5144.57

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 2606.420
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5193.72

doozer:/usr/src/linux-2.6.2$

[7.3.] Module information (from /proc/modules):

doozer:/usr/src/linux-2.6.2$ cat /proc/modules
nvidia 2073096 12 - Live 0xf8c11000
ipv6 259904 17 - Live 0xf898b000
eepro100 31884 0 - Live 0xf8937000
mii 6144 1 eepro100, Live 0xf8929000
doozer:/usr/src/linux-2.6.2$

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

doozer:/usr/src/linux-2.6.2$ cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-041f : 0000:00:1f.3
0cf8-0cff : PCI conf1
d800-d8ff : 0000:02:05.0
df00-df3f : 0000:02:0d.0
  df00-df3f : e100
e800-e8ff : 0000:00:1f.5
ee80-eebf : 0000:00:1f.5
ef00-ef1f : 0000:00:1d.0
ef20-ef3f : 0000:00:1d.1
ef40-ef5f : 0000:00:1d.2
ef80-ef9f : 0000:00:1d.3
fc00-fc0f : 0000:00:1f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1
doozer:/usr/src/linux-2.6.2$

doozer:/usr/src/linux-2.6.2$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-7ff2ffff : System RAM
  00100000-003957d2 : Kernel code
  003957d3-004a82ff : Kernel data
7ff30000-7ff3ffff : ACPI Tables
7ff40000-7ffeffff : ACPI Non-volatile Storage
7fff0000-7fffffff : reserved
80000000-800003ff : 0000:00:1f.1
dff00000-efefffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
f4000000-f7ffffff : 0000:00:00.0
fc900000-fe9fffff : PCI Bus #01
  fd000000-fdffffff : 0000:01:00.0
feac0000-feadffff : 0000:02:0d.0
  feac0000-feadffff : e100
feafb000-feafbfff : 0000:02:0d.0
  feafb000-feafbfff : e100
feafc000-feafffff : 0000:02:05.0
febff400-febff4ff : 0000:00:1f.5
febff800-febff9ff : 0000:00:1f.5
febffc00-febfffff : 0000:00:1d.7
ffb80000-ffffffff : reserved
doozer:/usr/src/linux-2.6.2$

[7.5.] PCI information ('lspci -vvv' as root)

doozer:/usr/src/linux-2.6.2$ sudo lspci -vvv
00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 80f6
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [2106]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP+ GART64- 64bit- FW-
Rate=x8

00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fc900000-fe9fffff
        Prefetchable memory behind bridge: dff00000-efefffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at ef00 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at ef20 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at ef40 [size=32]

00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at ef80 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02) (prog-if 20
[EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fea00000-feafffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev
02) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at fc00 [size=16]
        Region 5: Memory at 80000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at 0400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio
Controller (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 80f3
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at e800 [size=256]
        Region 1: I/O ports at ee80 [size=64]
        Region 2: Memory at febff800 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at febff400 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200]
(rev a1) (prog-if 00 [VGA])
        Subsystem: CardExpert Technology: Unknown device 0405
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at fe9e0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x8

02:05.0 Ethernet controller: 3Com Corporation 3c940 1000Base? (rev 12)
        Subsystem: Asustek Computer, Inc.: Unknown device 80eb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (5750ns min, 7750ns max), Cache Line Size: 0x04 (16
bytes)
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at feafc000 (32-bit, non-prefetchable) [size=16K]
        Region 1: I/O ports at d800 [size=256]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=7 DScale=1 PME-
        Capabilities: [50] Vital Product Data

02:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
0c)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at feafb000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at df00 [size=64]
        Region 2: Memory at feac0000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

doozer:/usr/src/linux-2.6.2$

[7.6.] SCSI information (from /proc/scsi/scsi)

doozer:/usr/src/linux-2.6.2$ cat /proc/scsi/scsi
Attached devices:
doozer:/usr/src/linux-2.6.2$

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

I have a PPP connection.

[X.] Other notes, patches, fixes, workarounds:

I've no idea of how to workaround or fix.

-- 
Martin, BlueArc Engineering

