Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271315AbTGRJNR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271323AbTGRJNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:13:17 -0400
Received: from media.lutsk.ua ([212.1.102.210]:21776 "EHLO
	service.media.lutsk.ua") by vger.kernel.org with ESMTP
	id S271315AbTGRJNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:13:10 -0400
Date: Fri, 18 Jul 2003 12:27:36 +0300
From: "Andriy T. Yanko" <wireless@wireless.org.ua>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: I got  OOPS messsage and crash ip_queue module
Message-Id: <20030718122736.29b37b8a.wireless@wireless.org.ua>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; k6-2-slackware-linux-gnu; OS: Linux 2.4.21brnf (i586))
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-U
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BUG REPORT:

[1.] I got  OOPS messsage and crash ip_queue module

[2.] I using  own program (gladiator with libipq ) that use ip_queue kernel module.
After some hours of work   my program crash because crash ip_queue and I see OOPS kernel message.
After that i can not rmmod ip_queue and insmod ip_queue. Kernel said module ip_queue is deleted.

[3.] networking/kernel

[4.] Kernel version 
root@spider:/usr/src/linux# cat /proc/version
Linux version 2.4.21-brnf (root@spider) (gcc version 3.2.2) #1 Tue Jul 8 20:59:18 EEST 2003
See below about patch.

[5.]  root@spider:/home/wireless# ksymoops <oops.txt
ksymoops 2.4.8 on i586 2.4.21-brnf.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-brnf/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jul 17 15:15:42 spider kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000008
Jul 17 15:15:42 spider kernel: c01faeef
Jul 17 15:15:42 spider kernel: *pde = 00000000
Jul 17 15:15:42 spider kernel: Oops: 0000
Jul 17 15:15:42 spider kernel: CPU:    0
Jul 17 15:15:42 spider kernel: EIP:    0010:[<c01faeef>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jul 17 15:15:42 spider kernel: EFLAGS: 00010246
Jul 17 15:15:42 spider kernel: eax: 00000000   ebx: 00000001   ecx: c1a3e6a0   edx: c1a88400
Jul 17 15:15:42 spider kernel: esi: c0541cc0   edi: 00000002   ebp: 00000002   esp: c1a83d0c
Jul 17 15:15:42 spider kernel: ds: 0018   es: 0018   ss: 0018
Jul 17 15:15:42 spider kernel: Process gladiatord (pid: 194, stackpage=c1a83000)
Jul 17 15:15:42 spider kernel: Stack: c02fc790 c05418e0 c05418e0 00000001 00000012 c2977077 c1a3e6a0 c0541cc0
Jul 17 15:15:42 spider kernel:        00000001 c06ece70 c2977866 c05418e0 00000001 c06ece70 c1dd26e0 00000001
Jul 17 15:15:42 spider kernel:        c297794f c06ece70 00000000 c06ece60 c2977f39 c06ece70 00000012 0000000c
Jul 17 15:15:42 spider kernel: Call Trace:    [<c2977077>] [<c2977866>] [<c297794f>] [<c2977f39>] [<c2977a2e>]
Jul 17 15:15:42 spider kernel:   [<c0200ae8>] [<c0200467>] [<c02008d0>] [<c01edf2c>] [<c01ef0b9>] [<c01edb09>]
Jul 17 15:15:43 spider kernel:   [<c01fad65>] [<c0205bed>] [<c0205de0>] [<c01f4f4a>] [<c01ef49c>] [<c01070b3>]
Jul 17 15:15:43 spider kernel: Code: 8b 50 08 85 d2 74 0d ff 8a e8 00 00 00 0f 94 c0 84 c0 75 2c


>>EIP; c01faeef <nf_reinject+df/1e0>   <=====

>>ecx; c1a3e6a0 <_end+173e55c/2670f1c>
>>edx; c1a88400 <_end+17882bc/2670f1c>
>>esi; c0541cc0 <_end+241b7c/2670f1c>
>>esp; c1a83d0c <_end+1783bc8/2670f1c>

Trace; c2977077 <[ip_queue]ipq_issue_verdict+17/30>
Trace; c2977866 <[ip_queue]ipq_set_verdict+46/60>
Trace; c297794f <[ip_queue]ipq_receive_peer+3f/60>
Trace; c2977f39 <[ip_queue]ipq_rcv_skb+e9/11c>
Trace; c2977a2e <[ip_queue]ipq_rcv_sk+5e/b0>
Trace; c0200ae8 <netlink_data_ready+48/60>
Trace; c0200467 <netlink_unicast+247/2a0>
Trace; c02008d0 <netlink_sendmsg+1c0/250>
Trace; c01edf2c <sock_sendmsg+5c/90>
Trace; c01ef0b9 <sys_sendmsg+159/1b0>
Trace; c01edb09 <move_addr_to_user+49/60>
Trace; c01fad65 <nf_hook_slow+a5/150>
Trace; c0205bed <ip_rcv+17d/210>
Trace; c0205de0 <ip_rcv_finish+0/210>
Trace; c01f4f4a <netif_receive_skb+15a/210>
Trace; c01ef49c <sys_socketcall+18c/1b0>
Trace; c01070b3 <system_call+33/40>

Code;  c01faeef <nf_reinject+df/1e0>
00000000 <_EIP>:
Code;  c01faeef <nf_reinject+df/1e0>   <=====
   0:   8b 50 08                  mov    0x8(%eax),%edx   <=====
Code;  c01faef2 <nf_reinject+e2/1e0>
   3:   85 d2                     test   %edx,%edx
Code;  c01faef4 <nf_reinject+e4/1e0>
   5:   74 0d                     je     14 <_EIP+0x14>
Code;  c01faef6 <nf_reinject+e6/1e0>
   7:   ff 8a e8 00 00 00         decl   0xe8(%edx)
Code;  c01faefc <nf_reinject+ec/1e0>
   d:   0f 94 c0                  sete   %al
Code;  c01faeff <nf_reinject+ef/1e0>
  10:   84 c0                     test   %al,%al
Code;  c01faf01 <nf_reinject+f1/1e0>
  12:   75 2c                     jne    40 <_EIP+0x40>


1 warning issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the  problem (if possible)
no

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
root@spider:/usr/src/linux# sh scripts/ver_linux
Linux spider 2.4.21-brnf #1 Tue Jul 8 20:59:18 EEST 2003 i586 unknown
Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.22
e2fsprogs              1.32
reiserfsprogs          3.6.4
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.2
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded         ipip bridge tun iptable_mangle iptable_nat ip_conntrack iptable_filter ip_queue fealnx mii

[7.2.] root@spider:/usr/src/linux# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 166.193
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 331.77

[7.3.] Module information 
ipip                    6724   1
bridge                 22940   1
tun                     4160   3
iptable_mangle          2072   0 (autoclean) (unused)
iptable_nat            16152   1 (autoclean)
ip_conntrack           18344   1 (autoclean) [iptable_nat]
iptable_filter          1612   1 (autoclean)
ip_queue                5420   0
fealnx                 10864   2
mii                     2304   0 [fealnx]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
f4f0-f4ff : Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
  f4f0-f4f7 : ide0
  f4f8-f4ff : ide1
f800-f8ff : MYSON Technology Inc SURECOM EP-320X-S 100/10M Ethernet PCI Adapter (#2)
  f800-f8ff : òÑ
fc00-fcff : MYSON Technology Inc SURECOM EP-320X-S 100/10M Ethernet PCI Adapter
  fc00-fcff : òÑ

cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-01ffffff : System RAM
  00100000-00246ffa : Kernel code
  00246ffb-002bf93f : Kernel data
f8000000-fbffffff : S3 Inc. 86c775/86c785 [Trio 64V2/DX or /GX]
fedff800-fedffbff : MYSON Technology Inc SURECOM EP-320X-S 100/10M Ethernet PCI Adapter (#2)
  fedff800-fedffbff : òÑ
fedffc00-fedfffff : MYSON Technology Inc SURECOM EP-320X-S 100/10M Ethernet PCI Adapter
  fedffc00-fedfffff : òÑ
fffe0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
lspci -vvv
00:00.0 Host bridge: Intel Corp. 430HX - 82439HX TXC [Triton II] (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:06.0 Ethernet controller: MYSON Technology Inc SURECOM EP-320X-S 100/10M Ethernet PCI Adapter
        Subsystem: Surecom Technology: Unknown device 1320
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at fc00 [size=256]
        Region 1: Memory at fedffc00 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [88] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0-,D1+,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Ethernet controller: MYSON Technology Inc SURECOM EP-320X-S 100/10M Ethernet PCI Adapter
        Subsystem: Surecom Technology: Unknown device 1320
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at f800 [size=256]
        Region 1: Memory at fedff800 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [88] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0-,D1+,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 VGA compatible controller: S3 Inc. 86c775/86c785 [Trio 64V2/DX or /GX] (rev 14) (prog-if 00 [VGA])
        Subsystem: S3 Inc. 86C775 Trio64V2/DX, 86C785 Trio64V2/GX
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0f.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:0f.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f4f0 [size=16]


[7.6.] SCSI information (from /proc/scsi/scsi)
cat /proc/scsi/scsi
cat: /proc/scsi/scsi: No such file or directory

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:
I patched  2.4.21 kernel  with ebtables-brnf_vs_2.4.21.diff  (http://ebtables.sourceforge.net/)
I have other server with same patched kernel but there is all right,

I use tunnel interface and send all forward traffic to ip_queue module .
Maybe ip_queue crash when traffic  is not from physical device?

modprobe ipip
ip tunnel add netcity mode ipip local 192.168.7.100 remote 192.168.2.100 ttl 64
ip link set netcity up
ip addr add 192.168.9.2/30 dev netcity
ip route add 192.168.2.0/24 dev eth0 via 192.168.7.101
ip route add 193.109.80.0/24 dev eth0 via 192.168.7.101
ip route add default dev netcity via 192.168.9.1

iptables -A FORWARD  -i eth1 -o netcity -j QUEUE
ptables -A FORWARD  -i netcity -o eth1 -j QUEUE

-- 
Andriy T. Yanko
System Administrator
MPP MEDIA
+38 0332 770752
+38 03322 47856
ATY1-RIPE
ATY1-UANIC

wireless@wireless.org.ua
*   Avoid The Gates of Hell use Linux
