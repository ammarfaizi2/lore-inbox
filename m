Return-Path: <linux-kernel-owner+w=401wt.eu-S1030179AbXAMLwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbXAMLwi (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 06:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030507AbXAMLwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 06:52:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:38275 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030179AbXAMLwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 06:52:36 -0500
X-Authenticated: #1747610
From: Frank Hartmann <soundart@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.19.1 Oops while doing Disk IO + playing sound
Date: Sat, 13 Jan 2007 12:55:07 +0100
Message-ID: <877ivr6t0k.fsf@fantasio.hh.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

2.6.19.1 Oops while doing Disk IO + playing sound

[2.] Full description of the problem/report:

I found two Oopses recently, both occured running 2.6.19.1 

I did not have Oopses using 2.6.17 and my usage pattern of this
machine does not change much.

on  7th of january I made a disk backup from ide to USB harddisk & played audio
on 13th of january I compiled 2.6.19.2 and played audio

All involved filesystems use ext3 


I have no clue how to distinguish if this is a hardware problem
(disk/memory) or a software issue. Not encountered this using 2.6.17
makes me wonder.

I did run memtest for 2 days around November, but will retry this soon.

Not knowing what do next I decided do send this email. Please CC me as
I am currently following linux.kernel via nntp which seems to have
some strange delays sometimes.

I used a template I found in Documentation so I hope that enough
information is included.

kind regards
  Frank
  


----------------------------------------------------------------------

[3.] Keywords (i.e., modules, networking, kernel):

ext3, audio, Oops

[4.] Kernel version (from /proc/version):

fantasio:~/tmp/linux-2.6.19.1$ cat /proc/version 
Linux version 2.6.19.1 (frank@fantasio) (gcc version 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)) #1 PREEMPT Fri Dec 29 13:40:23 CET 2006


[5.] Most recent kernel version which did not have the bug:

2.6.17

[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

## Sound + compile linux-kernel


BUG: unable to handle kernel NULL pointer dereference at virtual address 0000002
9
 printing eip:
e0c25de0
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: cbc blkcipher binfmt_misc rfcomm l2cap nfs nfsd exportfs lock
d sunrpc ip_nat_irc ip_nat_ftp ip_conntrack_irc ip_conntrack_ftp xt_state ipt_RE
JECT ipt_LOG iptable_mangle iptable_filter iptable_nat ip_nat ip_tables ip_connt
rack cryptoloop loop sha256 aes it87 hwmon_vid i2c_isa i2c_core md5 ipv6 af_pack
et radeon drm sd_mod dm_crypt dm_mod snd_via82xx snd_ac97_codec snd_ac97_bus snd
_pcm_oss snd_mixer_oss analog gameport snd_pcm snd_timer snd_page_alloc snd_mpu4
01_uart snd_rawmidi usb_storage 8250_pnp 8250 serial_core rtc snd soundcore pris
m54 usbhid via_agp agpgart firmware_class evdev ext3 jbd mbcache raid1 raid0 mul
tipath linear md_mod ide_cd cdrom ide_disk ehci_hcd uhci_hcd usbcore via_rhine m
ii via82cxxx ide_core sym53c8xx scsi_transport_spi scsi_mod unix
CPU:    0
EIP:    0060:[<e0c25de0>]    Not tainted VLI
EFLAGS: 00010202   (2.6.19.1 #1)
EIP is at journal_grab_journal_head+0xd/0x36 [jbd]
eax: dfd54000   ebx: 00000029   ecx: 000000d0   edx: 00000029
esi: c12ae6e0   edi: 00000000   ebp: c09576ec   esp: dfd55dfc
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 132, ti=dfd54000 task=dff98590 task.ti=dfd54000)
Stack: 00000029 e0c215ca 00000246 c09579c4 c28b44b8 c11717a0 00000001 e0c5559a 
       000000d0 00000001 c02c2d00 c0134758 c12ae6e0 c28b430c c0139da9 dfd55f1c 
       00000014 dfd55f80 00000020 00000000 00000000 00000020 0000000b 00000001 
Call Trace:
 [<e0c215ca>] journal_try_to_free_buffers+0x5e/0x13d [jbd]
 [<e0c5559a>] ext3_releasepage+0x0/0x72 [ext3]
 [<c0134758>] try_to_release_page+0x34/0x46
 [<c0139da9>] shrink_inactive_list+0x468/0x6f4
 [<c0138b2a>] __pagevec_release+0x15/0x1d
 [<c01397f7>] shrink_active_list+0x386/0x38e
 [<c013a0e9>] shrink_zone+0xb4/0xd5
 [<c013a570>] kswapd+0x288/0x38f
 [<c0125eea>] autoremove_wake_function+0x0/0x35
 [<c013a2e8>] kswapd+0x0/0x38f
 [<c0125e31>] kthread+0xad/0xd8
 [<c0125d84>] kthread+0x0/0xd8
 [<c010379f>] kernel_thread_helper+0x7/0x10
 =======================
Code: 04 00 74 03 83 0a 04 89 e0 25 00 e0 ff ff ff 48 14 8b 40 08 a8 08 74 05 e9
 c9 ab 64 df c3 53 89 c2 89 e0 25 00 e0 ff ff ff 40 14 <8b> 02 31 db f6 c4 40 74
 06 8b 5a 20 ff 43 04 89 e0 25 00 e0 ff 
EIP: [<e0c25de0>] journal_grab_journal_head+0xd/0x36 [jbd] SS:ESP 0068:dfd55dfc
 <6>note: kswapd0[132] exited with preempt_count 1



##
## sound + backup from ide to USB
##

Jan  7 20:03:52 fantasio kernel: Oops: 0000 [#1]
Jan  7 20:03:52 fantasio kernel: PREEMPT 
Jan  7 20:03:52 fantasio kernel: Modules linked in: cbc blkcipher sd_mod visor usbserial binfmt_misc rfcomm l2cap nfs nfsd exportfs lockd sunrpc ip_nat_irc ip_nat_ftp ip_conntrack_irc ip_conntrack_ftp xt_state 
ipt_REJECT ipt_LOG iptable_mangle iptable_filter iptable_nat ip_nat ip_tables ip_conntrack cryptoloop loop sha256 aes it87 hwmon_vid i2c_isa i2c_core md5 ipv6 af_packet usb_storage radeon drm dm_crypt dm_mod sn
d_via82xx snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi analog gameport 8250_pnp 8250 serial_core rtc snd prism54 via_agp soundcore agpgart f
irmware_class evdev ext3 jbd mbcache raid1 raid0 multipath linear md_mod ide_cd cdrom ide_disk usbhid via_rhine mii via82cxxx ide_core ehci_hcd uhci_hcd usbcore sym53c8xx scsi_transport_spi scsi_mod unix
Jan  7 20:03:52 fantasio kernel: CPU:    0
Jan  7 20:03:52 fantasio kernel: EIP:    0060:[pg0+546304086/1070171136]    Not tainted VLI
Jan  7 20:03:52 fantasio kernel: EFLAGS: 00010206   (2.6.19.1 #1)
Jan  7 20:03:52 fantasio kernel: EIP is at walk_page_buffers+0x1c/0x7e [ext3]
Jan  7 20:03:52 fantasio kernel: eax: 00004000   ebx: 00004023   ecx: 00000000   edx: 00001001
Jan  7 20:03:52 fantasio kernel: esi: 00003000   edi: c54976ec   ebp: 00001000   esp: d13b7e24
Jan  7 20:03:52 fantasio kernel: ds: 007b   es: 007b   ss: 0068
Jan  7 20:03:52 fantasio kernel: Process pdflush (pid: 12292, ti=d13b6000 task=d42a0550 task.ti=d13b6000)
Jan  7 20:03:52 fantasio kernel: Stack: 00000000 df1783d8 00004023 c125d100 df1783d8 c54976ec df1783d8 e0c67bf8 
Jan  7 20:03:52 fantasio kernel:        00001000 00000000 e0c650b8 00000000 c125d100 d13b7f70 c125d100 00000007 
Jan  7 20:03:52 fantasio kernel:        00000000 d13b7f70 c01373fc 00000000 0000000e c9181664 0000000e c15cd1ac 
Jan  7 20:03:52 fantasio kernel: Call Trace:
Jan  7 20:03:52 fantasio kernel:  [pg0+546315256/1070171136] ext3_ordered_writepage+0xd7/0x194 [ext3]
Jan  7 20:03:52 fantasio kernel:  [pg0+546304184/1070171136] bget_one+0x0/0x6 [ext3]
Jan  7 20:03:52 fantasio kernel:  [generic_writepages+375/682] generic_writepages+0x177/0x2aa
Jan  7 20:03:52 fantasio kernel:  [pg0+546315041/1070171136] ext3_ordered_writepage+0x0/0x194 [ext3]
Jan  7 20:03:52 fantasio kernel:  [do_writepages+41/48] do_writepages+0x29/0x30
Jan  7 20:03:52 fantasio kernel:  [__writeback_single_inode+414/811] __writeback_single_inode+0x19e/0x32b
Jan  7 20:03:52 fantasio kernel:  [schedule_timeout+140/160] schedule_timeout+0x8c/0xa0
Jan  7 20:03:52 fantasio kernel:  [process_timeout+0/5] process_timeout+0x0/0x5
Jan  7 20:03:52 fantasio kernel:  [sync_sb_inodes+348/529] sync_sb_inodes+0x15c/0x211
Jan  7 20:03:52 fantasio kernel:  [writeback_inodes+103/206] writeback_inodes+0x67/0xce
Jan  7 20:03:52 fantasio kernel:  [background_writeout+99/142] background_writeout+0x63/0x8e
Jan  7 20:03:52 fantasio kernel:  [pdflush+0/431] pdflush+0x0/0x1af
Jan  7 20:03:52 fantasio kernel:  [pdflush+267/431] pdflush+0x10b/0x1af
Jan  7 20:03:52 fantasio kernel:  [background_writeout+0/142] background_writeout+0x0/0x8e
Jan  7 20:03:52 fantasio kernel:  [kthread+173/216] kthread+0xad/0xd8
Jan  7 20:03:52 fantasio kernel:  [kthread+0/216] kthread+0x0/0xd8
Jan  7 20:03:52 fantasio kernel:  [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
Jan  7 20:03:52 fantasio kernel:  =======================
Jan  7 20:03:52 fantasio kernel: Code: 41 04 3b 02 74 f0 31 c0 39 d9 5b 0f 97 c0 c3 55 57 89 d7 56 31 f6 53 89 d3 83 ec 0c 89 44 24 04 89 0c 24 8b 6a 10 01 ee 3b 34 24 <8b> 43 04 89 f2 89 44 24 08 0f 96 c0 29 e
a 3b 54 24 20 0f 93 c2 
Jan  7 20:03:52 fantasio kernel: EIP: [pg0+546304086/1070171136] walk_page_buffers+0x1c/0x7e [ext3] SS:ESP 0068:d13b7e24

[7.] A small shell script or example program which triggers the
     problem (if possible)

NA

[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)
fantasio:~/tmp/linux-2.6.19.1$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux fantasio 2.6.19.1 #1 PREEMPT Fri Dec 29 13:40:23 CET 2006 i686 GNU/Linux
 
Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.3-pre2
e2fsprogs              1.40-WIP
jfsutils               1.1.11
reiserfsprogs          3.6.19
PPP                    2.4.4
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
udev                   103
Modules Loaded         cbc blkcipher binfmt_misc rfcomm l2cap nfs nfsd exportfs 
lockd sunrpc ip_nat_irc ip_nat_ftp ip_conntrack_irc ip_conntrack_ftp xt_state ip
t_REJECT ipt_LOG iptable_mangle iptable_filter iptable_nat ip_nat ip_tables ip_c
onntrack cryptoloop loop sha256 aes it87 hwmon_vid i2c_isa i2c_core md5 ipv6 af_
packet radeon drm sd_mod dm_crypt dm_mod snd_via82xx snd_ac97_codec snd_ac97_bus
 snd_pcm_oss snd_mixer_oss analog gameport snd_pcm snd_timer snd_page_alloc snd_
mpu401_uart snd_rawmidi usb_storage 8250_pnp 8250 serial_core rtc snd soundcore 
prism54 usbhid via_agp agpgart firmware_class evdev ext3 jbd mbcache raid1 raid0
 multipath linear md_mod ide_cd cdrom ide_disk ehci_hcd uhci_hcd usbcore via_rhi
ne mii via82cxxx ide_core sym53c8xx scsi_transport_spi scsi_mod unix

[8.2.] Processor information (from /proc/cpuinfo):
fantasio:~/tmp/linux-2.6.19.1$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2000+
stepping        : 1
cpu MHz         : 1668.750
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow ts
bogomips        : 3340.67

[8.3.] Module information (from /proc/modules):
fantasio:~/tmp/linux-2.6.19.1$ cat /proc/modules 
cbc 4480 0 - Live 0xe0ee9000
blkcipher 5376 1 cbc, Live 0xe0ee6000
binfmt_misc 10696 1 - Live 0xe0edd000
rfcomm 34908 1 - Live 0xe0e51000
l2cap 22020 5 rfcomm, Live 0xe0e6b000
nfs 112060 1 - Live 0xe0f26000
nfsd 88104 13 - Live 0xe0eed000
exportfs 5568 1 nfsd, Live 0xe0e48000
lockd 58120 3 nfs,nfsd, Live 0xe0e5b000
sunrpc 146300 10 nfs,nfsd,lockd, Live 0xe0ead000
ip_nat_irc 2560 0 - Live 0xe0e46000
ip_nat_ftp 3264 0 - Live 0xe0de7000
ip_conntrack_irc 6736 1 ip_nat_irc, Live 0xe0e43000
ip_conntrack_ftp 7120 1 ip_nat_ftp, Live 0xe0e35000
xt_state 2112 12 - Live 0xe0e17000
ipt_REJECT 4352 2 - Live 0xe0e38000
ipt_LOG 6144 1 - Live 0xe0d2c000
iptable_mangle 2752 0 - Live 0xe0d2f000
iptable_filter 2944 1 - Live 0xe0cfb000
iptable_nat 6788 0 - Live 0xe0dc2000
ip_nat 16236 3 ip_nat_irc,ip_nat_ftp,iptable_nat, Live 0xe0dfc000
ip_tables 12744 3 iptable_mangle,iptable_filter,iptable_nat, Live 0xe0de2000
ip_conntrack 43628 7 ip_nat_irc,ip_nat_ftp,ip_conntrack_irc,ip_conntrack_ftp,xt_state,iptable_nat,ip_nat, Live 0xe0e0b000
cryptoloop 3008 0 - Live 0xe0bfe000
loop 15432 2 cryptoloop, Live 0xe0d32000
sha256 11136 0 - Live 0xe0cec000
aes 27968 0 - Live 0xe0dda000
it87 21804 0 - Live 0xe0dd3000
hwmon_vid 2624 1 it87, Live 0xe0c0c000
i2c_isa 5184 1 it87, Live 0xe0cf8000
i2c_core 20816 2 it87,i2c_isa, Live 0xe0dbb000
md5 4032 0 - Live 0xe0806000
ipv6 220512 26 - Live 0xe0e76000
af_packet 20040 2 - Live 0xe0db5000
radeon 109600 3 - Live 0xe0e19000
drm 69908 4 radeon, Live 0xe0de9000
sd_mod 18704 0 - Live 0xe0c7a000
dm_crypt 12168 0 - Live 0xe0ccc000
dm_mod 50776 1 dm_crypt, Live 0xe0dc5000
snd_via82xx 26584 3 - Live 0xe0cf0000
snd_ac97_codec 87520 1 snd_via82xx, Live 0xe0d38000
snd_ac97_bus 2240 1 snd_ac97_codec, Live 0xe087e000
snd_pcm_oss 38944 0 - Live 0xe0d10000
snd_mixer_oss 15552 1 snd_pcm_oss, Live 0xe0cc7000
analog 10528 0 - Live 0xe0cc3000
gameport 14408 2 snd_via82xx,analog, Live 0xe0c32000
snd_pcm 70408 4 snd_via82xx,snd_ac97_codec,snd_pcm_oss, Live 0xe0cfd000
snd_timer 20740 1 snd_pcm, Live 0xe0ce0000
snd_page_alloc 9608 2 snd_via82xx,snd_pcm, Live 0xe0c76000
snd_mpu401_uart 7744 1 snd_via82xx, Live 0xe0c73000
snd_rawmidi 22368 1 snd_mpu401_uart, Live 0xe0cbc000
usb_storage 54848 0 - Live 0xe0cd1000
8250_pnp 9152 0 - Live 0xe0c37000
8250 20836 1 8250_pnp, Live 0xe0c6c000
serial_core 19712 1 8250, Live 0xe0c4a000
rtc 12468 0 - Live 0xe0c45000
snd 48228 13 snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi, Live 0xe0caf000
soundcore 7776 1 snd, Live 0xe0c2f000
prism54 51592 0 - Live 0xe0ca1000
usbhid 36000 0 - Live 0xe0c3b000
via_agp 9600 1 - Live 0xe0bc2000
agpgart 29744 2 drm,via_agp, Live 0xe0c03000
firmware_class 9792 1 prism54, Live 0xe0819000
evdev 9216 1 - Live 0xe0bbe000
ext3 108808 2 - Live 0xe0c50000
jbd 53800 1 ext3, Live 0xe0c20000
mbcache 8260 1 ext3, Live 0xe0bba000
raid1 20480 0 - Live 0xe0bd0000
raid0 7360 0 - Live 0xe087b000
multipath 8448 0 - Live 0xe0837000
linear 5312 0 - Live 0xe0834000
md_mod 67732 4 raid1,raid0,multipath,linear, Live 0xe0c0e000
ide_cd 36192 0 - Live 0xe0bc6000
cdrom 33248 1 ide_cd, Live 0xe0848000
ide_disk 15168 3 - Live 0xe0843000
ehci_hcd 38472 0 - Live 0xe0baf000
uhci_hcd 30092 0 - Live 0xe0872000
usbcore 131844 5 usb_storage,usbhid,ehci_hcd,uhci_hcd, Live 0xe0bd7000
via_rhine 22408 0 - Live 0xe083c000
mii 5312 1 via_rhine, Live 0xe0831000
via82cxxx 8452 0 [permanent], Live 0xe081d000
ide_core 109340 4 usb_storage,ide_cd,ide_disk,via82cxxx, Live 0xe0b93000
sym53c8xx 68244 0 - Live 0xe0b81000
scsi_transport_spi 22848 1 sym53c8xx, Live 0xe082a000
scsi_mod 126920 4 sd_mod,usb_storage,sym53c8xx,scsi_transport_spi, Live 0xe0852000
unix 25584 698 - Live 0xe0822000

[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
fantasio:~/tmp/linux-2.6.19.1$ cat /proc/ioports 
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
0170-0177 : ide1
01f0-01f7 : ide0
0290-0297 : it87-isa
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-407f : 0000:00:11.0
  4000-4003 : ACPI PM1a_EVT_BLK
  4004-4005 : ACPI PM1a_CNT_BLK
  4008-400b : ACPI PM_TMR
  4010-4015 : ACPI CPU throttle
  4020-4023 : ACPI GPE0_BLK
5000-500f : 0000:00:11.0
c000-cfff : PCI Bus #01
  c000-c0ff : 0000:01:00.0
d000-d0ff : 0000:00:0b.0
  d000-d0ff : sym53c8xx
d400-d41f : 0000:00:10.0
  d400-d41f : uhci_hcd
d800-d81f : 0000:00:10.1
  d800-d81f : uhci_hcd
dc00-dc1f : 0000:00:10.2
  dc00-dc1f : uhci_hcd
e000-e00f : 0000:00:11.1
  e000-e007 : ide0
  e008-e00f : ide1
e400-e4ff : 0000:00:11.5
  e400-e4ff : VIA8233
e800-e8ff : 0000:00:12.0
  e800-e8ff : via-rhine

fantasio:~/tmp/linux-2.6.19.1$ cat /proc/iomem 
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ccfff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-00272dc9 : Kernel code
  00272dca-002fe04f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d7ffffff : 0000:00:00.0
d8000000-e7ffffff : PCI Bus #01
  d8000000-dfffffff : 0000:01:00.0
    d8000000-dfffffff : vesafb
  e0000000-e7ffffff : 0000:01:00.1
e8000000-e80fffff : PCI Bus #01
  e8000000-e801ffff : 0000:01:00.0
  e8020000-e802ffff : 0000:01:00.0
  e8030000-e803ffff : 0000:01:00.1
e8100000-e8101fff : 0000:00:09.0
  e8100000-e8101fff : prism54
e8102000-e81020ff : 0000:00:0b.0
  e8102000-e81020ff : sym53c8xx
e8103000-e81030ff : 0000:00:10.3
  e8103000-e81030ff : ehci_hcd
e8104000-e81040ff : 0000:00:12.0
  e8104000-e81040ff : via-rhine
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


[8.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge
	Subsystem: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [80] AGP version 3.5
		Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4,x8
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e8000000-e80fffff
	Prefetchable memory behind bridge: d8000000-e7ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Network controller: Intersil Corporation ISL3890 [Prism GT/Prism Duette]/ISL3886 [Prism Javelin/Prism Xbow] (rev 01)
	Subsystem: Standard Microsystems Corp [SMC] SMC2802W Wireless PCI Adapter
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 (2500ns min, 7000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at e8100000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 VGA compatible unclassified device: LSI Logic / Symbios Logic 53c810 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at d000 [size=256]
	Region 1: Memory at e8102000 (32-bit, non-prefetchable) [size=256]

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 19
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin C routed to IRQ 19
	Region 4: I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a239
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at e8103000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: VIA Technologies, Inc. VT8235 ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device a239
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 17
	Region 4: I/O ports at e000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer Unknown device c061
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 21
	Region 0: I/O ports at e400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
	Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded Ethernet Controller on VT8235
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at e8104000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 PRO] (rev 01) (prog-if 00 [VGA])
	Subsystem: Hightech Information System Ltd. Unknown device 2020
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at e8020000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at e8000000 [disabled] [size=128K]
	Capabilities: [58] AGP version 3.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 PRO] (Secondary) (rev 01)
	Subsystem: Hightech Information System Ltd. Unknown device 2021
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at e0000000 (32-bit, prefetchable) [disabled] [size=128M]
	Region 1: Memory at e8030000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



[8.6.] SCSI information (from /proc/scsi/scsi)

USB backup harddisk not attached now! I think it has some SCSI name.

fantasio:~/tmp/linux-2.6.19.1$ cat /proc/scsi/scsi

Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: Generic  Model: STORAGE DEVICE   Rev: 0128
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 01
  Vendor: Generic  Model: STORAGE DEVICE   Rev: 0128
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 02
  Vendor: Generic  Model: STORAGE DEVICE   Rev: 0128
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 03
  Vendor: Generic  Model: STORAGE DEVICE   Rev: 0128
  Type:   Direct-Access                    ANSI SCSI revision: 02

[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

fantasio:~/tmp/linux-2.6.19.1$ mount
/dev/hda1 on / type ext3 (rw,errors=remount-ro)
tmpfs on /lib/init/rw type tmpfs (rw,nosuid,mode=0755)
proc on /proc type proc (rw,noexec,nosuid,nodev)
sysfs on /sys type sysfs (rw,noexec,nosuid,nodev)
procbususb on /proc/bus/usb type usbfs (rw)
udev on /dev type tmpfs (rw,mode=0755)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)
devpts on /dev/pts type devpts (rw,noexec,nosuid,gid=5,mode=620)
/dev/hda2 on /mnt/hdd2 type ext3 (rw,user_xattr)
nfsd on /proc/fs/nfsd type nfsd (rw)
rpc_pipefs on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
localhost:/var/lib/cfs/.cfsfs on /var/cfs type nfs (rw,port=3049,intr,nfsvers=2,addr=127.0.0.1)
binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
