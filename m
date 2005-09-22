Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbVIVNOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbVIVNOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbVIVNOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:14:49 -0400
Received: from ds209-27.ipowerweb.com ([66.235.209.27]:41448 "EHLO
	pluto-la.plutohome.com") by vger.kernel.org with ESMTP
	id S1030318AbVIVNOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:14:48 -0400
Date: Thu, 22 Sep 2005 16:15:18 +0300
From: Radu Cristescu <radu.c@plutohome.com>
X-Mailer: The Bat! (v2.12.00)         CD5BF9353B3B7091
Reply-To: Radu Cristescu <radu.c@plutohome.com>
Organization: Pluto
X-Priority: 3 (Normal)
Message-ID: <1943446884.20050922161518@plutohome.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.12 Oops 0000 while using bluetooth (sometimes: panic)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[-- CC me as I'm not subscribed to the list. Thanks.]

[1.] One line summary of the problem:

  Oops or panic when communicating through bluetooth.

[2.] Full description of the problem/report:

  Computer is stable until using the bluetooth dongle to communicate
  with a mobile phone. While communicating, most of the time it oopses
  (computer still usable) or panics (can't even shift+pgup/pgdown).

  Kernel is 2.6.12 from Debian Sid sources, but problem is probably
  the same in vanilla kernel too.

[3.] Keywords (i.e., modules, networking, kernel):

  bluetooth

[4.] Kernel version (from /proc/version):

  Linux version 2.6.12-pluto-2-default-1-686 (root@dcerouter) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 Thu Sep 22 05:29:23 EDT 2005

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

(taken from syslog)
     
Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
c0244a15
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: rfcomm l2cap videodev hci_usb bluetooth ipt_state iptable_filter ip_nat_irc ip_nat_ftp iptable_nat ip_tables ip_conntrack_irc ip_conntrack_ftp ip_conntrack snd_via82xx gameport snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ipaq usbserial nfsd exportfs lockd sunrpc af_packet capability commoncap ipv6 floppy pcspkr i2c_viapro i2c_core pci_hotplug via_agp agpgart ehci_hcd uhci_hcd usbcore sata_via libata scsi_mod via_rhine e100 mii tsdev mousedev evdev psmouse ide_cd cdrom genrtc ext3 jbd mbcache ide_disk ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage serverworks sc1200 rz1000 piix pdc202xx_old opti621 ns87415 hpt366 hpt34x generic cy82c693 cs5530 cs5520 cmd64x atiixp amd74xx alim15x3 aec62xx pdc202xx_new ide_core unix
CPU:    0
EIP:    0060:[sock_sendmsg+197/256]    Not tainted VLI
EFLAGS: 00010246   (2.6.12-pluto-2-default-1-686)
EIP is at sock_sendmsg+0xc5/0x100
eax: 00000000   ebx: 00000000   ecx: d5ef1020   edx: d4338000
esi: 00000004   edi: d4339ea4   ebp: d4339ddc   esp: d4339d7c
ds: 007b   es: 007b   ss: 0068
Process obex_test (pid: 16708, threadinfo=d4338000 task=d5ef1020)
Stack: d4339dc0 c02b4329 d83b7020 c03a7f50 0000005e d4339dac d83b7020 00000004
       00000000 000000e8 00000000 d4339ea4 d5ef1020 d5ef1148 ffffffff d5ef1020
       00000001 d4339dd0 c02b461f d83b7020 d4339de4 d4339df4 c011666a d83b7020
Call Trace:
 [schedule+921/1600] schedule+0x399/0x640
 [preempt_schedule+79/112] preempt_schedule+0x4f/0x70
 [try_to_wake_up+186/224] try_to_wake_up+0xba/0xe0
 [buffered_rmqueue+224/544] buffered_rmqueue+0xe0/0x220
 [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
 [recalc_task_prio+136/336] recalc_task_prio+0x88/0x150
 [kernel_sendmsg+70/96] kernel_sendmsg+0x46/0x60
 [pg0+546565158/1069741056] rfcomm_send_frame+0x56/0x70 [rfcomm]
 [pg0+546565550/1069741056] rfcomm_send_disc+0x6e/0x80 [rfcomm]
 [pg0+546563509/1069741056] __rfcomm_dlc_close+0xc5/0x100 [rfcomm]
 [pg0+546563603/1069741056] rfcomm_dlc_close+0x23/0x40 [rfcomm]
 [pg0+546575278/1069741056] __rfcomm_sock_close+0x3e/0x60 [rfcomm]
 [pg0+546578672/1069741056] rfcomm_sock_shutdown+0x50/0x80 [rfcomm]
 [local_bh_enable+51/144] local_bh_enable+0x33/0x90
 [pg0+546578761/1069741056] rfcomm_sock_release+0x29/0x80 [rfcomm]
 [sock_release+153/240] sock_release+0x99/0xf0
 [sock_close+52/80] sock_close+0x34/0x50
 [__fput+314/336] __fput+0x13a/0x150
 [filp_close+89/144] filp_close+0x59/0x90
 [sys_close+107/160] sys_close+0x6b/0xa0
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 00 8d 84 24 c0 00 00 00 89 84 24 c0 00 00 00 89 84 24 c4 00 00 00 8d 44 24 10 89 84 24 d4 00 00 00 31 c0 89 44 24 28 89 74 24 1c <8b> 43 08 89 74 24 0c 89 7c 24 08 89 5c 24 04 89 2c 24 ff 50 38

[6.] A small shell script or example program which triggers the
     problem (if possible)

  #!/bin/bash
  MAC="$1" # Mobile phone's MAC
  SIS="$2" # File to upload to phone
  (echo "c"; echo "p"; echo "$SIS PlutoMO.sis"; echo "q") | obex_test -b $MAC 9

# obex_test is a console bluetooth utility found in package
# openobex-apps in Debian. It connects to the phone and, with the
# commands in the subshell, it sends a file to the phone. That's when
# it dies

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux dcerouter 2.6.12-pluto-2-default-1-686 #1 Thu Sep 22 05:25:05 EDT 2005 i686 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
reiserfsprogs          line
reiser4progs           line
PPP                    2.4.3
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         rfcomm l2cap videodev hci_usb bluetooth
ipt_state iptable_filter ip_nat_irc ip_nat_ftp iptable_nat ip_tables ip_conntrack_irc ip_conntrack_ftp ip_conntrack snd_via82xx gameport snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ipaq usbserial nfsd exportfs lockd sunrpc af_packet capability commoncap ipv6 floppy pcspkr i2c_viapro i2c_core pci_hotplug via_agp agpgart ehci_hcd uhci_hcd usbcore sata_via libata scsi_mod via_rhine e100 mii tsdev mousedev evdev psmouse ide_cd cdrom genrtc ext3 jbd mbcache ide_disk ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage serverworks sc1200 rz1000 piix pdc202xx_old opti621 ns87415 hpt366 hpt34x generic cy82c693 cs5530 cs5520 cmd64x atiixp amd74xx alim15x3 aec62xx pdc202xx_new ide_core unix

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 4
cpu MHz         : 2400.443
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4702.20

[7.3.] Module information (from /proc/modules):

rfcomm 41532 0 - Live 0xe0cef000
l2cap 27588 5 rfcomm, Live 0xe0cd9000
videodev 10048 0 - Live 0xe0ccb000
ipt_state 1856 1 - Live 0xe0cc9000
iptable_filter 2944 1 - Live 0xe0ba5000
ip_nat_irc 2656 0 - Live 0xe0a9a000
ip_nat_ftp 3392 0 - Live 0xe09fd000
iptable_nat 23828 3 ip_nat_irc,ip_nat_ftp, Live 0xe0c86000
ip_tables 22688 3 ipt_state,iptable_filter,iptable_nat, Live 0xe0c7f000
ip_conntrack_irc 71984 1 ip_nat_irc, Live 0xe0c63000
ip_conntrack_ftp 72976 1 ip_nat_ftp, Live 0xe0bc5000
ip_conntrack 45656 6 ipt_state,ip_nat_irc,ip_nat_ftp,iptable_nat,ip_conntrack_irc,ip_conntrack_ftp, Live 0xe0c56000
snd_via82xx 29344 1 - Live 0xe0ac4000
gameport 16584 1 snd_via82xx, Live 0xe0b22000
snd_ac97_codec 83320 1 snd_via82xx, Live 0xe0ae3000
snd_pcm_oss 53632 1 - Live 0xe0b13000
snd_mixer_oss 19872 1 snd_pcm_oss, Live 0xe0add000
snd_pcm 96360 3 snd_via82xx,snd_ac97_codec,snd_pcm_oss, Live 0xe0afa000
snd_timer 26180 1 snd_pcm, Live 0xe0ad5000
snd_page_alloc 10020 2 snd_via82xx,snd_pcm, Live 0xe0a56000
snd_mpu401_uart 8160 1 snd_via82xx, Live 0xe0a93000
snd_rawmidi 26208 1 snd_mpu401_uart, Live 0xe0acd000
snd_seq_device 8652 1 snd_rawmidi, Live 0xe0a5a000
snd 58788 9 snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xe0ab1000
soundcore 10528 2 snd, Live 0xe0a8f000
nfsd 222944 8 - Live 0xe0c8d000
exportfs 6432 1 nfsd, Live 0xe0b9f000
lockd 66568 2 nfsd, Live 0xe0bda000
sunrpc 147684 2 nfsd,lockd, Live 0xe0bed000
af_packet 22984 2 - Live 0xe0ba7000
capability 4712 0 - Live 0xe0ac1000
commoncap 6880 1 capability, Live 0xe0a9c000
ipv6 267712 30 - Live 0xe0c13000
floppy 61460 0 - Live 0xe0bb4000
pcspkr 3748 0 - Live 0xe0a96000
i2c_viapro 7984 0 - Live 0xe089d000
i2c_core 22480 1 i2c_viapro, Live 0xe0a5e000
pci_hotplug 31028 0 - Live 0xe0a86000
via_agp 9728 1 - Live 0xe08ef000
agpgart 36424 1 via_agp, Live 0xe0a41000
ehci_hcd 35912 0 - Live 0xe0a4c000
hci_usb 15848 3 - Live 0xe0a16000
bluetooth 52580 9 rfcomm,l2cap,hci_usb, Live 0xe09ef000
uhci_hcd 33744 0 - Live 0xe0a0c000
usbcore 125596 4 ehci_hcd,hci_usb,uhci_hcd, Live 0xe0a66000
sata_via 8644 0 - Live 0xe08f3000
libata 48900 1 sata_via, Live 0xe09ff000
scsi_mod 145928 1 libata, Live 0xe0a1c000
via_rhine 24100 0 - Live 0xe09d7000
e100 38432 0 - Live 0xe09e4000
mii 5536 2 via_rhine,e100, Live 0xe08b7000
tsdev 7872 0 - Live 0xe08b4000
mousedev 12192 1 - Live 0xe08b0000
evdev 9600 0 - Live 0xe08ac000
psmouse 31076 0 - Live 0xe08e6000
ide_cd 43684 0 - Live 0xe08da000
cdrom 41504 1 ide_cd, Live 0xe08ce000
genrtc 10312 0 - Live 0xe08a8000
ext3 145096 2 - Live 0xe08f8000
jbd 63704 1 ext3, Live 0xe08bd000
mbcache 10820 1 ext3, Live 0xe0892000
ide_disk 19072 4 - Live 0xe08a2000
ide_generic 1216 0 [permanent], Live 0xe0890000
via82cxxx 13724 0 [permanent], Live 0xe0896000
trm290 4228 0 [permanent], Live 0xe0886000
triflex 3712 0 [permanent], Live 0xe0874000
slc90e66 6112 0 [permanent], Live 0xe0883000
sis5513 16424 0 [permanent], Live 0xe088a000
siimage 12448 0 [permanent], Live 0xe087e000
serverworks 8840 0 [permanent], Live 0xe087a000
sc1200 7296 0 [permanent], Live 0xe0823000
rz1000 2496 0 [permanent], Live 0xe0841000
piix 10756 0 [permanent], Live 0xe0876000
pdc202xx_old 11296 0 [permanent], Live 0xe0867000
opti621 4772 0 [permanent], Live 0xe0864000
ns87415 4264 0 [permanent], Live 0xe083e000
hpt366 20064 0 [permanent], Live 0xe086b000
hpt34x 5216 0 [permanent], Live 0xe083b000
generic 3904 0 [permanent], Live 0xe0815000
cy82c693 4708 0 [permanent], Live 0xe0838000
cs5530 5568 0 [permanent], Live 0xe0835000
cs5520 4640 0 [permanent], Live 0xe0826000
cmd64x 12028 0 [permanent], Live 0xe0831000
atiixp 6288 0 [permanent], Live 0xe082e000
amd74xx 14428 0 [permanent], Live 0xe0829000
alim15x3 12140 0 [permanent], Live 0xe080d000
aec62xx 7520 0 [permanent], Live 0xe0820000
pdc202xx_new 9024 0 [permanent], Live 0xe0811000
ide_core 129748 28 ide_cd,ide_disk,ide_generic,via82cxxx,trm290,triflex,slc90e66,sis5513,siimage,serverworks,sc1200,rz1000,piix,pdc202xx_old,opti621,ns87415,hpt366,hpt34x,generic,cy82c693,cs5530,cs5520,cmd64x,atiixp,amd74xx,alim15x3,aec62xx,pdc202xx_new, Live 0xe0843000
unix 29296 196 - Live 0xe0817000

[X.] Other notes, patches, fixes, workarounds:

  Debian 2.6.10 worked. About to try vanilla 2.6.12 and 2.6.13.


