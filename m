Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbUBYRoa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 12:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbUBYRoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 12:44:30 -0500
Received: from imsmta2.indosat.net.id ([202.155.50.25]:27845 "EHLO
	imsmta2.indosat.net.id") by vger.kernel.org with ESMTP
	id S261484AbUBYRlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 12:41:13 -0500
Date: Thu, 26 Feb 2004 00:45:05 +0700
From: "Muhammad L." <muhammad@vauban.net>
Subject: Re: ext3 on raid5 failure
To: linux-kernel@vger.kernel.org
Cc: muhammad@vauban.net
Message-id: <1077731104.2213.61.camel@dis.bellua.com>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all, (please Cc: me in the answer)

Sorry to interrupt but the problem isn't fixed at all.

I get exactly the same problem with the 2.6.0 test serie and final 2.6.0
and got so sick of the problem that I downgraded back to 2.4.x.

It happens EVERYTIME I do a lot of IO (e.g. copy big files (> 600 megs
around), it is systematic. I never had this problem under 2.4.x and I am
so sad I am going to downgrade to 2.4.24/25 tonight. 

I am in the mood I might reproduce the problem again and log the output
of fsck -C -y (takes ages to fsck a 270meg partition)

I have 1 gig of ram, a amd xp2500+ at 1800ghz (not overclocked),
currently my raid5 fs contains 274 gigs and the problem under 2.6 was
present from the very begining. My raid5 setup is a 4x120Gig each on a
separate controler. Again under 2.4 this machine works perfectly and I
have copied 100 gig of DV materials around without problems.

Recently when evms 2.2.2 was released I installed a 2.6.3 and tried
again.

Thanks and regards,

Muhammad

Here is the most recent dmesg and the initial bug report I prepared and
forgot to post on the kernel mailing at the time (mea culpa, mea
culpa...)

EXT3-fs error (device dm-2): ext3_readdir: bad entry in directory
#35160065: directory entry across blocks - offset=0, inode=1836597052,
rec_len=8300, name_len=118
EXT3-fs error (device dm-2) in start_transaction: Journal has aborted
EXT3-fs error (device dm-2) in start_transaction: Journal has aborted
EXT3-fs error (device dm-2) in start_transaction: Journal has aborted
EXT3-fs error (device dm-2) in start_transaction: Journal has aborted
EXT3-fs error (device dm-2) in start_transaction: Journal has aborted
EXT3-fs error (device dm-2) in start_transaction: Journal has aborted
EXT3-fs error (device dm-2) in start_transaction: Journal has aborted
EXT3-fs error (device dm-2) in start_transaction: Journal has aborted
EXT3-fs error (device dm-2): ext3_readdir: bad entry in directory
#35160065: directory entry across blocks - offset=0, inode=1836597052,
rec_len=8300, name_len=118
EXT3-fs error (device dm-2) in start_transaction: Journal has aborted
EXT3-fs error (device dm-2) in start_transaction: Journal has aborted
EXT3-fs error (device dm-2) in start_transaction: Journal has aborted

[1.] One line summary of the problem:
2.6.3-mm1 + evms 2.2.2 patches, 2.6.0-test9 + evms 2.1.1/2.2.0 patches:
Ext3 fs corruption and journal abortion when writing big files to md
device.
                                                                                                                                                               
[2.] Full description of the problem/report:
Simple stress test (dd if=/dev/zero of=swapfile bs=1024 count=1048576 #
1Gb) will crash my raid-5 md partition
under 2.6.0-test9 + evms 2.1.1 or 2.2.0 patches (2.6.0-test9-dm4 or
2.6.0-test9-udm5). Under 2.4.22 and its
evms 2.x patches on the same machine, the same operation works perfectly
(copied 100 gig from a normal partition
to the raid-5 md.  Applying linus-patch from test9-mm3 which is supposed
to fix a related problem doesn't solve
the issue and it only makes the dmesg output less verbose.
                                                                                                                                                               
I tried running a 2.6.0-test9 with evms 2.1.1 or 2.2.0 patches, I get
ext3 corruption under fs load (e.g. creation of a
1gig file). Using 2.4.22 + evms patches works perfect.
                                                                                                                                                               
[3.] Keywords (i.e., modules, networking, kernel):
2.6.0 test9 evms ext3 fs corruption md raid journal
__journal_remove_journal_head ext3_readdir
                                                                                                                                                               
[4.] Kernel version (from /proc/version):
Kernel version:
(Oh by the way, yes it is a gentoo distribution but a stable branch and
no fancy CFLAGS and also it is not a gentoo kernel, just a vanilla one
straight from kernel.org)
Linux version 2.6.3 (root@dis) (gcc version 3.3.2 20031218 (Gentoo Linux
3.3.2-r5, propolice-3.3-7)) #1 Wed Feb 18 20:14:27 WIT 2004
Linux version 2.6.0-test9 (root@dis) (gcc version 3.2.3 20030422 (Gentoo
Linux 1.4 3.2.3-r2, propolice)) #4 Fri Nov
14 04:58:11 WIT 2003
                                                                                                                                                               
                                                                                                                                                               
[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
 hdb: hdb1 hdb2
 hdb: hdb1 hdb2
Adding 257000k swap on /dev/evms/hdb1.  Priority:-1 extents:1
EXT3-fs error (device dm-8): ext3_readdir: bad entry in directory
#35536897: rec_len is smaller than minimal - offset=0, inode=0,
rec_len=0, name_len=0
Aborting journal on device dm-8.
ext3_abort called.
EXT3-fs abort (device dm-8): ext3_journal_start: Detected aborted
journal
Remounting filesystem read-only
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in ext3_ordered_writepage: IO failure
ext3_try_to_allocate: aborting transaction: Journal has aborted in
__ext3_journal_get_undo_access<2>EXT3-fs error (device dm-8) in
ext3_new_block: Journal has aborted
EXT3-fs error (device dm-8) in ext3_prepare_write: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
Assertion failure in __journal_remove_journal_head() at
fs/jbd/journal.c:1733: "!jh->b_committed_data"
------------[ cut here ]------------
kernel BUG at fs/jbd/journal.c:1733!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c01a0d41>]    Tainted: PF
EFLAGS: 00010286
EIP is at __journal_remove_journal_head+0xf5/0x1b4
eax: 0000006a   ebx: dccb6528   ecx: c1bfecc0   edx: c040cdd8
esi: d7a2efc0   edi: 00000000   ebp: c1bf9d8c   esp: c1bf9d70
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 29, threadinfo=c1bf8000 task=c1bfecc0)
Stack: c03a5740 c038d837 c03a2731 000006c5 c03a2531 c1bf8000 dccb6528
c1bf9d9c
       c01a0e1f dccb6528 c1bf8000 c1bf9db0 c019b80e dccb6528 d7a2efc0
f785c480
       c1bf9f60 c019bd28 f6a44380 d7a2efc0 c1bf9e54 000017b6 f8ab8037
f6a443dc
Call Trace:
 [<c01a0e1f>] journal_remove_journal_head+0x1f/0x3d
 [<c019b80e>] journal_refile_buffer+0x3c/0x67
 [<c019bd28>] journal_commit_transaction+0x426/0x12f6
 [<f8ab8037>] __nvsym02561+0x4f/0x6c [nvidia]
 [<c011f4b4>] autoremove_wake_function+0x0/0x4b
 [<f8ac29aa>] __nvsym00830+0x12/0x18 [nvidia]
 [<c011f4b4>] autoremove_wake_function+0x0/0x4b
 [<c019ee21>] kjournald+0xc4/0x251
 [<c011f4b4>] autoremove_wake_function+0x0/0x4b
 [<c011f4b4>] autoremove_wake_function+0x0/0x4b
 [<c010b226>] ret_from_fork+0x6/0x14
 [<c019ed4c>] commit_timeout+0x0/0xc
 [<c019ed5d>] kjournald+0x0/0x251
 [<c01092a5>] kernel_thread_helper+0x5/0xb
                                                                                                                                                               
Code: 0f 0b c5 06 31 27 3a c0 eb a0 c7 44 24 10 47 25 3a c0 c7 44
 <6>note: kjournald[29] exited with preempt_count 2
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
EXT3-fs error (device dm-8) in start_transaction: Journal has aborted
root@dis:/#
                                                                                                                                                               
Code disassembly:
0x80493f4 <str>:        ud2a
0x80493f6 <str+2>:      lds    (%esi),%eax
0x80493f8 <str+4>:      xor    %esp,(%edi)
0x80493fa <str+6>:      cmp    %al,%al
0x80493fc <str+8>:      jmp    0x804939e
0x80493fe <str+10>:     movl   $0xc03a2547,0x10(%esp,1)
0x8049406 <str+18>:     movl   $0x10000,0x0(%eax,%eax,1)
                                                                                                                                                               
code disassembly from the test9 + linus.patch (mm3), it doesn't output
an oops but still fails.
0xc01a0d77 <__journal_remove_journal_head+299>: ud2a
0xc01a0d79 <__journal_remove_journal_head+301>: les    (%esi),%eax
0xc01a0d7b <__journal_remove_journal_head+303>: xor    %esp,(%edi)
0xc01a0d7d <__journal_remove_journal_head+305>: cmp    %al,%al
0xc01a0d7f <__journal_remove_journal_head+307>: jmp    0xc01a0ce4
<__journal_remove_journal_head+152>
0xc01a0d84 <__journal_remove_journal_head+312>: movl  
$0xc03a280a,0x10(%esp,1)
0xc01a0d8c <__journal_remove_journal_head+320>: movl  
$0x6c1,0xc(%esp,1)
0xc01a0d94 <__journal_remove_journal_head+328>: movl  
$0xc03a2731,0x8(%esp,1)
0xc01a0d9c <__journal_remove_journal_head+336>: movl  
$0xc038d837,0x4(%esp,1)
0xc01a0da4 <__journal_remove_journal_head+344>: movl  
$0xc03a5740,(%esp,1)
                                                                                                                                                               
[6.] A small shell script or example program which triggers the
     problem (if possible)
dd if=/dev/zero of=swapfile bs=1024 count=1048576 # 1Gb
                                                                                                                                                               
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.12
e2fsprogs              1.33
jfsutils               1.1.2
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.0
Modules Loaded         XXX
                                                                                                                                                               
[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2500+
stepping        : 0
cpu MHz         : 1830.150
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3643.80
                                                                                                                                                               
7.3.] Module information (from /proc/modules):
   loop 12296 0 - Live 0xf9e0e000
rfcomm 34716 3 - Live 0xf8d17000
ipt_state 1472 32 - Live 0xf8a0e000
ipt_LOG 5056 23 - Live 0xf8a63000
iptable_filter 2176 1 - Live 0xf88cf000
ipt_MASQUERADE 2816 5 - Live 0xf88d3000
iptable_nat 19500 2 ipt_MASQUERADE, Live 0xf8ca1000
ip_conntrack 27312 3 ipt_state,ipt_MASQUERADE,iptable_nat, Live
0xf8c88000
ip_tables 16064 5
ipt_state,ipt_LOG,iptable_filter,ipt_MASQUERADE,iptable_nat, Live
0xf8a5e000
ipv6 231936 842 - Live 0xf8ccc000
snd_ens1370 15076 0 - Live 0xf8a59000
snd_ak4531_codec 6848 1 snd_ens1370, Live 0xf88c6000
snd_ens1371 19940 0 - Live 0xf8a53000
snd_intel8x0 29124 0 - Live 0xf8a03000
snd_via82xx 21888 3 - Live 0xf89fc000
snd_ac97_codec 59332 3 snd_ens1371,snd_intel8x0,snd_via82xx, Live
0xf8a10000
snd_mpu401_uart 6080 2 snd_intel8x0,snd_via82xx, Live 0xf88c9000
snd_rawmidi 20768 3 snd_ens1370,snd_ens1371,snd_mpu401_uart, Live
0xf88b3000
tuner 16716 0 - Live 0xf88c0000
tvaudio 20428 0 - Live 0xf88ba000
msp3400 22100 0 - Live 0xf88a6000
bttv 142636 0 - Live 0xf88d6000
video_buf 17092 1 bttv, Live 0xf88ad000
i2c_algo_bit 8840 1 bttv, Live 0xf88a2000
v4l2_common 4928 1 bttv, Live 0xf8897000
btcx_risc 3848 1 bttv, Live 0xf8895000
i2c_core 19268 5 tuner,tvaudio,msp3400,bttv,i2c_algo_bit, Live
0xf889c000
videodev 7680 1 bttv, Live 0xf882e000
nvidia 1701484 16 - Live 0xf8a66000
via_agp 5824 1 - Live 0xf882b000
bnep 13184 2 - Live 0xf8818000
l2cap 21764 9 rfcomm,bnep, Live 0xf8848000
bridge 32788 0 - Live 0xf883e000
hci_usb 9600 0 - Live 0xf8823000
bluetooth 43684 6 rfcomm,bnep,l2cap,hci_usb, Live 0xf8832000
                                                                                                                                                            
[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
   dis:/boot$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000d4000-000d7bff : Extension ROM
000d8000-000d87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-003b6abb : Kernel code
  003b6abc-004e8aff : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
c0000000-cfffffff : 0000:00:00.0
d0000000-d7ffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
d8000000-d9ffffff : PCI Bus #01
  d8000000-d8ffffff : 0000:01:00.0
db000000-db003fff : 0000:00:0d.0
db004000-db00407f : 0000:00:09.0
db005000-db005fff : 0000:00:08.0
  db005000-db005fff : bttv0
db006000-db0067ff : 0000:00:0d.0
db007000-db007fff : 0000:00:08.1
db008000-db0080ff : 0000:00:0f.0
  db008000-db0080ff : 8139too
db009000-db0090ff : 0000:00:10.2
  db009000-db0090ff : ehci_hcd
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved
is:/boot$ cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
a000-a07f : 0000:00:09.0
  a000-a07f : 0000:00:09.0
a400-a4ff : 0000:00:0f.0
  a400-a4ff : 8139too
a800-a81f : 0000:00:10.0
  a800-a81f : uhci_hcd
ac00-ac1f : 0000:00:10.1
  ac00-ac1f : uhci_hcd
b000-b00f : 0000:00:11.1
  b000-b007 : ide0
  b008-b00f : ide1
b400-b41f : 0000:00:11.2
  b400-b41f : uhci_hcd
b800-b81f : 0000:00:11.3
  b800-b81f : uhci_hcd
bc00-bcff : 0000:00:11.5
  bc00-bcff : VIA8233A
c000-c007 : 0000:00:13.0
  c000-c007 : ide2
c400-c403 : 0000:00:13.0
  c402-c402 : ide2
c800-c807 : 0000:00:13.0
  c800-c807 : ide3
cc00-cc03 : 0000:00:13.0
  cc02-cc02 : ide3
d000-d0ff : 0000:00:13.0
  d000-d007 : ide2
  d008-d00f : ide3
d400-d407 : 0000:00:13.1
  d400-d407 : ide4
d800-d803 : 0000:00:13.1
  d802-d802 : ide4
dc00-dc07 : 0000:00:13.1
  dc00-dc07 : ide5
e000-e003 : 0000:00:13.1
  e002-e002 : ide5
e400-e4ff : 0000:00:13.1
  e400-e407 : ide4
  e408-e40f : ide5
                                                                                                                                                            
[7.5.] PCI information ('lspci -vvv' as root)
  00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
        Subsystem: ABIT Computer Corp.: Unknown device 7405
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW-
Rate=x4
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                                                                                                                                                               
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d8000000-d9ffffff
        Prefetchable memory behind bridge: d0000000-d7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                                                                                                                                                               
00:08.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at db005000 (32-bit, prefetchable) [size=4K]
                                                                                                                                                               
00:08.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at db007000 (32-bit, prefetchable) [size=4K]
                                                                                                                                                               
00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado]
(rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at a000 [size=128]
        Region 1: Memory at db004000 (32-bit, non-prefetchable)
[size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=2 PME-
 
00:0d.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23
IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 7405
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at db006000 (32-bit, non-prefetchable)
[size=2K]
        Region 1: Memory at db000000 (32-bit, non-prefetchable)
[size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: ABIT Computer Corp.: Unknown device 8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at a400 [size=256]
        Region 1: Memory at db008000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
 
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00
[UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 7405
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 3
        Region 4: I/O ports at a800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00
[UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 7405
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 7
        Region 4: I/O ports at ac00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:10.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if
20 [EHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 7405
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at db009000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
        Subsystem: VIA Technologies, Inc. VT8233A ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at b000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00
[UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 7405
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 3
        Region 4: I/O ports at b400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00
[UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 7405
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 3
        Region 4: I/O ports at b800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235 AC97 Audio Controller (rev 40)
        Subsystem: ABIT Computer Corp.: Unknown device 7405
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 10
        Region 0: I/O ports at bc00 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:13.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at c000 [size=8]
        Region 1: I/O ports at c400 [size=4]
        Region 2: I/O ports at c800 [size=8]
        Region 3: I/O ports at cc00 [size=4]
        Region 4: I/O ports at d000 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:13.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d400 [size=8]
        Region 1: I/O ports at d800 [size=4]
        Region 2: I/O ports at dc00 [size=8]
        Region 3: I/O ports at e000 [size=4]
        Region 4: I/O ports at e400 [size=256]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2
MX/MX 400] (rev a1) (prog-if 00 [VGA])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d8000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit-
FW- Rate=x4
 
                                                                                                                                                             
[7.6.] SCSI information (from /proc/scsi/scsi)
          Attached devices:
none                                                                                                                                                     
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

root@dis:/proc# df
root@dis:/var/log# swapon -s
Filename                                Type            Size    Used   
Priority
/.swap-a                                 file           1048568 187972 
-1
/.swap-b                                 file           1048568 0      
-2
/.swap-c                                 file           1048568 0      
-3

Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/evms/raid5a     354530944 274848692  61673136  82% /
none                    516736         0    516736   0% /dev/shm
root@dis:/var/log# free
             total       used       free     shared    buffers    
cached
Mem:       1033472    1023872       9600          0     121796    
156380
-/+ buffers/cache:     745696     287776
Swap:      3145704     187972    2957732

-- 
Muhammad L. <muhammad@vauban.net>

