Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSE1C2V>; Mon, 27 May 2002 22:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSE1C2U>; Mon, 27 May 2002 22:28:20 -0400
Received: from mta011pub.verizon.net ([206.46.170.174]:20951 "EHLO
	mta011.verizon.net") by vger.kernel.org with ESMTP
	id <S311749AbSE1C2Q>; Mon, 27 May 2002 22:28:16 -0400
Message-ID: <3CF2EB18.6050100@verizon.net>
Date: Mon, 27 May 2002 22:27:36 -0400
From: "Anthony R." <russo.lutions@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops report in filemap_fdatawait
Content-Type: multipart/mixed;
 boundary="------------030204050003080209090506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030204050003080209090506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Attached is the kernel oops my system recently experienced.
I ran this through ksymoops and the problem appears
to be in filemap_fdatawait. I'll be happy to help debug this
if I can. All relevant info should be below.

------

I do not notice any obvious problem with my machine or kernel as
a result of this, but an oops is an oops and I'm sure someone will want 
to fix it.

Kernel version: 2.4.18 (no custom mods)

I do not know what triggers the problem as it is rather sporadic.

My environment is: PIII 500 MHz CPU on standard PC hardware
with 642MB RAM, ASUS P3B motherboard, 1 IDE drive,
2 SCSI drives, 2 ethernet boards, a soundcard, etc.

/proc/cpuinfo is:

processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 7
model name    : Pentium III (Katmai)
stepping    : 3
cpu MHz        : 501.145
cache size    : 512 KB
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 2
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips    : 999.42

/proc/modules:

opl3                   13448   0 (autoclean)
smbfs                  31872   1 (autoclean)
ppp_async               6112   1
apm                     9372   2
sb                      7520   1 (autoclean)
ppa                     9376   0 (unused)
rtc                     5656   0 (unused)
ppp_synctty             4640   0 (unused)
ppp_generic            14472   3 [ppp_async ppp_synctty]
slhc                    4608   0 [ppp_generic]
n_hdlc                  6016   0 (unused)
sb_lib                 32864   0 [sb]
uart401                 6208   0 [sb_lib]
sound                  54284   1 [opl3 sb_lib uart401]
soundcore               3588   5 [sb_lib sound]
isa-pnp                29160   0 [sb]
nfsd                   66976   8 (autoclean)
lockd                  47328   1 (autoclean) [nfsd]
sunrpc                 59732   1 (autoclean) [nfsd lockd]
parport_pc             25896   2 (autoclean)
lp                      6080   0 (autoclean)
ipt_ttl                  576   1 (autoclean)
ipt_limit                928  35 (autoclean)
ipt_unclean             6784   3 (autoclean)
ip_nat_irc              2912   0 (unused)
ip_nat_ftp              3584   0 (unused)
ipt_state                576   7 (autoclean)
iptable_mangle          2080   0 (unused)
ipt_LOG                 3392   1
ipt_MASQUERADE          1728   1
ipt_TOS                  960   0 (unused)
ipt_REDIRECT             704   0 (unused)
iptable_nat            19220   3 [ip_nat_irc ip_nat_ftp ipt_MASQUERADE 
ipt_REDIRECT]
ipt_REJECT              2784   0 (unused)
ip_conntrack_irc        2784   0 [ip_nat_irc]
ip_conntrack_ftp        3680   0 [ip_nat_ftp]
ip_conntrack           20108   4 [ip_nat_irc ip_nat_ftp ipt_state 
ipt_MASQUERADE ipt_REDIRECT iptable_nat ip_conntrack_irc ip_conntrack_ftp]
iptable_filter          1696   1 (autoclean)
ip_tables              13248  14 [ipt_ttl ipt_limit ipt_unclean 
ipt_state iptable_mangle ipt_LOG ipt_MASQUERADE ipt_TOS ipt_REDIRECT 
iptable_nat ipt_REJECT iptable_filter]
fa312                   4684   1
usb-uhci               21348   0 (unused)
usbcore                54528   1 [usb-uhci]


Output of ver_linux is:

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         opl3 smbfs ppp_async apm sb ppa rtc ppp_synctty 
ppp_generic slhc n_hdlc sb_lib uart401 sound soundcore isa-pnp nfsd 
lockd sunrpc parport_pc lp ipt_ttl ipt_limit ipt_unclean ip_nat_irc 
ip_nat_ftp ipt_state iptable_mangle ipt_LOG ipt_MASQUERADE ipt_TOS 
ipt_REDIRECT iptable_nat ipt_REJECT ip_conntrack_irc ip_conntrack_ftp 
ip_conntrack iptable_filter ip_tables fa312 usb-uhci usbcore

/proc/meminfo:

 total:    used:    free:  shared: buffers:  cached:
Mem:  658268160 649777152  8491008        0 344199168 174309376
Swap: 1052827648 528293888 524533760
MemTotal:       642840 kB
MemFree:          8292 kB
MemShared:           0 kB
Buffers:        336132 kB
Cached:         100204 kB
SwapCached:      70020 kB
Active:         319640 kB
Inactive:       267672 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       642840 kB
LowFree:          8292 kB
SwapTotal:     1028152 kB
SwapFree:       512240 kB

/proc/scsi/scsi:

Attached devices:
Host: scsi2 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: DDYS-T36950N     Rev: S93E
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 12 Lun: 00
  Vendor: IBM      Model: IC35L036UWD210-0 Rev: S5BS
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi3 Channel: 00 Id: 06 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: J.03
  Type:   Direct-Access                    ANSI SCSI revision: 02

lspci -vvv:

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 03)
    Flags: bus master, medium devsel, latency 64
    Memory at e4000000 (32-bit, prefetchable) [size=64M]
    Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
(rev 03) (prog-if 00 [Normal decode])
    Flags: bus master, 66Mhz, medium devsel, latency 64
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
    I/O behind bridge: 0000d000-0000dfff
    Memory behind bridge: de000000-e1dfffff
    Prefetchable memory behind bridge: e1f00000-e3ffffff

00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
    Flags: bus master, medium devsel, latency 0

00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
    Flags: bus master, medium devsel, latency 32
    I/O ports at b800 [size=16]

00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
    Flags: bus master, medium devsel, latency 32, IRQ 5
    I/O ports at b400 [size=32]

00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
    Flags: medium devsel, IRQ 9

00:09.0 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / 
AIC-7895 (rev 03)
    Subsystem: Adaptec AHA-3940AU/AUW/AUWD/UWD
    Flags: bus master, medium devsel, latency 32, IRQ 5
    I/O ports at b000 [disabled] [size=256]
    Memory at dd800000 (32-bit, non-prefetchable) [size=4K]
    Expansion ROM at <unassigned> [disabled] [size=64K]

00:09.1 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / 
AIC-7895 (rev 03)
    Subsystem: Adaptec AHA-3940AU/AUW/AUWD/UWD
    Flags: bus master, medium devsel, latency 32, IRQ 11
    I/O ports at a800 [disabled] [size=256]
    Memory at dd000000 (32-bit, non-prefetchable) [size=4K]

00:0a.0 Ethernet controller: National Semiconductor Corporation DP83815 
(MacPhyter) Ethernet Controller
    Subsystem: Netgear: Unknown device f311
    Flags: bus master, medium devsel, latency 32, IRQ 10
    I/O ports at a400 [size=256]
    Memory at dc800000 (32-bit, non-prefetchable) [size=4K]
    Expansion ROM at <unassigned> [disabled] [size=64K]
    Capabilities: [40] Power Management version 2

00:0c.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
    Subsystem: Adaptec 29160N Ultra160 SCSI Controller
    Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
    BIST result: 00
    I/O ports at a000 [disabled] [size=256]
    Memory at dc000000 (64-bit, non-prefetchable) [size=4K]
    Expansion ROM at <unassigned> [disabled] [size=128K]
    Capabilities: [dc] Power Management version 2

00:0d.0 Ethernet controller: 3Com Corporation 3c590 10BaseT [Vortex]
    Flags: bus master, medium devsel, latency 248, IRQ 5
    I/O ports at 9800 [size=32]
    Expansion ROM at <unassigned> [disabled] [size=64K]

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 
01) (prog-if 00 [VGA])
    Subsystem: 3Dfx Interactive, Inc. Voodoo3 AGP
    Flags: 66Mhz, fast devsel, IRQ 11
    Memory at de000000 (32-bit, non-prefetchable) [size=32M]
    Memory at e2000000 (32-bit, prefetchable) [size=32M]
    I/O ports at d800 [size=256]
    Expansion ROM at e1ff0000 [disabled] [size=64K]
    Capabilities: [54] AGP version 1.0
    Capabilities: [60] Power Management version 1


-- tony
"Surrender to the Void." -- John Lennon



--------------030204050003080209090506
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

ksymoops 2.4.4 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal
May 27 04:07:35 manic kernel: Unable to handle kernel paging request at virtual address 032f039b
May 27 04:07:35 manic kernel: c0122db5
May 27 04:07:35 manic kernel: *pde = 00000000
May 27 04:07:35 manic kernel: Oops: 0002
May 27 04:07:35 manic kernel: CPU:    0
May 27 04:07:35 manic kernel: EIP:    0010:[<c0122db5>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
May 27 04:07:35 manic kernel: EFLAGS: 00010287
May 27 04:07:35 manic kernel: eax: 032f0397   ebx: c225fb00   ecx: e225fa40   edx: 0330039a
May 27 04:07:35 manic kernel: esi: e225faf0   edi: 00000000   ebp: e225fb00   esp: e7fe5f84
May 27 04:07:35 manic kernel: ds: 0018   es: 0018   ss: 0018
May 27 04:07:35 manic kernel: Process kupdated (pid: 6, stackpage=e7fe5000)
May 27 04:07:35 manic kernel: Stack: e225faf0 e225fa40 e225fa40 e75dcc60 c013fe06 e225faf0 e75dcc00 e7fe5fa8 
May 27 04:07:35 manic kernel:        e7fe5fa8 00000000 00000000 0d3bdbe1 e7fe4000 c01115e0 ffffffff e7fe4560 
May 27 04:07:35 manic kernel:        ffffffff fff9ffff e7fe4000 c0132355 c0132606 0008e000 e7fe4000 00010f00 
May 27 04:07:35 manic kernel: Call Trace: [<c013fe06>] [<c01115e0>] [<c0132355>] [<c0132606>] [<c0105000>] 
May 27 04:07:35 manic kernel:    [<c0105516>] [<c0132500>] 
May 27 04:07:35 manic kernel: Code: 89 50 04 89 02 8b 06 89 58 04 89 03 89 73 04 89 1e 8b 43 18 

>>EIP; c0122db5 <filemap_fdatawait+25/70>   <=====
Trace; c013fe06 <sync_unlocked_inodes+d6/170>
Trace; c01115e0 <process_timeout+0/50>
Trace; c0132355 <sync_old_buffers+5/40>
Trace; c0132606 <kupdate+106/110>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0132500 <kupdate+0/110>
Code;  c0122db5 <filemap_fdatawait+25/70>
00000000 <_EIP>:
Code;  c0122db5 <filemap_fdatawait+25/70>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0122db8 <filemap_fdatawait+28/70>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0122dba <filemap_fdatawait+2a/70>
   5:   8b 06                     mov    (%esi),%eax
Code;  c0122dbc <filemap_fdatawait+2c/70>
   7:   89 58 04                  mov    %ebx,0x4(%eax)
Code;  c0122dbf <filemap_fdatawait+2f/70>
   a:   89 03                     mov    %eax,(%ebx)
Code;  c0122dc1 <filemap_fdatawait+31/70>
   c:   89 73 04                  mov    %esi,0x4(%ebx)
Code;  c0122dc4 <filemap_fdatawait+34/70>
   f:   89 1e                     mov    %ebx,(%esi)
Code;  c0122dc6 <filemap_fdatawait+36/70>
  11:   8b 43 18                  mov    0x18(%ebx),%eax


1 warning issued.  Results may not be reliable.

--------------030204050003080209090506--

