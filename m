Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263696AbTHWJyS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 05:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTHWJyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 05:54:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:19621 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263696AbTHWJxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 05:53:42 -0400
From: "spi" <spi@gmxpro.de>
To: linux-kernel@vger.kernel.org
Date: Sat, 23 Aug 2003 11:53:39 +0200
MIME-Version: 1.0
Subject: PROBLEM: Powerquest Drive Image let the kernel panic
Message-ID: <3F4755C3.27525.3B23996@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

several times I got an OOPS. Here's a description of what has 
happened. Any  help would be appreciated. Please CC me on all further 
mail traffic. 

############################################################### 
1) one line summary: 
Powerquest Drive Image (PQDI 2002) images (56 files, each ~700MB of 
size)  are stored on a Linux server and published via Samba. When 
verifying them  with PQDI from a Win XP client, the Linux kernel 
panic with an OOPS. Linux  has to be resetted hard. 
############################################################### 
2) full description: 
I'm using Samba to distribute some shares to Windows clients. One of 
the  shares is an Image-directory where I'm storing PQDI Images of 
Windows  clients. One of the created images is about 40GB of size and 
is split up to 56  files each of same size. When verifying this image 
from a Win XP client, PQDI  stops with an error (error 1811, "Could 
not read from image file") and the Linux  kernel panic. Verifying 
this image from DOS (with MS network client) is done  without any 
error. Also verifying smaller images is done without any error.  
Another PQDI version (7.0) also reports an error and let the Linux 
Kernel  panic. 

By the way: PQDI (Dos) only works with a samba-share when "wide 
links" is  set to yes for this share. In the other case PQDI can't 
create an image file. 

The share is lying in a directory on a Reiser filesystem: 

share Images 
ReiserFS 
LVM (on /dev/md0 only, 120GB) 
RAID1 /dev/md0 (120GB) 
/dev/hda1 + /dev/hde1 (one primary partition of 120GB on each drive) 
/dev/hda + /dev/hde (each 120GB) 
IDE UDMA133-controller 

As IDE-controller I first used a Promise FastTrak TX2000 (which 
supports  "hardware"-RAID). I tried the binary Promise-driver 
(1.03.0.1) and the source  code-driver (1.02.0.25), both without 
success. All time the OOPS occurred.  Then I replaced the controller 
and both Samsung SP1203N-hard drives (each  120GB) against a Promise 
UltraTrak 133 TX2 and two Maxtor drives  (6Y120P0, each 120GB) and 
installed a Linux native software-RAID without  any Promise-driver. 
But again the OOPS occurred. Of course I updated the  Promise-
firmware to the latest level. 

To eliminate the RAID and LVM-drivers as the source of problem I 
installed  just a Reiser FS on one 120GB-primary partition on one of 
both Maxtor disks  (after removing the drive from the RAID). But 
again PQDI reported a problem  and the Linux kernel panicked. Trying 
ext3 instead of reiserfs didn't help. As I  do not have enough space 
on my scsi-disks I can't verify this big image from a  scsi-disk. 

Sometimes the Linux kernel panic occurs immediately some minutes 
after  starting the verify, sometimes it happens after reading half 
of all image files.  Samba doesn't report any error. I also tried a 
different PCI-slot for the Promise- adapter without any success. Next 
thing would be to try a different IDE- controller... 

By the way: when running PQDI under Dos and 
creating/restoring/verifying an  image on the Maxtor disks PQDI 
freezes sometimes after finishing. When  doing this on a scsi-disk 
PQDI never freezes. 
############################################################### 
3) keywords: 
Suse Linux 8.20, kernel 2.4.20, Promise Ultra 133 TX2 
############################################################### 
4) /proc/version: 
Linux version 2.4.20-4GB (root@Pentium.suse.de) (gcc version 3.3 
20030226  (prerelease) (SuSE Linux)) #1 Wed Aug 6 18:26:21 UTC 2003 
############################################################### 
5) OOPS-message: 
Oops: 0000 2.4.20-4GB #1 Wed Aug 6 18:26:21 UTC 2003 
CPU:    0 
EIP:    0010:[<c022b217>]    Not tainted 
Using defaults from ksymoops -t elf32-i386 -a i386 
EFLAGS: 00010206 
eax: c522e6e0   ebx: 00200000   ecx: c522e6e0   edx: 00200000 
esi: c3eee5c0   edi: c3eee61c   ebp: 00000784   esp: c031be08 
ds: 0018   es: 0018   ss: 0018 
Process swapper (pid: 0, stackpage=c031b000) 
Stack: c3eee5c0 c022b2ce c3eee5c0 c3eee5c0 c6ca3140 c022b2eb  
c3eee5c0 c6ca3264  
       c022b43b c3eee5c0 00000004 c025023e c3eee5c0 c6ca3198 00000000 
 00029857  
       00000005 c6ca3264 00000005 00000002 c02507ec c6ca3140 fb179769 
 c6ca3140  
Call Trace:    [<c022b2ce>] [<c022b2eb>] [<c022b43b>] [<c025023e>]  
[<c02507ec>] 
  [<c0252f85>] [<c010e2e6>] [<c010a19e>] [<c025a8cf>] [<c025aed5>]  
[<c024284b>] 
  [<c0242c20>] [<c022f8ff>] [<c022f9b6>] [<c022fb02>] [<c0122b1f>]  
[<c010a34c>] 
  [<c0106f90>] [<c010c5f8>] [<c0106f90>] [<c0106fb4>] [<c0107012>]  
[<c0105000>] 
Code: 8b 1b 8b 42 70 48 74 0a ff 4a 70 0f 94 c0 84 c0 74 07 52 e8  


>>EIP; c022b217 <skb_drop_fraglist+17/40>   <===== 

>>eax; c522e6e0 <[raid1]raid1_retry_tail+132b454/257cdd4> 
>>ecx; c522e6e0 <[raid1]raid1_retry_tail+132b454/257cdd4> 
>>esi; c3eee5c0 <[lvm-mod]lvm_mp_failqueue_lock+8e63c/a00dc> 
>>edi; c3eee61c <[lvm-mod]lvm_mp_failqueue_lock+8e698/a00dc> 
>>esp; c031be08 <init_task_union+1e08/2000> 

Trace; c022b2ce <skb_release_data+6e/80> 
Trace; c022b2eb <kfree_skbmem+b/70> 
Trace; c022b43b <__kfree_skb+eb/140> 
Trace; c025023e <tcp_clean_rtx_queue+10e/370> 
Trace; c02507ec <tcp_ack+bc/3a0> 
Trace; c0252f85 <tcp_rcv_established+495/830> 
Trace; c010e2e6 <timer_interrupt+126/180> 
Trace; c010a19e <handle_IRQ_event+4e/80> 
Trace; c025a8cf <tcp_v4_do_rcv+12f/170> 
Trace; c025aed5 <tcp_v4_rcv+5c5/660> 
Trace; c024284b <ip_local_deliver+19b/1c0> 
Trace; c0242c20 <ip_rcv+3b0/3c0> 
Trace; c022f8ff <netif_receive_skb+16f/1a0> 
Trace; c022f9b6 <process_backlog+86/130> 
Trace; c022fb02 <net_rx_action+a2/110> 
Trace; c0122b1f <do_softirq+5f/b0> 
Trace; c010a34c <do_IRQ+9c/b0> 
Trace; c0106f90 <default_idle+0/30> 
Trace; c010c5f8 <call_do_IRQ+5/d> 
Trace; c0106f90 <default_idle+0/30> 
Trace; c0106fb4 <default_idle+24/30> 
Trace; c0107012 <cpu_idle+32/60> 
Trace; c0105000 <_stext+0/0> 

Code;  c022b217 <skb_drop_fraglist+17/40> 
00000000 <_EIP>: 
Code;  c022b217 <skb_drop_fraglist+17/40>   <===== 
   0:   8b 1b                     mov    (%ebx),%ebx   <===== 
Code;  c022b219 <skb_drop_fraglist+19/40> 
   2:   8b 42 70                  mov    0x70(%edx),%eax 
Code;  c022b21c <skb_drop_fraglist+1c/40> 
   5:   48                        dec    %eax 
Code;  c022b21d <skb_drop_fraglist+1d/40> 
   6:   74 0a                     je     12 <_EIP+0x12> 
Code;  c022b21f <skb_drop_fraglist+1f/40> 
   8:   ff 4a 70                  decl   0x70(%edx) 
Code;  c022b222 <skb_drop_fraglist+22/40> 
   b:   0f 94 c0                  sete   %al 
Code;  c022b225 <skb_drop_fraglist+25/40> 
   e:   84 c0                     test   %al,%al 
Code;  c022b227 <skb_drop_fraglist+27/40> 
  10:   74 07                     je     19 <_EIP+0x19> 
Code;  c022b229 <skb_drop_fraglist+29/40> 
  12:   52                        push   %edx 
Code;  c022b22a <skb_drop_fraglist+2a/40> 
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> 

 <0>Kernel panic: Aiee, killing interrupt handler! 

ksyms I saved before the OOPS occurred, another OOPS (with ksyms 
saved  after rebooting) showed an error in file skbuff.c, line 315: 

kernel BUG at skbuff.c:315! 
invalid operand: 0000 2.4.20-4GB #1 Wed Aug 6 18:26:21 UTC 2003 
CPU:    0 
EIP:    0010:[<c022b44f>]    Not tainted 
Using defaults from ksymoops -t elf32-i386 -a i386 
EFLAGS: 00010286 
eax: 00000045   ebx: c5478440   ecx: c031bf5c   edx: c02bfa60 
esi: c54c2620   edi: 00200000   ebp: 00000046   esp: c031bf58 
ds: 0018   es: 0018   ss: 0018 
Process swapper (pid: 0, stackpage=c031b000) 
Stack: c02bfa60 c022f776 fffffff9 c022f776 c54c2620 00000003 c0346f48 
 c0122b1f  
       c0346f48 00000006 0000000e d3dcdfa0 c031bfa4 c010a34c c0106f90 
 c031a000  
       c031a000 ffffe000 c010c5f8 c0106f90 00000000 00000019 c031a000 
 c031a000  
Call Trace:    [<c022f776>] [<c022f776>] [<c0122b1f>] [<c010a34c>]  
[<c0106f90>] 
  [<c010c5f8>] [<c0106f90>] [<c0106fb4>] [<c0107012>] [<c0105000>] 
Code: 0f 0b 3b 01 f8 df 2b c0 58 5a 8b 54 24 08 e9 fe fe ff ff 8b  


>>EIP; c022b44f <__kfree_skb+ff/140>   <===== 

>>ebx; c5478440 <[raid1]raid1_retry_tail+15751b4/257cdd4> 
>>ecx; c031bf5c <init_task_union+1f5c/2000> 
>>edx; c02bfa60 <cpdext+2c520/34160> 
>>esi; c54c2620 <[raid1]raid1_retry_tail+15bf394/257cdd4> 
>>esp; c031bf58 <init_task_union+1f58/2000> 

Trace; c022f776 <net_tx_action+86/a0> 
Trace; c022f776 <net_tx_action+86/a0> 
Trace; c0122b1f <do_softirq+5f/b0> 
Trace; c010a34c <do_IRQ+9c/b0> 
Trace; c0106f90 <default_idle+0/30> 
Trace; c010c5f8 <call_do_IRQ+5/d> 
Trace; c0106f90 <default_idle+0/30> 
Trace; c0106fb4 <default_idle+24/30> 
Trace; c0107012 <cpu_idle+32/60> 
Trace; c0105000 <_stext+0/0> 

Code;  c022b44f <__kfree_skb+ff/140> 
00000000 <_EIP>: 
Code;  c022b44f <__kfree_skb+ff/140>   <===== 
   0:   0f 0b                     ud2a      <===== 
Code;  c022b451 <__kfree_skb+101/140> 
   2:   3b 01                     cmp    (%ecx),%eax 
Code;  c022b453 <__kfree_skb+103/140> 
   4:   f8                        clc     
Code;  c022b454 <__kfree_skb+104/140> 
   5:   df 2b                     fildll (%ebx) 
Code;  c022b456 <__kfree_skb+106/140> 
   7:   c0 58 5a 8b               rcrb   $0x8b,0x5a(%eax) 
Code;  c022b45a <__kfree_skb+10a/140> 
   b:   54                        push   %esp 
Code;  c022b45b <__kfree_skb+10b/140> 
   c:   24 08                     and    $0x8,%al 
Code;  c022b45d <__kfree_skb+10d/140> 
   e:   e9 fe fe ff ff            jmp    ffffff11 <_EIP+0xffffff11> 
Code;  c022b462 <__kfree_skb+112/140> 
  13:   8b 00                     mov    (%eax),%eax 

 <0>Kernel panic: Aiee, killing interrupt handler! 
############################################################### 
6) shell script: 
no way 
############################################################### 
7) environment: 
Dell Optiplex GX1 400MTbr+, Intel II 400 MHz, 320 MB RAM 
Adaptec AHA 2940UW as PCI-adapter with two hard drives (20GB and 4 GB 
 /boot is on the first scsi-drive) and a Plextor CD-writer 
onboard LAN (3com) 
Promise Ultra133 TX2 as PCI-adapter with two Maxtor-drives (each 
120GB) 
DVD-ROM at the onboard-IDE 
############################################################### 
7.1) ver_linux: 
Linux server01 2.4.20-4GB #1 Wed Aug 6 18:26:21 UTC 2003 i686 unknown 
 unknown GNU/Linux 
  

Gnu C                  3.3 
Gnu make               3.80 
util-linux             2.11z 
mount                  2.11z 
modutils               2.4.22 
e2fsprogs              1.28 
jfsutils               1.1.1 
Linux C Library        x    1 root     root      1475331 Mar 27 21:39 
/lib/libc.so.6 
Dynamic linker (ldd)   2.3.2 
Procps                 3.1.6 
Net-tools              1.60 
Kbd                    1.06 
Sh-utils               4.5.8 
Modules Loaded         isa-pnp usbserial parport_pc lp parport ipv6 
nfsd autofs  st sr_mod sg mousedev joydev evdev input usb-uhci 
usbcore raw1394  ieee1394 3c59x ide-cd cdrom lvm-mod raid1 reiserfs 
aic7xxx 
############################################################### 
7.2) cpuinfo: 
processor	: 0 
vendor_id	: GenuineIntel 
cpu family	: 6 
model		: 5 
model name	: Pentium II (Deschutes) 
stepping	: 2 
cpu MHz		: 398.788 
cache size	: 512 KB 
fdiv_bug	: no 
hlt_bug		: no 
f00f_bug	: no 
coma_bug	: no 
fpu		: yes 
fpu_exception	: yes 
cpuid level	: 2 
wp		: yes 
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov  
pat pse36 mmx fxsr 
bogomips	: 796.26 
############################################################### 
7.3) modules: 
isa-pnp                29672   0 (unused) 
usbserial              18460   0 (autoclean) (unused) 
parport_pc             25800   1 (autoclean) 
lp                      6240   0 (autoclean) 
parport                22440   1 (autoclean) [parport_pc lp] 
ipv6                  134516  -1 (autoclean) 
nfsd                   75536   4 (autoclean) 
autofs                  9268   1 (autoclean) 
st                     27956   0 (autoclean) (unused) 
sr_mod                 12600   0 (autoclean) 
sg                     25852   0 (autoclean) 
mousedev                4148   0 (unused) 
joydev                  5632   0 (unused) 
evdev                   4032   0 (unused) 
input                   3104   0 [mousedev joydev evdev] 
usb-uhci               22096   0 (unused) 
usbcore                57836   1 [usbserial usb-uhci] 
raw1394                14516   0 (unused) 
ieee1394               32880   0 [raw1394] 
3c59x                  26064   1 
ide-cd                 29404   0 (autoclean) 
cdrom                  28192   0 (autoclean) [sr_mod ide-cd] 
lvm-mod                65412  10 (autoclean) 
raid1                  12944   1 (autoclean) 
reiserfs              200532   3 
aic7xxx               159940   6 
############################################################### 
7.4) ioports, iomem: 
0000-001f : dma1 
0020-003f : pic1 
0040-005f : timer 
0060-006f : keyboard 
0070-007f : rtc 
0080-008f : dma page reg 
00a0-00bf : pic2 
00c0-00df : dma2 
00f0-00ff : fpu 
0170-0177 : ide1 
02f8-02ff : serial(auto) 
0376-0376 : ide1 
0378-037a : parport0 
037b-037f : parport0 
03c0-03df : vesafb 
03f8-03ff : serial(auto) 
0800-083f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI 
0840-085f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI 
0cf8-0cff : PCI conf1 
cc00-cc7f : 3Com Corporation 3c905B 100BaseTX [Cyclone] 
  cc00-cc7f : 00:11.0 
cca0-ccaf : Promise Technology, Inc. 20269 
  cca0-cca7 : ide0 
  cca8-ccaf : ide2 
ccb8-ccbb : Promise Technology, Inc. 20269 
  ccba-ccba : ide2 
ccc0-ccc7 : Promise Technology, Inc. 20269 
  ccc0-ccc7 : ide2 
ccd0-ccd3 : Promise Technology, Inc. 20269 
  ccd2-ccd2 : ide0 
ccd8-ccdf : Promise Technology, Inc. 20269 
  ccd8-ccdf : ide0 
cce0-ccff : Intel Corp. 82371AB/EB/MB PIIX4 USB 
  cce0-ccff : usb-uhci 
d000-dfff : PCI Bus #02 
  d800-d8ff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2) 
    d800-d8ff : aic7xxx 
  dc00-dcff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 
    dc00-dcff : aic7xxx 
e000-efff : PCI Bus #01 
  ec00-ecff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X 
ffa0-ffaf : Intel Corp. 82371AB/EB/MB PIIX4 IDE 
  ffa8-ffaf : ide1 

00000000-0009ffff : System RAM 
000a0000-000bffff : Video RAM area 
000c0000-000c7fff : Video ROM 
000c8000-000cc7ff : Extension ROM 
000d0000-000d7fff : Extension ROM 
000d8000-000da7ff : Extension ROM 
000f0000-000fffff : System ROM 
00100000-13ffffff : System RAM 
  00100000-00288dd5 : Kernel code 
  00288dd6-003189c3 : Kernel data 
f0000000-f3ffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host 
bridge 
f5000000-f5ffffff : PCI Bus #02 
f6000000-f6ffffff : PCI Bus #01 
fa000000-fbffffff : PCI Bus #02 
  faffe000-faffefff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2) 

    faffe000-faffefff : aic7xxx 
  fafff000-faffffff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 
    fafff000-faffffff : aic7xxx 
fc000000-feffffff : PCI Bus #01 
  fcfff000-fcffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X 
  fd000000-fdffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X 
    fd000000-fd3fffff : vesafb 
ff000000-ff003fff : Promise Technology, Inc. 20269 
ff004000-ff00407f : 3Com Corporation 3c905B 100BaseTX [Cyclone] 
ffe00000-ffffffff : reserved 
############################################################### 
7.5) PCI: 
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host 
bridge  (rev 03) 
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  ParErr- 
Stepping- SERR+ FastB2B- 
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium  >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- 
	Latency: 64 
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M] 
	Capabilities: [a0] AGP version 1.0 
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-  HTrans- 
64bit- FW- AGP3- Rate=x1,x2 
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-  FW- 
Rate=<none> 

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP 
bridge  (rev 03) (prog-if 00 [Normal decode]) 
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop-  ParErr- 
Stepping- SERR+ FastB2B- 
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium  >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- 
	Latency: 64 
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64 
	I/O behind bridge: 0000e000-0000efff 
	Memory behind bridge: fc000000-feffffff 
	Prefetchable memory behind bridge: f6000000-f6ffffff 
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+ 

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02) 
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-  ParErr- 
Stepping- SERR- FastB2B- 
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium  >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- 
	Latency: 0 

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if  80 [Master]) 
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-  ParErr- 
Stepping- SERR- FastB2B- 
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium  >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- 
	Latency: 32 
	Region 4: I/O ports at ffa0 [size=16] 

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog- if 00 [UHCI]) 
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-  ParErr- 
Stepping- SERR- FastB2B- 
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium  >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- 
	Latency: 64 
	Interrupt: pin D routed to IRQ 14 
	Region 4: I/O ports at cce0 [size=32] 

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02) 
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-  ParErr- 
Stepping- SERR- FastB2B- 
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium  >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- 
	Interrupt: pin ? routed to IRQ 9 

00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 
20269  (rev 02) (prog-if 85) 
	Subsystem: Promise Technology, Inc.: Unknown device 4d68 
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  ParErr- 
Stepping- SERR- FastB2B- 
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- 
	Latency: 64 (1000ns min, 4500ns max), cache line size 08 
	Interrupt: pin A routed to IRQ 11 
	Region 0: I/O ports at ccd8 [size=8] 
	Region 1: I/O ports at ccd0 [size=4] 
	Region 2: I/O ports at ccc0 [size=8] 
	Region 3: I/O ports at ccb8 [size=4] 
	Region 4: I/O ports at cca0 [size=16] 
	Region 5: Memory at ff000000 (32-bit, non-prefetchable) [size=16K] 
	Expansion ROM at f9000000 [disabled] [size=16K] 
	Capabilities: [60] Power Management version 1 
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1- ,D2-,D3hot-
,D3cold-) 
		Status: D0 PME-Enable- DSel=0 DScale=0 PME- 

00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 
03)  (prog-if 00 [Normal decode]) 
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  ParErr- 
Stepping- SERR+ FastB2B- 
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium  >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- 
	Latency: 64, cache line size 08 
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64 
	I/O behind bridge: 0000d000-0000dfff 
	Memory behind bridge: fa000000-fbffffff 
	Prefetchable memory behind bridge: 00000000f5000000- 
00000000f5f00000 
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B- 
	Capabilities: [dc] Power Management version 1 
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0- ,D1-,D2-,D3hot-
,D3cold-) 
		Status: D0 PME-Enable- DSel=0 DScale=0 PME- 
		Bridge: PM- B3+ 

00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX 
[Cyclone]  (rev 24) 
	Subsystem: Dell Computer Corporation 3C905B Fast Etherlink XL  
10/100 
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-  ParErr- 
Stepping- SERR+ FastB2B- 
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium  >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- 
	Latency: 64 (2500ns min, 2500ns max), cache line size 08 
	Interrupt: pin A routed to IRQ 14 
	Region 0: I/O ports at cc00 [size=128] 
	Region 1: Memory at ff004000 (32-bit, non-prefetchable) [size=128] 
	Expansion ROM at f9000000 [disabled] [size=128K] 
	Capabilities: [dc] Power Management version 1 
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0- ,D1+,D2+,D3hot-
,D3cold-) 
		Status: D0 PME-Enable- DSel=0 DScale=0 PME- 

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro 
AGP  1X/2X (rev 5c) (prog-if 00 [VGA]) 
	Subsystem: Dell Computer Corporation Optiplex GX1 Onboard Display  
Adapter 
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  ParErr- 
Stepping+ SERR- FastB2B- 
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium  >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- 
	Latency: 64 (2000ns min), cache line size 08 
	Interrupt: pin A routed to IRQ 9 
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M] 
	Region 1: I/O ports at ec00 [size=256] 
	Region 2: Memory at fcfff000 (32-bit, non-prefetchable) [size=4K] 
	Expansion ROM at <unassigned> [disabled] [size=128K] 
	Capabilities: [50] AGP version 1.0 
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-  HTrans- 
64bit- FW- AGP3- Rate=x1,x2 
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-  FW- 
Rate=<none> 

02:0a.0 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / 
AIC- 7895 (rev 03) 
	Subsystem: Adaptec AHA-2940U/2940UW Dual 
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-  ParErr- 
Stepping- SERR+ FastB2B- 
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium  >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- 
	Latency: 64 (2000ns min, 2000ns max), cache line size 08 
	Interrupt: pin A routed to IRQ 14 
	Region 0: I/O ports at dc00 [disabled] [size=256] 
	Region 1: Memory at fafff000 (32-bit, non-prefetchable) [size=4K] 
	Expansion ROM at fb000000 [disabled] [size=64K] 

02:0a.1 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / 
AIC- 7895 (rev 03) 
	Subsystem: Adaptec AHA-2940U/2940UW Dual 
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-  ParErr- 
Stepping- SERR+ FastB2B- 
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium  >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- 
	Latency: 64 (2000ns min, 2000ns max), cache line size 08 
	Interrupt: pin B routed to IRQ 10 
	Region 0: I/O ports at d800 [disabled] [size=256] 
	Region 1: Memory at faffe000 (32-bit, non-prefetchable) [size=4K] 
############################################################### 
7.6) scsi: 
Attached devices:  
Host: scsi0 Channel: 00 Id: 00 Lun: 00 
  Vendor: IBM      Model: DPSS-318350N     Rev: S96H 
  Type:   Direct-Access                    ANSI SCSI revision: 03 
Host: scsi0 Channel: 00 Id: 01 Lun: 00 
  Vendor: QUANTUM  Model: VIKING II 4.5WLS Rev: 5520 
  Type:   Direct-Access                    ANSI SCSI revision: 02 
Host: scsi0 Channel: 00 Id: 02 Lun: 00 
  Vendor: PLEXTOR  Model: CD-R   PX-W1210S Rev: 1.03 
  Type:   CD-ROM                           ANSI SCSI revision: 02 
############################################################### 
7.7) other: 
/proc/ide: 
ide-cdrom version 4.59 
ide-floppy version 0.99.newide 
ide-disk version 1.16 
ide-default version 0.9.newide 

                                Ultra133 TX2 Chipset. 

Controller: 0 

                                Intel PIIX4 Ultra 33 Chipset. 
--------------- Primary Channel ---------------- Secondary Channel ---
---------- 
                 enabled                          enabled 
--------------- drive0 --------- drive1 -------- drive0 ---------- 
drive1 ------ 
DMA enabled:    no               no              yes               no 
 
UDMA enabled:   no               no              yes               no 
 
UDMA enabled:   X                X               2                 X 
UDMA 
DMA 
PIO 

/proc/interrupts: 
           CPU0        
  0:     132111          XT-PIC  timer 
  1:       4304          XT-PIC  keyboard 
  2:          0          XT-PIC  cascade 
  8:          2          XT-PIC  rtc 
 10:         14          XT-PIC  aic7xxx 
 11:     756756          XT-PIC  ide0, ide2 
 12:      11140          XT-PIC  PS/2 Mouse 
 14:       8349          XT-PIC  aic7xxx, eth0, usb-uhci 
 15:         27          XT-PIC  ide1 
NMI:          0  
LOC:          0  
ERR:          0 
MIS:          0 

Reiser FS: 
reiserfsck 3.6.4 (2002 www.namesys.com) 

Samba: 
Version 2.2.7a-SuSE 
###############################################################


Mit freundlichen Gruessen/Best regards,
Sebastian Piecha

EMail: spi@gmxpro.de

