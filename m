Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUDXSzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUDXSzu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 14:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUDXSzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 14:55:50 -0400
Received: from web50406.mail.yahoo.com ([206.190.38.71]:25955 "HELO
	web50406.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262538AbUDXSz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 14:55:26 -0400
Message-ID: <20040424185525.52521.qmail@web50406.mail.yahoo.com>
Date: Sat, 24 Apr 2004 11:55:25 -0700 (PDT)
From: Harry <postituk@yahoo.com>
Reply-To: harry@uklug.co.uk
Subject: PROBLEM:
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have not submitted a bug report before so I hope this is enough
information. If any more is required please let me know.

[1] Getting Oops's during heavy filesystem access

[2] I initially thought this was a hardware problem because I was
trying to use the SATA on a MSI K8T Neo motherboard. I switched to
using normal IDE disks and got another Oops using the 2.6.5 kernel. I
reverted back to the old binary 2.2.20 kernel and tried to reproduce
the problem but was unable to.

[3] IDE SATA 


[4.]  kernel 2.6.5

[5.] I have had three seperate Oops all of which look completely
different, at least to me. I have only included the first Oops from
each occurence.


Unable to handle kernel paging request at virtual address 00ff0744
printing eip:
c01e5351
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
0060:[generic_make_request+17/384]    Not tainted 
EFLAGS: 00010282   (2.6.5) 
EIP is at generic_make_request+0x11/0x180
eax: 00000202   ebx: 007d8008   ecx: 00ff0740   edx: e8eea300
esi: fb001000   edi: e8eea300   ebp: 00000040   esp: f3ee5d70
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 868, threadinfo=f3ee4000 task=f572b2a0)
Stack: f3ee5d70 f3ee5d70 f3ee5da4 00000082 f1b9f8c0 e8eea300 00000000
00000000
       00000010 c01495ab f7fed8a0 00000010 00000000 e908fbd0 00000001
007d8008
       00000013 00000001 00000040 c01e54fd e8eea300 e908fbd0 c0148fb0
00000001
Call Trace:
 [bio_alloc+203/416] bio_alloc+0xcb/0x1a0
 [submit_bio+61/112] submit_bio+0x3d/0x70
 [ll_rw_block+96/128] ll_rw_block+0x60/0x80
 [journal_commit_transaction+3533/4048]
journal_commit_transaction+0xdcd/0xfd0
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [kjournald+180/464] kjournald+0xb4/0x1d0
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [commit_timeout+0/16] commit_timeout+0x0/0x10
 [kjournald+0/464] kjournald+0x0/0x1d0
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14

Code: 8b 41 04 c1 ee 09 8b 50 38 8b 40 34 0f ac d0 09 85 c0 89 c3


Unable to handle kernel paging request at virtual address 00650d50
 printing eip:
c0161fb4
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[mpage_writepage+116/1344]    Not tainted
EFLAGS: 00010246   (2.6.5)
EIP is at mpage_writepage+0x74/0x540
eax: 2000102d   ebx: 00000000   ecx: 0000000c   edx: 00650d50
esi: c10a9998   edi: 00650d50   ebp: f753e180   esp: c1ba9d10
ds: 007b   es: 007b   ss: 0068
Process pdflush (pid: 6, threadinfo=c1ba8000 task=c1bab700)
Stack: eaf57800 c10a99c0 00001000 00000000 00000000 00000000 00000000
00000000
       00000000 00000001 ec79e6c0 00000001 0000000c f753e20c ec79e6c0
4c5a0d66
       0000e2c2 99f3269a 00000071 c1ba9d8c 00000082 00000001 c0112c3d
00000000
Call Trace:
 [scheduler_tick+109/1296] scheduler_tick+0x6d/0x510
 [schedule+740/1280] schedule+0x2e4/0x500
 [mpage_writepages+596/704] mpage_writepages+0x254/0x2c0
 [ext2_get_block+0/880] ext2_get_block+0x0/0x370
 [ext2_writepages+31/48] ext2_writepages+0x1f/0x30
 [ext2_get_block+0/880] ext2_get_block+0x0/0x370
 [do_writepages+30/64] do_writepages+0x1e/0x40
 [__sync_single_inode+169/480] __sync_single_inode+0xa9/0x1e0
 [sync_sb_inodes+331/496] sync_sb_inodes+0x14b/0x1f0
 [writeback_inodes+51/80] writeback_inodes+0x33/0x50
 [background_writeout+123/192] background_writeout+0x7b/0xc0
 [pdflush+0/48] pdflush+0x0/0x30
 [__pdflush+159/336] __pdflush+0x9f/0x150
 [pdflush+40/48] pdflush+0x28/0x30
 [background_writeout+0/192] background_writeout+0x0/0xc0
 [pdflush+0/48] pdflush+0x0/0x30
 [kthread+165/176] kthread+0xa5/0xb0
 [kthread+0/176] kthread+0x0/0xb0
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14

Code: 8b 02 a8 04 0f 85 f2 02 00 00 8b 02 a8 10 0f 85 8c 02 00 00

Unable to handle kernel paging request at virtual address 000e1b58
 printing eip:
c0133e61
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[activate_page+49/128]    Not tainted
EFLAGS: 00010046   (2.6.5)
EIP is at activate_page+0x31/0x80
eax: c17f7a50   ebx: c10ebe60   ecx: c10ebe78   edx: 000e1b58
esi: c0300fd8   edi: c10ebe60   ebp: d1883ae0   esp: d588fd68
ds: 007b   es: 007b   ss: 0068
Process postmaster (pid: 823, threadinfo=d588e000 task=df3cacc0)
Stack: c10ebe60 00001000 c0133ed8 00000000 c012df8b d93a70c0 c10ebe60
00000000
       00001000 d588fdf4 00000001 00000001 00000337 c62a5c40 c014a1fd
c1b49600
       00000000 00000001 00001000 00000000 d588fdf4 00000000 d1883a54
40a10d00
Call Trace:
 [mark_page_accessed+40/48] mark_page_accessed+0x28/0x30
 [generic_file_aio_write_nolock+1099/2672]
generic_file_aio_write_nolock+0x44b/0xa70
 [bio_hw_segments+45/48] bio_hw_segments+0x2d/0x30
 [scheduler_tick+31/1296] scheduler_tick+0x1f/0x510
 [buffered_rmqueue+191/352] buffered_rmqueue+0xbf/0x160
 [update_process_times+70/96] update_process_times+0x46/0x60
 [update_wall_time+11/64] update_wall_time+0xb/0x40
 [do_timer+223/240] do_timer+0xdf/0xf0
 [generic_file_aio_write+119/160] generic_file_aio_write+0x77/0xa0
 [ext3_file_write+68/192] ext3_file_write+0x44/0xc0
 [do_sync_write+139/192] do_sync_write+0x8b/0xc0
 [permission+70/80] permission+0x46/0x50
 [permission+70/80] permission+0x46/0x50
 [get_empty_filp+104/224] get_empty_filp+0x68/0xe0
 [update_process_times+70/96] update_process_times+0x46/0x60
 [dentry_open+282/432] dentry_open+0x11a/0x1b0
 [filp_open+98/112] filp_open+0x62/0x70
 [do_sync_write+0/192] do_sync_write+0x0/0xc0
 [vfs_write+184/304] vfs_write+0xb8/0x130
 [sys_write+66/112] sys_write+0x42/0x70
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 89 02 c7 41 04 00 02 20 00 c7 43 18 00 01 10 00 ff 4e 2c 0f



[6] I found the problem while restoring a database

cat database.gz | gunzip | psql dbname

where database.gz is a 600Mb file

[7] Debian sarge  ( mild and sunny ;-)


[7.1] 
debian:~# /usr/src/kernel-source-2.6.5/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux debian 2.6.5 #1 Sun Apr 25 19:53:20 BST 2004 i686 GNU/Linux
 
Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.35
pcmcia-cs              3.2.5
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.0
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         tulip crc32 af_packet


[7.2.]
debian:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 4
model name      : AMD Athlon(tm) 64 Processor 3200+
stepping        : 8
cpu MHz         : 2001.027
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall mmxext lm 3dnowext
3dnow
bogomips        : 3940.35

[7.3.]
debian:~# cat /proc/modules 
tulip 36640 0 - Live 0xf88bd000
crc32 3840 1 tulip, Live 0xf88a8000
af_packet 12552 2 - Live 0xf88aa000

[7.4.]
debian:~# cat /proc/ioports     
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
0376-0376 : ide1                
03c0-03df : vga+                
03f6-03f6 : ide0                
0cf8-0cff : PCI conf1           
bc00-bcff : 0000:00:11.5        
c000-c0ff : 0000:00:0f.0        
c400-c40f : 0000:00:0f.0        
  c400-c407 : ide2              
  c408-c40f : ide3              
c800-c803 : 0000:00:0f.0        
  c802-c802 : ide3              
cc00-cc07 : 0000:00:0f.0        
  cc00-cc07 : ide3              
d000-d003 : 0000:00:0f.0
d400-d407 : 0000:00:0f.0
d800-d87f : 0000:00:0e.0
dc00-dcff : 0000:00:0b.0
e000-e0ff : 0000:00:07.0
  e000-e0ff : tulip
e400-e47f : 0000:00:0d.0
  e400-e47f : sata_promise
e800-e80f : 0000:00:0d.0
  e800-e80f : sata_promise
ec00-ec3f : 0000:00:0d.0
  ec00-ec3f : sata_promise
fc00-fc0f : 0000:00:0f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1

debian:~# cat /proc/iomem   
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cc800-000cd7ff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-002b24f6 : Kernel code
  002b24f7-0033d13f : Kernel data
3fff0000-3fff7fff : ACPI Tables
3fff8000-3fffffff : ACPI Non-volatile Storage
bdc00000-cdbfffff : PCI Bus #01
  c0000000-c7ffffff : 0000:01:00.0
cdd00000-cfdfffff : PCI Bus #01
  ce000000-ceffffff : 0000:01:00.0
cff60000-cff7ffff : 0000:00:0d.0
  cff60000-cff7ffff : sata_promise
cfffe000-cfffefff : 0000:00:0d.0
  cfffe000-cfffefff : sata_promise
cffff000-cffff7ff : 0000:00:0e.0
cffffe00-cffffeff : 0000:00:0b.0
cfffff00-cfffffff : 0000:00:07.0
  cfffff00-cfffffff : tulip
d0000000-d1ffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved


[7.5.]
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP]
Host Bridge (rev 01)
    Subsystem: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
    Latency: 8
    Region 0: Memory at d0000000 (32-bit, prefetchable)
    Capabilities: [80] AGP version 3.0
        Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans-
64bit- FW+ AGP3- Rate=x4 
        Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>
    Capabilities: [c0] #08 [0060]
    Capabilities: [68] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [58] #08 [8001]

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge
[K8T800 South] (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: cdd00000-cfdfffff
    Prefetchable memory behind bridge: bdc00000-cdbfffff
    BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 Ethernet controller: Lite-On Communications Inc LNE100TX
(rev 20)
    Subsystem: Netgear FA310TX 
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Interrupt: pin A routed to IRQ 5
    Region 0: I/O ports at e000 [size=cff80000]
    Region 1: Memory at cfffff00 (32-bit, non-prefetchable) [size=256]
    Expansion ROM at 00040000 [disabled]
0000:00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8169 (rev 10)
    Subsystem: Micro-Star International Co., Ltd.: Unknown device 702c
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (8000ns min, 16000ns max), Cache Line Size: 0x08 (32
bytes)
    Interrupt: pin A routed to IRQ 11
    Region 0: I/O ports at dc00 [size=cffc0000]
    Region 1: Memory at cffffe00 (32-bit, non-prefetchable) [size=256]
    Expansion ROM at 00020000 [disabled]
    Capabilities: [dc] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0d.0 RAID bus controller: Promise Technology, Inc.: Unknown
device 3373 (rev 02)
    Subsystem: Micro-Star International Co., Ltd.: Unknown device 702e
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 96 (1000ns min, 4500ns max), Cache Line Size: 0x91 (580
bytes)
    Interrupt: pin A routed to IRQ 10
    Region 0: I/O ports at ec00
    Region 1: I/O ports at e800 [size=16]
    Region 2: I/O ports at e400 [size=128]
    Region 3: Memory at cfffe000 (32-bit, non-prefetchable) [size=4K]
    Region 4: Memory at cff60000 (32-bit, non-prefetchable) [size=128K]
    Capabilities: [60] Power Management version 2
        Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0e.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394
Host Controller (rev 80) (prog-if 10 [OHCI])
    Subsystem: Micro-Star International Co., Ltd.: Unknown device 702d
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (8000ns max), Cache Line Size: 0x08 (32 bytes)
    Interrupt: pin A routed to IRQ 3
    Region 0: Memory at cffff000 (32-bit, non-prefetchable)
    Region 1: I/O ports at d800 [size=128]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-


0000:00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown
device 3149 (rev 80)
    Subsystem: Micro-Star International Co., Ltd.: Unknown device 7020
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Interrupt: pin B routed to IRQ 10
    Region 0: I/O ports at d400
    Region 1: I/O ports at d000 [size=4]
    Region 2: I/O ports at cc00 [size=8]
    Region 3: I/O ports at c800 [size=4]
    Region 4: I/O ports at c400 [size=16]
    Region 5: I/O ports at c000 [size=256]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
(
prog-if 8a [Master SecP PriP])
    Subsystem: Micro-Star International Co., Ltd.: Unknown device 7020
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Interrupt: pin A routed to IRQ 0
    Region 4: I/O ports at fc00 [size=16]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[K8T800 South]
    Subsystem: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
    Subsystem: Micro-Star International Co., Ltd.: Unknown device 0080
    Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin C routed to IRQ 5
    Region 0: I/O ports at bc00
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Capabilities: [80] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV11DDR
[GeForce2 MX 100 DDR/200 DDR] (rev b2) (prog-if 00 [VGA])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (1250ns min, 250ns max)
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at ce000000 (32-bit, non-prefetchable)
[size=cfdf0000]
    Region 1: Memory at c0000000 (32-bit, prefetchable) [size=128M]
    Expansion ROM at 00010000 [disabled]
    Capabilities: [60] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [44] AGP version 2.0
        Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans-
64bit- FW+ AGP3- Rate=x1,x2,x4
        Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>

[7.6.]
debian:~# cat /proc/scsi/scsi 
Attached devices:



[X.] Since I am unable to reproduce the problem with the old binary
2.2.20 on normal IDE disks but I can on the same disks when using the
2.6.5 compiled kernel I am making the wild assumption that it is not
hardware related. I tried to find rougly where the problem was using  

objdump -d
/mnt/hdc2/usr/src/kernel-source-2.6.4/drivers/block/ll_rw_blk.o
objdump -d /usr/src/linux/fs/bio.o
objdump -d fs/mpage.o

and trying to use the offsets from the oops to see where the problem
was but I was unable to locate the offset in each of the files. This is
probably more my inexperience than anything else. If there is a decent
tutorial on how to do this sort of thing I would appreciate a pointer
or two. So far the only thing I can think of is that my compiler is
dodgy or I am having spurious memory problems.

yours 
Harry




	
		
__________________________________
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢
http://photos.yahoo.com/ph/print_splash
