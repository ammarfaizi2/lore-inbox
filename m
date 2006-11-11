Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424578AbWKKM3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424578AbWKKM3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 07:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424579AbWKKM3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 07:29:24 -0500
Received: from rosi.naasa.net ([212.8.0.13]:45029 "EHLO rosi.naasa.net")
	by vger.kernel.org with ESMTP id S1424578AbWKKM3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 07:29:23 -0500
From: Joerg Platte <lists@naasa.net>
Reply-To: jplatte@naasa.net
To: linux-kernel@vger.kernel.org
Subject: Re: Userspace process may be able to DoS kernel
Date: Sat, 11 Nov 2006 13:29:16 +0100
User-Agent: KMail/1.9.5
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com> <200611100803.03958.lists@naasa.net> <20061109231958.f18cd1ef.akpm@osdl.org>
In-Reply-To: <20061109231958.f18cd1ef.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611111329.17206.lists@naasa.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 10. November 2006 08:19 schrieb Andrew Morton:

> OK, thanks.
>
> It'd be useful if you could grab a kernel profile when the system load is
> high:

> Or, if oprofile is working:
>
>
> #!/bin/sh
> sudo opcontrol --stop
> sudo opcontrol --shutdown
> sudo rm -rf /var/lib/oprofile
> sudo opcontrol --vmlinux=/boot/vmlinux-$(uname -r)
> sudo opcontrol --start-daemon
> sudo opcontrol --start
> sleep 10
> sudo opcontrol --stop
> sudo opcontrol --shutdown
> sudo opreport -l /boot/vmlinux-$(uname -r) | head -50

Here is the oprofile log. Seems to be acpi related?

CPU: CPU with timer interrupt, speed 0 MHz (estimated)
Profiling through timer interrupt
samples  %        symbol name
709      44.2848  acpi_pm_read
232      14.4909  schedule
164      10.2436  system_call
61        3.8101  __wake_up
48        2.9981  __copy_to_user_ll
42        2.6234  do_futex
29        1.8114  futex_wake
29        1.8114  sys_futex
26        1.6240  hash_futex
25        1.5615  getnstimeofday
20        1.2492  preempt_schedule
20        1.2492  sys_clock_gettime
18        1.1243  copy_to_user
17        1.0618  __copy_from_user_ll
17        1.0618  get_futex_key
16        0.9994  futex_requeue
15        0.9369  schedule_timeout
11        0.6871  __mod_timer
9         0.5621  do_gettimeofday
9         0.5621  sys_ioctl
9         0.5621  syscall_exit
8         0.4997  fget_light
7         0.4372  find_extend_vma
6         0.3748  find_vma
5         0.3123  copy_from_user
5         0.3123  lock_timer_base
5         0.3123  sys_gettimeofday
4         0.2498  do_ioctl
4         0.2498  up_read
4         0.2498  vfs_ioctl
4         0.2498  wake_futex
3         0.1874  add_wait_queue
3         0.1874  down_read
2         0.1249  memcpy
2         0.1249  profile_hit
1         0.0625  csum_partial
1         0.0625  do_page_fault
1         0.0625  dummy_file_ioctl
1         0.0625  fput
1         0.0625  handle_IRQ_event
1         0.0625  ip_append_data
1         0.0625  memcmp
1         0.0625  netif_receive_skb
1         0.0625  permission
1         0.0625  sched_clock
1         0.0625  syscall_call
1         0.0625  unmap_vmas


I captured this on my IBM Thinkpad T40p. Here is the system configuration:

Linux ibm 2.6.19-rc5 #1 PREEMPT Wed Nov 8 08:06:17 CET 2006 i686 GNU/Linux

Module                  Size  Used by
sg                     32156  0
sr_mod                 14820  0
lt_hotswap             10888  0
oprofile               18400  1
radeon                109728  2
drm                    69524  3 radeon
binfmt_misc            10696  1
ieee80211_crypt_ccmp     6912  3
cpufreq_userspace       3860  0
cpufreq_powersave       1792  0
rfcomm                 34716  1
l2cap                  21700  5 rfcomm
bluetooth              47780  4 rfcomm,l2cap
nfs                   210280  0
nfsd                  198320  17
exportfs                5440  1 nfsd
lockd                  57480  3 nfs,nfsd
sunrpc                146108  12 nfs,nfsd,lockd
nsc_ircc               17296  0
uinput                  8704  1
af_packet              19848  6
autofs4                19588  2
video                  15172  0
sbs                    14496  0
i2c_ec                  4928  1 sbs
dock                    7240  0
button                  6544  0
container               4352  0
ac                      5060  0
battery                 9860  0
ipt_MASQUERADE          3328  3
iptable_nat             6724  1
ip_nat                 17004  2 ipt_MASQUERADE,iptable_nat
xt_state                2112  9
ipt_LOG                 6080  8
xt_limit                2624  8
ipt_REJECT              4288  2
xt_mark                 1856  2
xt_tcpudp               2880  10
xt_mac                  1856  29
iptable_filter          2880  1
xt_MARK                 2240  3
xt_multiport            3008  8
iptable_mangle          2752  1
ip_tables              12552  3 iptable_nat,iptable_filter,iptable_mangle
x_tables               14276  12 
ipt_MASQUERADE,iptable_nat,xt_state,ipt_LOG,xt_limit,ipt_REJECT,xt_mark,xt_tcpudp,xt_mac,xt_MARK,xt_multiport,ip_tables
ip_conntrack_ftp        7376  0
ip_conntrack           48524  5 
ipt_MASQUERADE,iptable_nat,ip_nat,xt_state,ip_conntrack_ftp
nfnetlink               6360  2 ip_nat,ip_conntrack
deflate                 3712  0
zlib_deflate           18072  1 deflate
zlib_inflate           13632  1 deflate
twofish                 8384  0
twofish_common         35904  1 twofish
serpent                18816  0
aes                    27968  3
blowfish                9280  0
des                    17344  0
cbc                     4288  0
ecb                     3456  0
blkcipher               5504  2 cbc,ecb
sha256                 11008  0
sha1                    2560  0
crypto_null             2496  0
af_key                 31696  2
nls_utf8                2048  1
ntfs                   92788  1
nls_base                7168  2 nls_utf8,ntfs
ext2                   59464  1
dm_snapshot            15328  0
dm_mirror              17936  0
dm_mod                 50520  2 dm_snapshot,dm_mirror
deadline_iosched        5440  0
as_iosched             12616  1
cfq_iosched            16208  1
cdc_acm                14048  0
capability              4744  0
commoncap               6848  1 capability
ircomm_tty             22664  0
ircomm                 13060  1 ircomm_tty
tun                    10368  1
nvram                   8072  1
ibm_acpi               25792  0
sd_mod                 18576  0
8250_pci               19904  0
irtty_sir               6016  0
sir_dev                13956  1 irtty_sir
joydev                  9024  0
snd_intel8x0m          16524  4
snd_seq_oss            28992  0
snd_seq_midi            8160  0
snd_rawmidi            22432  1 snd_seq_midi
snd_seq_midi_event      6784  2 snd_seq_oss,snd_seq_midi
snd_seq                44688  5 snd_seq_oss,snd_seq_midi,snd_seq_midi_event
tsdev                   7424  0
snd_intel8x0           31004  2
snd_ac97_codec         89188  2 snd_intel8x0m,snd_intel8x0
snd_ac97_bus            2240  1 snd_ac97_codec
usb_storage            56576  0
snd_pcm_oss            38432  0
snd_mixer_oss          15424  1 snd_pcm_oss
snd_seq_device          7628  4 snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
ipw2200               136584  0
libusual               16016  1 usb_storage
snd_pcm                71048  6 
snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              20676  2 snd_seq,snd_pcm
yenta_socket           24780  2
rsrc_nonstatic         12032  1 yenta_socket
pcmcia                 34788  0
psmouse                34376  0
irda                  106040  4 nsc_ircc,ircomm_tty,ircomm,sir_dev
i2c_i801                7308  0
usbhid                 47008  0
8250_pnp                9088  0
8250                   20004  2 8250_pci,8250_pnp
serial_core            19584  1 8250
ieee80211              29832  1 ipw2200
ieee80211_crypt         5824  2 ieee80211_crypt_ccmp,ieee80211
parport_pc             35940  0
parport                33288  1 parport_pc
iTCO_wdt               10016  0
pcspkr                  2816  0
evdev                   9152  3
intel_agp              22236  1
agpgart                29744  2 drm,intel_agp
serio_raw               6468  0
crc_ccitt               2112  1 irda
snd                    47972  21 
snd_intel8x0m,snd_seq_oss,snd_rawmidi,snd_seq,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_seq_device,snd_pcm,snd_timer
soundcore               7776  1 snd
snd_page_alloc          9608  3 snd_intel8x0m,snd_intel8x0,snd_pcm
ff_memless              5128  1 usbhid
rtc                    12340  0
pcmcia_core            37520  3 yenta_socket,rsrc_nonstatic,pcmcia
firmware_class          9664  2 ipw2200,pcmcia
ext3                  120904  2
jbd                    53736  1 ext3
mbcache                 8324  2 ext2,ext3
ide_cd                 36192  0
cdrom                  32992  2 sr_mod,ide_cd
ide_disk               15232  6
ata_piix               15368  0
libata                 96276  1 ata_piix
scsi_mod              128588  5 sg,sr_mod,sd_mod,usb_storage,libata
piix                    9156  0 [permanent]
uhci_hcd               21256  0
ehci_hcd               27976  0
usbcore               121924  7 
cdc_acm,usb_storage,libusual,usbhid,uhci_hcd,ehci_hcd
generic                 5316  0 [permanent]
ide_core              109532  6 
lt_hotswap,usb_storage,ide_cd,ide_disk,piix,generic
e1000                 108672  0
thermal                13640  0
fan                     4612  0
unix                   25328  1098
cpufreq_conservative     6368  0
cpufreq_ondemand        7168  1
speedstep_centrino      7120  1
freq_table              4292  2 cpufreq_ondemand,speedstep_centrino
processor              23276  2 thermal,speedstep_centrino
fbcon                  38304  73
tileblit                2496  1 fbcon
crc32                   4288  3 tun,pcmcia,fbcon
font                    8256  1 fbcon
bitblit                 5120  1 fbcon
softcursor              2240  1 bitblit
radeonfb               94144  1
fb                     43688  5 fbcon,tileblit,bitblit,softcursor,radeonfb
fb_ddc                  2560  1 radeonfb
i2c_algo_bit            7560  1 radeonfb
i2c_core               20688  4 i2c_ec,i2c_i801,fb_ddc,i2c_algo_bit
cfbcopyarea             3520  1 radeonfb
cfbimgblt               2816  1 radeonfb
cfbfillrect             3520  1 radeonfb


00:00.0 Host bridge: Intel Corporation 82855PM Processor to I/O Controller 
(rev 03)
00:01.0 PCI bridge: Intel Corporation 82855PM Processor to AGP Controller (rev 
03)
00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #3 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI 
Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface Bridge 
(rev 01)
00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller (rev 
01)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus 
Controller (rev 01)
00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 
Modem Controller (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 [Mobility 
FireGL 9000] (rev 02)
02:00.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus Controller 
(rev 01)
02:00.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus Controller 
(rev 01)
02:01.0 Ethernet controller: Intel Corporation 82540EP Gigabit Ethernet 
Controller (Mobile) (rev 03)
02:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG Network 
Connection (rev 05)

regards,
Jörg
