Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293205AbSCUCof>; Wed, 20 Mar 2002 21:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293206AbSCUCo0>; Wed, 20 Mar 2002 21:44:26 -0500
Received: from YahooBB227014117.bbtec.net ([43.227.14.117]:9476 "HELO
	hydrogen.ysuzuki.net") by vger.kernel.org with SMTP
	id <S293205AbSCUCoM>; Wed, 20 Mar 2002 21:44:12 -0500
Date: Thu, 21 Mar 2002 11:44:03 +0900
From: SUZUKI Yasuhiro <ysuzuki@bb.mbn.or.jp>
To: linux-kernel@vger.kernel.org
Cc: ysuzuki@bb.mbn.or.jp
Subject: PROBLEM: TCP CWR and ECE flags
Message-ID: <20020321024403.GB1190%ysuzuki@bb.mbn.or.jp>
Reply-To: yasu@ysuzuki.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline
User-Agent: Mutt/1.3.27i-ja.2
Erros-to: ysuzuki@bb.mbn.or.jp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1] Handling TCP flags CWR and ECE

[2]
I can not connect to a ftp server
with /usr/bin/ftp from Linux 2.4.18
kernel though I can from Linux
2.2.20 kernel.  And I can connect to
other ftp servers even if from 2.4.18
kernel.

A web page
  http://www.icir.org/floyd/papers/ECN.Oct2000.txt
says that 
  * If Host A does not get any reply to its initial SYN (which had CWR
    and ECE set) within the normal SYN retransmission timeout interval,
    then Host A resends the SYN and any subsequent SYN retransmissions
    with CWR and ECE cleared.
  where Host A is a client and Host B is a server.
But my firewall log says:
  Mar 20 21:41:01 litium kernel: IN=eth0 OUT=eth1 SRC=192.168.1.4
    DST=211.125.48.158 LEN=60 TOS=0x00 PREC=0x00 TTL=63 ID=383 DF
    PROTO=TCP SPT=1052 DPT=21 WINDOW=5840 RES=0x00 CWR ECE SYN URGP=0 
  Mar 20 21:41:04 litium kernel: IN=eth0 OUT=eth1 SRC=192.168.1.4
    DST=211.125.48.158 LEN=60 TOS=0x00 PREC=0x00 TTL=63 ID=384 DF
    PROTO=TCP SPT=1052 DPT=21 WINDOW=5840 RES=0x00 CWR ECE SYN URGP=0 
  Mar 20 21:41:10 litium kernel: IN=eth0 OUT=eth1 SRC=192.168.1.4
    DST=211.125.48.158 LEN=60 TOS=0x00 PREC=0x00 TTL=63 ID=385 DF
    PROTO=TCP SPT=1052 DPT=21 WINDOW=5840 RES=0x00 CWR ECE SYN URGP=0 
  Mar 20 21:41:22 litium kernel: IN=eth0 OUT=eth1 SRC=192.168.1.4
    DST=211.125.48.158 LEN=60 TOS=0x00 PREC=0x00 TTL=63 ID=386 DF
    PROTO=TCP SPT=1052 DPT=21 WINDOW=5840 RES=0x00 CWR ECE SYN URGP=0 
Because there is no response from the ftp server, the CWR and ECE flags of
TCP SYN packets other than the first one must be cleared. I think
the log shows a bug in kernel 2.4.18.


[3] Networking, TCP, CWR and ECE

[4] Linux version 2.4.18 (root@hydrogen) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Mar 16 2002 00:01:37 JST

[5]

[6]

[7]
[7.1]
Ftp command I use is:
  -rwxr-xr-x    1 root     root        64860 May  2  2000 /usr/bin/ftp
This comes from Vine linux 2.15, a Linux distribution
popular in Japan. I tried to get a copyright message
from the command with some options as '-h', '--help',
'--version' or '-hv' and could not get.

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux hydrogen 2.4.18 #1 2002年 3月16日(土) 00時01分37秒 JST i686 unknown
 
Gnu C                  egcs-2.91.66
Gnu make               3.79
binutils               2.9.5.0.34
util-linux             2.10f
mount                  2.10f
modutils               2.3.21
e2fsprogs              1.27
pcmcia-cs              3.1.30
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         soundcore sd_mod apa1480_cb scsi_mod cb_enabler pcnet_cs 8390 ds i82365 pcmcia_core nls_cp437 vfat fat

[7.2] 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Celeron (Coppermine)
stepping	: 3
cpu MHz		: 497.846
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 992.87

[7.3]
soundcore               3472   0 (autoclean)
sd_mod                 10176   2 (autoclean)
apa1480_cb            108021   2
scsi_mod               50496   2 [sd_mod apa1480_cb]
cb_enabler              2384   2 [apa1480_cb]
pcnet_cs               12800   1
8390                    5888   0 [pcnet_cs]
ds                      6528   2 [cb_enabler pcnet_cs]
i82365                 21648   2
pcmcia_core            41248   0 [cb_enabler pcnet_cs ds i82365]
nls_cp437               4352   2 (autoclean)
vfat                    9808   1 (autoclean)
fat                    30912   0 (autoclean) [vfat]

[7.4]
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0200-02ff : aic7xxx
0300-031f : pcnet_cs
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0800-083f : Intel Corp. 82371AB PIIX4 ACPI
0840-085f : Intel Corp. 82371AB PIIX4 ACPI
0860-086f : Intel Corp. 82371AB PIIX4 IDE
  0860-0867 : ide0
  0868-086f : ide1
0cf8-0cff : PCI conf1
d800-d8ff : ESS Technology ES1983S Maestro-3i PCI Audio Accelerator
dce0-dcff : Intel Corp. 82371AB PIIX4 USB
e000-efff : PCI Bus #01
  ec00-ecff : ATI Technologies Inc Rage Mobility P/M AGP 2x


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07febfff : System RAM
  00100000-0021668c : Kernel code
  0021668d-0026e2ff : Kernel data
07fec000-07feffff : reserved
10000000-10000fff : Texas Instruments PCI1225
  10000000-10000fff : i82365
10001000-10001fff : Texas Instruments PCI1225 (#2)
  10001000-10001fff : i82365
100a0000-100fffff : reserved
a0000000-a0000fff : card services
a0020000-a0030fff : cb_enabler
f4000000-f7ffffff : Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge
faffe000-faffffff : ESS Technology ES1983S Maestro-3i PCI Audio Accelerator
fc000000-feffffff : PCI Bus #01
  fcfff000-fcffffff : ATI Technologies Inc Rage Mobility P/M AGP 2x
  fd000000-fdffffff : ATI Technologies Inc Rage Mobility P/M AGP 2x
ffe00000-ffffffff : reserved

[7.5]

[root@hydrogen ysuzuki]# /sbin/lspci -vvv
pcilib: Cannot open /proc/bus/pci/06/00.0
lspci: Unable to read 64 bytes of configuration space.

[7.6]
Attached devices: 
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: MELCO    Model: DSU-GTH          Rev: 1.0H
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: MELCO    Model: DSC-G            Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7]
I have a small LAN 192.168.1.0/24. There is
a firewall between the LAN and the Internet.
The firewall is a linux box with kernel 2.4.18
and connected via ADSL to the Internet.

### The firewall rule (only about TCP)###
Chain INPUT (policy DROP)
target     prot opt source               destination         
LOG        tcp  --  anywhere            !255.255.255.255    LOG level warning 
ACCEPT     tcp  --  192.168.1.0/24       anywhere           tcp spt:smtp 
ACCEPT     tcp  --  192.168.1.0/24       anywhere           tcp dpt:ssh 
ACCEPT     udp  --  loopback/8           loopback/8         
ACCEPT     tcp  --  loopback/8           loopback/8         

Chain FORWARD (policy DROP)
target     prot opt source               destination         
LOG        tcp  --  anywhere             anywhere           LOG level warning 
ACCEPT     tcp  --  192.168.1.0/24      !255.255.255.255    tcp spts:1024:65535 
ACCEPT     tcp  -- !192.168.1.0/24       192.168.1.0/24     tcp dpts:1024:65535 state ESTABLISHED 

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         
### The firewall rule ###

------------------------------------------------------------
SUZUKI Yasuhiro
      living in Edogawa-ku, Tokyo, Japan
  ysuzuki@bb.mbn.or.jp
  yasu@ysuzuki.net
  http://plaza8.mbn.or.jp/~yswww/myself/ (only in Japanese)

