Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbTDOJ6h (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 05:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264425AbTDOJ6h (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 05:58:37 -0400
Received: from rainbow.transtec.de ([153.94.51.2]:48137 "EHLO
	rainbow.transtec.de") by vger.kernel.org with ESMTP id S264422AbTDOJ6b (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 05:58:31 -0400
From: Peter <pk@q-leap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16027.55946.797266.771034@q-leap.com>
Date: Tue, 15 Apr 2003 12:10:18 +0200
To: linux-kernel@vger.kernel.org
Subject: oops with e1000, ifenslave (bonding)
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: pk@q-leap.com
X-Face: "HSWKA_'Lr\(@D}NQgU@jZukje>!f;VO]4Tj%~+[PY$M"=CmMyN.x6&X`p_X|q9.||#uM0mH%/3kBIxN-@(lB?3\_)J+ms63HsTY0{WmL3_K+
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

the following oops occurs repeatadly:

--------------------------------------8<--------------------------------------

ksymoops 2.4.5 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
f89500d9
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<f89500d9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: f5af0960   ecx: 0d143dd3   edx: 18217949
esi: 00000000   edi: 00000000   ebp: d74bfe60   esp: d74bfe48
ds: 0018   es: 0018   ss: 0018
Process ifenslave (pid: 7281, stackpage=d74bf000)
Stack: f5af0960 f5af0800 000010c3 f5af0960 f5af0960 00000000 d74bfea0 f894f263
       f5af0960 f5af0960 d74bfea0 f894f25a f5af0960 c0367b6c 00000001 00000082
       f5af0960 f5af0800 00000296 f896000c f5af0800 c0367b60 d74bfed0 f894fab2
Call Trace:    [<f894f263>] [<f894f25a>] [<f896000c>] [<f894fab2>] [<c0270e67>]
  [<c0270ea6>] [<c0272185>] [<c02a18d4>] [<c02a3e07>] [<c026a67f>] [<c0147007>]
  [<c01089f7>]
Code: 8b 14 30 85 d2 74 2f 8b 42 70 83 f8 01 74 0b f0 ff 4a 70 0f


>>EIP; f89500d9 <[e1000]e1000_clean_tx_ring+25/11c>   <=====

>>ebx; f5af0960 <_end+356f69bc/3853f0bc>
>>ecx; 0d143dd3 Before first symbol
>>edx; 18217949 Before first symbol
>>ebp; d74bfe60 <_end+170c5ebc/3853f0bc>
>>esp; d74bfe48 <_end+170c5ea4/3853f0bc>

Trace; f894f263 <[e1000]e1000_down+7f/94>
Trace; f894f25a <[e1000]e1000_down+76/94>
Trace; f896000c <[e1000]e1000_notifier_netdev+0/14>
Trace; f894fab2 <[e1000]e1000_close+16/34>
Trace; c0270e67 <dev_close+23/98>
Trace; c0270ea6 <dev_close+62/98>
Trace; c0272185 <dev_change_flags+51/104>
Trace; c02a18d4 <devinet_ioctl+328/6d8>
Trace; c02a3e07 <inet_ioctl+17b/1cc>
Trace; c026a67f <sock_ioctl+4b/70>
Trace; c0147007 <sys_ioctl+1bb/1f6>
Trace; c01089f7 <system_call+33/38>

Code;  f89500d9 <[e1000]e1000_clean_tx_ring+25/11c>
00000000 <_EIP>:
Code;  f89500d9 <[e1000]e1000_clean_tx_ring+25/11c>   <=====
   0:   8b 14 30                  mov    (%eax,%esi,1),%edx   <=====
Code;  f89500dc <[e1000]e1000_clean_tx_ring+28/11c>
   3:   85 d2                     test   %edx,%edx
Code;  f89500de <[e1000]e1000_clean_tx_ring+2a/11c>
   5:   74 2f                     je     36 <_EIP+0x36> f895010f <[e1000]e1000_clean_tx_ring+5b/11c>
Code;  f89500e0 <[e1000]e1000_clean_tx_ring+2c/11c>
   7:   8b 42 70                  mov    0x70(%edx),%eax
Code;  f89500e3 <[e1000]e1000_clean_tx_ring+2f/11c>
   a:   83 f8 01                  cmp    $0x1,%eax
Code;  f89500e6 <[e1000]e1000_clean_tx_ring+32/11c>
   d:   74 0b                     je     1a <_EIP+0x1a> f89500f3 <[e1000]e1000_clean_tx_ring+3f/11c>
Code;  f89500e8 <[e1000]e1000_clean_tx_ring+34/11c>
   f:   f0 ff 4a 70               lock decl 0x70(%edx)
Code;  f89500ec <[e1000]e1000_clean_tx_ring+38/11c>
  13:   0f 00 00                  sldtl  (%eax)


1 warning issued.  Results may not be reliable.


--------------------------------------8<--------------------------------------


To reproduce:

in /etc/modules.conf:

--------------------------------------8<--------------------------------------

alias bond0 bonding
options bond0 miimon=100 mode=0

--------------------------------------8<--------------------------------------

# ifconfig eth1 up
# ifconfig eth2 up
# ifconfig bond0 192.168.254.1 netmask 255.255.255.0 broadcast 192.168.254.255
# ifenslave bond0 eth1 eth2
# ifenslave -d bond0 eth1 eth2
<Ooops>

it also occurs when using "ifenslave -D ..."

Although this is the module downloaded from Intel's webpage, it also
happens with the e1000 driver shipped with the kernel.

When loading the module:

Intel(R) PRO/1000 Network Driver - version 5.0.43
Copyright (c) 1999-2003 Intel Corporation.
eth1: Intel(R) PRO/1000 Network Connection
eth2: Intel(R) PRO/1000 Network Connection


--------------------------------------8<--------------------------------------

# ifenslave -V
ifenslave.c:v0.07 9/9/97  Donald Becker (becker@cesdis.gsfc.nasa.gov)
Contains patches from Willy Tarreau and Guus Sliepen.

--------------------------------------8<--------------------------------------

# more /proc/net/PRO_LAN_Adapters/eth1.info
Description                      Intel(R) PRO/1000 Network Connection
Part_Number                      a92111-004
Driver_Name                      e1000
Driver_Version                   5.0.43
PCI_Vendor                       0x8086
PCI_Device_ID                    0x1010
PCI_Subsystem_Vendor             0x8086
PCI_Subsystem_ID                 0x1011
PCI_Revision_ID                  0x01
PCI_Bus                          0
PCI_Slot                         8
PCI_Bus_Type                     PCI
PCI_Bus_Speed                    66MHz
PCI_Bus_Width                    64-bit
IRQ                              10
System_Device_Name               eth1
Current_HWaddr                   00:07:E9:0F:78:56
Permanent_HWaddr                 00:07:E9:0F:78:56

Link                             N/A
Speed                            N/A
Duplex                           N/A
State                            down

Rx_Packets                       147913989
Tx_Packets                       141364317
Rx_Bytes                         265647938
Tx_Bytes                         2786751200
Rx_Errors                        0
Tx_Errors                        0
Rx_Dropped                       0
Tx_Dropped                       0
Multicast                        0
Collisions                       0
Rx_Length_Errors                 0
Rx_Over_Errors                   0
Rx_CRC_Errors                    0
Rx_Frame_Errors                  0
Rx_FIFO_Errors                   0
Rx_Missed_Errors                 0
Tx_Aborted_Errors                0
Tx_Carrier_Errors                0
Tx_FIFO_Errors                   0
Tx_Heartbeat_Errors              0
Tx_Window_Errors                 0
Tx_Abort_Late_Coll               0
Tx_Deferred_Ok                   0
Tx_Single_Coll_Ok                0
Tx_Multi_Coll_Ok                 0
Rx_Long_Length_Errors            0
Rx_Short_Length_Errors           0
Rx_Align_Errors                  0
Tx_TCP_Seg_Good                  0
Tx_TCP_Seg_Failed                0
Rx_Flow_Control_XON              0
Rx_Flow_Control_XOFF             0
Tx_Flow_Control_XON              0
Tx_Flow_Control_XOFF             0
Rx_CSum_Offload_Good             147913706
Rx_CSum_Offload_Errors           0

PHY_Media_Type                   Copper
PHY_Cable_Length                 Unknown
PHY_Extended_10Base_T_Distance   Unknown
PHY_Cable_Polarity               Unknown
PHY_Disable_Polarity_Correction  Unknown
PHY_Idle_Errors                  1020
PHY_Receive_Errors               5238
PHY_MDI_X_Enabled                Unknown
PHY_Local_Receiver_Status        Unknown
PHY_Remote_Receiver_Status       Unknown

# more /proc/net/PRO_LAN_Adapters/eth2.info
Description                      Intel(R) PRO/1000 Network Connection
Part_Number                      a92111-004
Driver_Name                      e1000
Driver_Version                   5.0.43
PCI_Vendor                       0x8086
PCI_Device_ID                    0x1010
PCI_Subsystem_Vendor             0x8086
PCI_Subsystem_ID                 0x1011
PCI_Revision_ID                  0x01
PCI_Bus                          0
PCI_Slot                         8
PCI_Bus_Type                     PCI
PCI_Bus_Speed                    66MHz
PCI_Bus_Width                    64-bit
IRQ                              11
System_Device_Name               eth2
Current_HWaddr                   00:07:E9:0F:78:57
Permanent_HWaddr                 00:07:E9:0F:78:57

Link                             N/A
Speed                            N/A
Duplex                           N/A
State                            down

Rx_Packets                       11
Tx_Packets                       167
Rx_Bytes                         856
Tx_Bytes                         15800
Rx_Errors                        0
Tx_Errors                        0
Rx_Dropped                       0
Tx_Dropped                       0
Multicast                        0
Collisions                       0
Rx_Length_Errors                 0
Rx_Over_Errors                   0
Rx_CRC_Errors                    0
Rx_Frame_Errors                  0
Rx_FIFO_Errors                   0
Rx_Missed_Errors                 0
Tx_Aborted_Errors                0
Tx_Carrier_Errors                0
Tx_FIFO_Errors                   0
Tx_Heartbeat_Errors              0
Tx_Window_Errors                 0
Tx_Abort_Late_Coll               0
Tx_Deferred_Ok                   0
Tx_Single_Coll_Ok                0
Tx_Multi_Coll_Ok                 0
Rx_Long_Length_Errors            0
Rx_Short_Length_Errors           0
Rx_Align_Errors                  0
Tx_TCP_Seg_Good                  0
Tx_TCP_Seg_Failed                0
Rx_Flow_Control_XON              0
Rx_Flow_Control_XOFF             0
Tx_Flow_Control_XON              0
Tx_Flow_Control_XOFF             0
Rx_CSum_Offload_Good             0
Rx_CSum_Offload_Errors           0

PHY_Media_Type                   Copper
PHY_Cable_Length                 Unknown
PHY_Extended_10Base_T_Distance   Unknown
PHY_Cable_Polarity               Unknown
PHY_Disable_Polarity_Correction  Unknown
PHY_Idle_Errors                  765
PHY_Receive_Errors               35114
PHY_MDI_X_Enabled                Unknown
PHY_Local_Receiver_Status        Unknown
PHY_Remote_Receiver_Status       Unknown


#more /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) MP 1900+
stepping        : 2
cpu MHz         : 1600.068
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3191.60

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1600.068
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3198.15


Greetings,

	Peter

