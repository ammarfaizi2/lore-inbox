Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVHCNks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVHCNks (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 09:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVHCNks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 09:40:48 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:21656 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262289AbVHCNkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 09:40:45 -0400
X-ME-UUID: 20050803134042960.EA93C1C000B6@mwinf0806.wanadoo.fr
Date: Wed, 3 Aug 2005 14:58:09 +0200
From: Laurent Wandrebeck <lw@hygeos.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: reproductible oops, NFS, gigabit network, x86_64
Message-Id: <20050803145809.4341f26f.lw@hygeos.com>
Organization: HYGEOS
X-Mailer: Sylpheed version 1.0.0-gtk2-20041224 (GTK+ 2.4.14; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, please CC me on replies.

[1.] One line summary of the problem:    

Oops while copying on a distant volume using NFS.

[2.] Full description of the problem/report:

Two boxes A and B. B mounts /home from A. Start a big copy from B to A (using B).
Oopses quite quickly. Doesn't happen if A mounts B volume, and copy is launched
from A.

[3.] Keywords (i.e., modules, networking, kernel):

kernel, networking, CPU frequency scaling.

[4.] Kernel version (from /proc/version):

Tried Suse Pro 9.3 (x86_64) kernel: 2.6.11-24 or something.
CentOS 4.1 (x86_64): 2.6.9-11.EL
Vanilla 2.6.11.12
Vanilla 2.6.13-rc5

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

No oops from Suse (box has been reinstalled since), nor official CentOS kernel
as it doesn't get written to logs, and I don't have access to a serial terminal.
Oops from 2.6.11.12:
Aug  2 13:56:16 homes kernel: general protection fault: 0000 [1] 
Aug  2 13:56:16 homes kernel: CPU 0 
Aug  2 13:56:16 homes kernel: Modules linked in: nfsd exportfs lockd md5 ipv6 parport_pc lp parport autofs4 sunrpc dm_mod video button battery ac ohci_hcd ehci_hcd i2c_nforce2 i2c_core snd_intel8x0 snd_ac97_code
c snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc r8169 8139too mii floppy ext3 jbd raid5 xor raid1 sata_nv sata_sil libata sd_mod scsi_mod
Aug  2 13:56:16 homes kernel: Pid: 4886, comm: nfsd Not tainted 2.6.11.12
Aug  2 13:56:16 homes kernel: RIP: 0010:[<ffffffff802af247>] <ffffffff802af247>{__kfree_skb+183}
Aug  2 13:56:16 homes kernel: RSP: 0018:ffff8100792d79b8  EFLAGS: 00010246
Aug  2 13:56:16 homes kernel: RAX: 0000000000000000 RBX: ffff810079f5e680 RCX: 0000000000000008
Aug  2 13:56:16 homes kernel: RDX: ffff810042a0fe80 RSI: 000000005cf6dcdd RDI: ffff810042a0f340
Aug  2 13:56:16 homes kernel: RBP: ffff810042a0f340 R08: 00000000ffffff95 R09: 00000000000005a8
Aug  2 13:56:16 homes kernel: R10: ffffffff803b1d60 R11: 6db6db6db6db6db7 R12: ffff810079504640
Aug  2 13:56:16 homes kernel: R13: ffff810079504ad0 R14: 0000000000002fd0 R15: ffff8100795046c0
Aug  2 13:56:16 homes kernel: FS:  00002aaaaace8b00(0000) GS:ffffffff80463c00(0000) knlGS:0000000000000000
Aug  2 13:56:16 homes kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Aug  2 13:56:16 homes kernel: CR2: 00002aaaaaaac000 CR3: 000000007c3f2000 CR4: 00000000000006e0
Aug  2 13:56:16 homes kernel: Process nfsd (pid: 4886, threadinfo ffff8100792d6000, task ffff8100792aa0f0)
Aug  2 13:56:16 homes kernel: Stack: ffff810079504ad0 0000000000000000 ffff810042a0f340 ffffffff802d8f44 
Aug  2 13:56:16 homes kernel:        ffff810079504640 00000000000005a8 0000000000000001 0000000000000001 
Aug  2 13:56:16 homes kernel:        0000000179504640 0000000000000000 
Aug  2 13:56:16 homes kernel: Call Trace:<ffffffff802d8f44>{tcp_recvmsg+1620} <ffffffff802ae8d3>{sock_common_recvmsg+51} 
Aug  2 13:56:16 homes kernel:        <ffffffff802aae7b>{sock_recvmsg+315} <ffffffff802aaca9>{sock_sendmsg+297} 
Aug  2 13:56:16 homes kernel:        <ffffffff80145bd0>{autoremove_wake_function+0} <ffffffff802adbe3>{lock_sock+211} 
Aug  2 13:56:16 homes kernel:        <ffffffff802aaefb>{kernel_recvmsg+59} <ffffffff88155cfb>{:sunrpc:svc_recvfrom+123} 
Aug  2 13:56:16 homes kernel:        <ffffffff88157677>{:sunrpc:svc_tcp_recvfrom+1719} <ffffffff8013a361>{del_timer+1} 
Aug  2 13:56:16 homes kernel:        <ffffffff80312da6>{schedule_timeout+166} <ffffffff8013aee0>{process_timeout+0} 
Aug  2 13:56:16 homes kernel:        <ffffffff881569dc>{:sunrpc:svc_recv+1036} <ffffffff8012f0d0>{default_wake_function+0} 
Aug  2 13:56:16 homes kernel:        <ffffffff8012f0d0>{default_wake_function+0} <ffffffff881f11e0>{:nfsd:nfsd+0} 
Aug  2 13:56:16 homes kernel:        <ffffffff881f12e3>{:nfsd:nfsd+259} <ffffffff8012e96e>{schedule_tail+14} 
Aug  2 13:56:16 homes kernel:        <ffffffff8010ec9b>{child_rip+8} <ffffffff881f11e0>{:nfsd:nfsd+0} 
Aug  2 13:56:16 homes kernel:        <ffffffff881f11e0>{:nfsd:nfsd+0} <ffffffff8010ec93>{child_rip+0} 
Aug  2 13:56:16 homes kernel:        
Aug  2 13:56:16 homes kernel: 
Aug  2 13:56:16 homes kernel: Code: ff 95 b8 00 00 00 48 8b 95 d0 00 00 00 48 85 d2 74 0f ff 0a 
Aug  2 13:56:16 homes kernel: RIP <ffffffff802af247>{__kfree_skb+183} RSP <ffff8100792d79b8>

Oops from 2.6.13-rc5:
Aug  2 14:29:28 homes kernel: general protection fault: 0000 [1] 
Aug  2 14:29:28 homes kernel: CPU 0 
Aug  2 14:29:28 homes kernel: Modules linked in: nfsd exportfs lockd ipv6 parport_pc lp parport autofs4 sunrpc dm_mod video hotkey button battery ac ohci_hcd ehci_hcd i2c_nforce2 i2c_core snd_intel8x0 snd_ac97_c
odec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc r8169 8139too mii floppy ext3 jbd raid5 xor raid1 sata_nv sata_sil libata sd_mod scsi_mod
Aug  2 14:29:28 homes kernel: Pid: 4695, comm: nfsd Not tainted 2.6.13-rc5
Aug  2 14:29:28 homes kernel: RIP: 0010:[<ffffffff8805861c>] <ffffffff8805861c>{:jbd:journal_add_journal_head+284}
Aug  2 14:29:28 homes kernel: RSP: 0018:ffff8100792b5b48  EFLAGS: 00010202
Aug  2 14:29:28 homes kernel: RAX: 000000000000412d RBX: ffff810000c0ac38 RCX: 0000000000000000
Aug  2 14:29:28 homes kernel: RDX: 0000000000000000 RSI: ffff810000c0ac38 RDI: ccff81002a87d560
Aug  2 14:29:28 homes kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff88065ee0
Aug  2 14:29:28 homes kernel: R10: 0000000000000001 R11: 0000000000000006 R12: ffff810000c0ac38
Aug  2 14:29:28 homes kernel: R13: 0000000000001000 R14: 0000000000000000 R15: 0000000000001000
Aug  2 14:29:28 homes kernel: FS:  00002aaaaace8b00(0000) GS:ffffffff80487800(0000) knlGS:0000000000000000
Aug  2 14:29:28 homes kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Aug  2 14:29:28 homes kernel: CR2: 00002aaaaaaac000 CR3: 0000000078b47000 CR4: 00000000000006e0
Aug  2 14:29:28 homes kernel: Process nfsd (pid: 4695, threadinfo ffff8100792b4000, task ffff8100792b36e0)
Aug  2 14:29:28 homes kernel: Stack: 0000000300000000 ffff810006c63700 ffff81007cce5a00 ffffffff88053a47 
Aug  2 14:29:28 homes kernel:        0000000000001000 ffff810006c63700 ffff810000c0ac38 0000000000001000 
Aug  2 14:29:28 homes kernel:        0000000000000000 ffffffff88065bdd 
Aug  2 14:29:28 homes kernel: Call Trace:<ffffffff88053a47>{:jbd:journal_dirty_data+71} <ffffffff88065bdd>{:ext3:ext3_journal_dirty_data+29}
Aug  2 14:29:28 homes kernel:        <ffffffff8806592a>{:ext3:walk_page_buffers+106} <ffffffff88065ee0>{:ext3:journal_dirty_data_fn+0}
Aug  2 14:29:28 homes kernel:        <ffffffff88066034>{:ext3:ext3_ordered_writepage+308}
Aug  2 14:29:28 homes kernel:        <ffffffff80195597>{mpage_writepages+455} <ffffffff88065f00>{:ext3:ext3_ordered_writepage+0}
Aug  2 14:29:28 homes kernel:        <ffffffff80153d24>{__filemap_fdatawrite_range+148} <ffffffff881ffa99>{:nfsd:nfsd_sync+121}
Aug  2 14:29:28 homes kernel:        <ffffffff881ffc84>{:nfsd:nfsd_commit+84} <ffffffff88209213>{:nfsd:nfsd3_proc_commit+195}
Aug  2 14:29:28 homes kernel:        <ffffffff881fc5f0>{:nfsd:nfsd_dispatch+240} <ffffffff88161241>{:sunrpc:svc_process+993}
Aug  2 14:29:28 homes kernel:        <ffffffff8012f230>{default_wake_function+0} <ffffffff881fc1e0>{:nfsd:nfsd+0}
Aug  2 14:29:28 homes kernel:        <ffffffff881fc386>{:nfsd:nfsd+422} <ffffffff8010f31e>{child_rip+8}
Aug  2 14:29:28 homes kernel:        <ffffffff881fc1e0>{:nfsd:nfsd+0} <ffffffff881fc1e0>{:nfsd:nfsd+0}
Aug  2 14:29:29 homes kernel:        <ffffffff8010f316>{child_rip+0} 
Aug  2 14:29:29 homes kernel: 
Aug  2 14:29:29 homes kernel: Code: ff 47 08 48 85 ed 74 08 48 89 ef e8 b4 fe ff ff 48 8b 43 40 
Aug  2 14:29:29 homes kernel: RIP <ffffffff8805861c>{:jbd:journal_add_journal_head+284} RSP <ffff8100792b5b48>

[6.] A small shell script or example program which triggers the
     problem (if possible)

cp -r /lots/of/big/files /nfs/mounted/distant/volume/

[7.] Environment

A64 3400+, 2GB ram, 6*200GB sata disks mounted using
soft raid 0 and soft raid 5.
md0, raid 1, /boot.
md1,2,3, raid 5, swap, /, /home.
motherboard is asus K8NE-deluxe, with latest stable bios realease.
chipset is nforce 3 250GB.
nv network chipset is disabled, two r8169 are used.
2 disks using sata_nv, 4 using sata_sil.

[7.1.] Software (add the output of the ver_linux script here)

Linux homes.hygeos.net 2.6.13-rc5 #2 Tue Aug 2 14:36:35 CEST 2005 x86_64 x86_64 
x86_64 GNU/Linux
 
Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12a
mount                  2.12a
module-init-tools      3.1-pre5
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   039
Modules Loaded         ipv6 parport_pc lp parport autofs4 sunrpc dm_mod video ho
tkey button battery ac ohci_hcd ehci_hcd i2c_nforce2 i2c_core snd_intel8x0 snd_a
c97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_all
oc r8169 8139too mii floppy ext3 jbd raid5 xor raid1 sata_nv sata_sil libata sd_
mod scsi_mod

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 12
model name      : AMD Athlon(tm) 64 Processor 3400+
stepping        : 0
cpu MHz         : 2411.772
cache size      : 512 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 4828.62
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

[7.3.] Module information (from /proc/modules):

ipv6 268288 10 - Live 0xffffffff881a4000
parport_pc 29992 0 - Live 0xffffffff8819b000
lp 14608 0 - Live 0xffffffff88194000
parport 40588 2 parport_pc,lp, Live 0xffffffff88189000
autofs4 21192 0 - Live 0xffffffff88182000
sunrpc 157240 1 - Live 0xffffffff8815a000
dm_mod 59256 0 - Live 0xffffffff8814a000
video 17288 0 - Live 0xffffffff88144000
hotkey 10760 0 - Live 0xffffffff88140000
button 4736 0 - Live 0xffffffff8813d000
battery 10568 0 - Live 0xffffffff88139000
ac 5576 0 - Live 0xffffffff88136000
ohci_hcd 21380 0 - Live 0xffffffff8812f000
ehci_hcd 33544 0 - Live 0xffffffff88125000
i2c_nforce2 8064 0 - Live 0xffffffff88122000
i2c_core 23704 1 i2c_nforce2, Live 0xffffffff8811b000
snd_intel8x0 35840 0 - Live 0xffffffff88111000
snd_ac97_codec 92056 1 snd_intel8x0, Live 0xffffffff880f9000
snd_pcm_oss 54944 0 - Live 0xffffffff880ea000
snd_mixer_oss 18816 1 snd_pcm_oss, Live 0xffffffff880e4000
snd_pcm 97164 3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss, Live 0xffffffff880cb000
snd_timer 25416 1 snd_pcm, Live 0xffffffff880c3000
snd 58600 6 snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_ti
mer, Live 0xffffffff880b3000
soundcore 10784 1 snd, Live 0xffffffff880af000
snd_page_alloc 11856 2 snd_intel8x0,snd_pcm, Live 0xffffffff880ab000
r8169 30920 0 - Live 0xffffffff880a2000
8139too 28672 0 - Live 0xffffffff8809a000
mii 6336 1 8139too, Live 0xffffffff88097000
floppy 66424 0 - Live 0xffffffff88085000
ext3 135888 3 - Live 0xffffffff88062000
jbd 58160 1 ext3, Live 0xffffffff88052000
raid5 21248 3 - Live 0xffffffff8804b000
xor 6032 1 raid5, Live 0xffffffff88048000
raid1 18240 1 - Live 0xffffffff88042000
sata_nv 10244 8 - Live 0xffffffff8803e000
sata_sil 10628 16 - Live 0xffffffff8803a000
libata 49544 2 sata_nv,sata_sil, Live 0xffffffff8802c000
sd_mod 19288 30 - Live 0xffffffff88026000
scsi_mod 150768 2 libata,sd_mod, Live 0xffffffff88000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0810-0815 : ACPI CPU throttle
0970-0977 : 0000:00:0a.0
  0970-0977 : sata_nv
09f0-09f7 : 0000:00:0a.0
  09f0-09f7 : sata_nv
0b70-0b73 : 0000:00:0a.0
  0b70-0b73 : sata_nv
0bf0-0bf3 : 0000:00:0a.0
  0bf0-0bf3 : sata_nv
0cf8-0cff : PCI conf1
4000-4003 : PM1a_EVT_BLK
4004-4005 : PM1a_CNT_BLK
4008-400b : PM_TMR
401c-401c : PM2_CNT_BLK
4020-4027 : GPE0_BLK
5000-503f : 0000:00:01.1
  5000-5007 : nForce2 SMBus
5040-507f : 0000:00:01.1
  5040-5047 : nForce2 SMBus
5080-509f : 0000:00:01.1
a000-cfff : PCI Bus #02
  ac00-ac0f : 0000:02:0c.0
    ac00-ac0f : sata_sil
  b000-b003 : 0000:02:0c.0
    b000-b003 : sata_sil
  b400-b407 : 0000:02:0c.0
    b400-b407 : sata_sil
  b800-b803 : 0000:02:0c.0
    b800-b803 : sata_sil
  bc00-bc07 : 0000:02:0c.0
    bc00-bc07 : sata_sil
  c000-c0ff : 0000:02:09.0
    c000-c0ff : 8139too
  c400-c4ff : 0000:02:08.0
    c400-c4ff : r8169
  c800-c8ff : 0000:02:07.0
    c800-c8ff : r8169
  cc00-cc7f : 0000:02:0b.0
d000-d00f : 0000:00:0a.0
  d000-d00f : sata_nv
dc00-dc7f : 0000:00:0a.0
  dc00-dc7f : sata_nv
e800-e8ff : 0000:00:06.0
  e800-e8ff : NVidia CK8S
ec00-ec7f : 0000:00:06.0
  ec00-ec7f : NVidia CK8S
ffa0-ffaf : 0000:00:08.0
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf7ff : Video ROM
000cf800-000d3fff : Adapter ROM
000f0000-000fffff : System ROM
00100000-7ffbffff : System RAM
  00100000-00327e95 : Kernel code
  00327e96-003f9cff : Kernel data
7ffc0000-7ffcffff : ACPI Tables
7ffd0000-7fffffff : ACPI Non-volatile Storage
80000000-800fffff : PCI Bus #02
  80000000-8007ffff : 0000:02:0c.0
  80080000-8009ffff : 0000:02:07.0
  800a0000-800bffff : 0000:02:08.0
  800c0000-800cffff : 0000:02:09.0
dc700000-ec6fffff : PCI Bus #01
  dc700000-dc71ffff : 0000:01:00.0
  e0000000-e7ffffff : 0000:01:00.0
f0000000-f7ffffff : 0000:00:00.0
  f0000000-f7ffffff : aperture
fc800000-fe8fffff : PCI Bus #01
  fd000000-fdffffff : 0000:01:00.0
fe900000-feafffff : PCI Bus #02
  feafe800-feafefff : 0000:02:0b.0
  feaff000-feaff3ff : 0000:02:0c.0
    feaff000-feaff3ff : sata_sil
  feaff400-feaff4ff : 0000:02:09.0
    feaff400-feaff4ff : 8139too
  feaff800-feaff8ff : 0000:02:08.0
    feaff800-feaff8ff : r8169
  feaffc00-feaffcff : 0000:02:07.0
    feaffc00-feaffcff : r8169
febfc000-febfcfff : 0000:00:06.0
  febfc000-febfcfff : NVidia CK8S
febfd000-febfdfff : 0000:00:02.0
  febfd000-febfdfff : ohci_hcd
febfe000-febfefff : 0000:00:02.1
  febfe000-febfefff : ohci_hcd
febffc00-febffcff : 0000:00:02.2
  febffc00-febffcff : ehci_hcd
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ff7c0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: nVidia Corporation nForce3 250Gb Host Bridge (rev a1)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 813f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [44] HyperTransport: Slave or Primary Interface
                Command: BaseUnitID=0 UnitCnt=14 MastHost- DefDir- DUL-
                Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
                Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
                Revision ID: 1.03
                Link Frequency 0: 800MHz
                Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ 800MHz+ 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
                Link Frequency 1: 200MHz
                Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
                Prefetchable memory behind bridge Upper: 00-00
                Bus Number: 00
        Capabilities: [c0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x4

00:01.0 ISA bridge: nVidia Corporation nForce3 250Gb LPC Bridge (rev a2)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 813f
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:01.1 SMBus: nVidia Corporation nForce 250Gb PCI System Management (rev a1)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 813f
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at 5080 [size=32]
        Region 4: I/O ports at 5000 [size=64]
        Region 5: I/O ports at 5040 [size=64]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation CK8S USB Controller (rev a1) (prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 813f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 185
        Region 0: Memory at febfd000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation CK8S USB Controller (rev a1) (prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 813f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 209
        Region 0: Memory at febfe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.2 USB Controller: nVidia Corporation nForce3 EHCI USB 2.0 Controller (rev a2) (prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 813f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin C routed to IRQ 217
        Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] Debug port
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce3 250Gb AC'97 Audio Controller (rev a1)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 812a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 209
        Region 0: I/O ports at e800 [size=256]
        Region 1: I/O ports at ec00 [size=128]
        Region 2: Memory at febfc000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 IDE interface: nVidia Corporation CK8S Parallel ATA Controller (v2.5) (rev a2) (prog-if 8a [Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 813f
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at ffa0 [size=16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller (v2.5) (rev a2) (prog-if 85 [Master SecO PriO])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 813f
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 185
        Region 0: I/O ports at 09f0 [size=8]
        Region 1: I/O ports at 0bf0 [size=4]
        Region 2: I/O ports at 0970 [size=8]
        Region 3: I/O ports at 0b70 [size=4]
        Region 4: I/O ports at d000 [size=16]
        Region 5: I/O ports at dc00 [size=128]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 PCI bridge: nVidia Corporation nForce3 250Gb AGP Host to PCI Bridge (rev a2) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=10
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fc800000-fe8fffff
        Prefetchable memory behind bridge: dc700000-ec6fffff
        Secondary status: 66Mhz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:0e.0 PCI bridge: nVidia Corporation nForce3 250Gb PCI-to-PCI Bridge (rev a2) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=128
        I/O behind bridge: 0000a000-0000cfff
        Memory behind bridge: fe900000-feafffff
        Prefetchable memory behind bridge: 80000000-800fffff
        Secondary status: 66Mhz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR+
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] HyperTransport: Host or Secondary Interface
        !!! Possibly incomplete decoding
                Command: WarmRst+ DblEnd-
                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
                Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
                Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1) (prog-if 00 [VGA])
        Subsystem: LeadTek Research Inc.: Unknown device 290a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at dc700000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

02:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max), Cache Line Size 10
        Interrupt: pin A routed to IRQ 201
        Region 0: I/O ports at c800 [size=256]
        Region 1: Memory at feaffc00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 80080000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max), Cache Line Size 10
        Interrupt: pin A routed to IRQ 177
        Region 0: I/O ports at c400 [size=256]
        Region 1: Memory at feaff800 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 800a0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 193
        Region 0: I/O ports at c000 [size=256]
        Region 1: Memory at feaff400 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 800c0000 [disabled] [size=64K]

02:0b.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 808a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at feafe800 (32-bit, non-prefetchable) [size=2K]
        Region 1: I/O ports at cc00 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0c.0 Unknown mass storage controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 8136
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 08
        Interrupt: pin A routed to IRQ 177
        Region 0: I/O ports at bc00 [size=8]
        Region 1: I/O ports at b800 [size=4]
        Region 2: I/O ports at b400 [size=8]
        Region 3: I/O ports at b000 [size=4]
        Region 4: I/O ports at ac00 [size=16]
        Region 5: Memory at feaff000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at 80000000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6B200M0   Rev: BANC
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6B200M0   Rev: BANC
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6B200M0   Rev: BANC
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6B200M0   Rev: BANC
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6B200M0   Rev: BANC
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi5 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6B200M0   Rev: BANC
  Type:   Direct-Access                    ANSI SCSI revision: 05

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

Getting rid of cpu frequency scaling from kernel seems to solve
the problem. Unfortunately, with my very limited kernel knowledge, and 
for what i can remember from CentOS 2.6.9-11.EL and SuSE 2.6.11-24
oopses, none seems to be directly related to cpu frequency scaling.
It doesn't seem to be related to the filesystem used, i've been
able to make it oops with xfs or ext3.
I'd be glad to make some testing, but that box must be in production
in two weeks at worst.
Thanks for reading down to here.
Best Regards,
Laurent Wandrebeck.

