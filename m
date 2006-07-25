Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWGYLDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWGYLDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 07:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWGYLDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 07:03:36 -0400
Received: from dns.communicationvalley.it ([194.246.127.2]:35478 "EHLO
	sv-mai-cv-01.communicationvalley.it") by vger.kernel.org with ESMTP
	id S932171AbWGYLDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 07:03:35 -0400
X-Qmail-Scanner-Mail-From: biker@villagepeople.it via sv-mai-cv-01
X-Qmail-Scanner: 1.25st (Clear:RC:1(192.168.33.179):. Processed in 0.164989 secs Process 8165)
From: Biker <biker@villagepeople.it>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] in Process kthread
Date: Tue, 25 Jul 2006 13:02:49 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bpfxEx+jt491PEh"
Message-Id: <200607251302.51133.biker@villagepeople.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_bpfxEx+jt491PEh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello list,
I get the oops below on my Thinkpad after leaving it on for a day or two. I 
haven't found a way to trigger it yet: after the OOPS the machine still 
works, but it usually locks up during shutdown. The kernel is not tainted and 
the only non-vanilla driver I'm using is the ipw2100 for the wireless 
card .I've tested the RAM with memtest86+ and everything seems to be ok. This 
has happened since at least 2.6.15.

Please CC: me on all replies, I'm not subscribed to the list.
Let me know if you need any other info and what I can do to track down the 
problem. Kernel config is compressed and attached.

Thanks for your attention,
Silla Rizzoli


BUG: unable to handle kernel NULL pointer dereference at virtual address 
00000000
 printing eip:
c01012e4
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: vfat fat sd_mod usb_storage scsi_mod michael_mic arc4 
ieee80211_crypt_tkip ipw2100 ieee80211 ieee80211_crypt bridge llc isofs 
ide_cd cdrom cifs radeon drm pcmcia firmware_class cpufreq_ondemand 
cpufreq_powersave cpufreq_performance rfcomm l2cap snd_pcm_oss snd_mixer_oss 
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_intel8x0 
snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc 
tcp_westwood rtc usbhid hci_usb bluetooth usbserial af_packet tun ppp_generic 
slhc intel_agp agpgart speedstep_centrino freq_table uhci_hcd ehci_hcd 
usbcore nvram evdev psmouse ipv6 fan button thermal processor battery ac 
yenta_socket rsrc_nonstatic pcmcia_core e1000 unix
CPU:    0
EIP:    0060:[<c01012e4>]    Not tainted VLI
EFLAGS: 00010283   (2.6.17.6 #1)
EIP is at kernel_thread+0x1/0x72
eax: 00000000   ebx: ef41fd74   ecx: c16fb750   edx: c16fb749
esi: eff32000   edi: ef41fda0   ebp: ef41fd70   esp: eff33f20
ds: 007b   es: 007b   ss: 0068
Process kthread (pid: 5, threadinfo=eff32000 task=eff07570)
Stack: c0124707 c012464d ef41fda0 00000611 ef41fd74 eff32000 c16fb740 c0121cf0
       ef41fda0 ef41fda0 c01246f0 00000296 eff32000 eff33f70 c16fb740 c16fb740
       c0121e40 c16fb740 ffffffff ffffffff 00000001 00000000 c0111b84 00010000
Call Trace:
 <c0124707> keventd_create_kthread+0x17/0x5e  <c012464d> kthread+0x0/0xa3
 <c0121cf0> run_workqueue+0x9c/0xf3  <c01246f0> 
keventd_create_kthread+0x0/0x5e
 <c0121e40> worker_thread+0xf9/0x12b  <c0111b84> 
default_wake_function+0x0/0x12
 <c0111b84> default_wake_function+0x0/0x12  <c0121d47> worker_thread+0x0/0x12b
 <c01246c6> kthread+0x79/0xa3  <c012464d> kthread+0x0/0xa3
 <c01012dd> kernel_thread_helper+0x5/0xb
Code: 50 52 51 68 95 9e 2f c0 e8 12 42 01 00 8d 43 34 50 6a 00 e8 0f 1d 00 00 
83 c4 1c 5b 5e c3 90 89 d0 52 ff d3 00 00 a1 ff 53 4d 42 <32> 00 00 00 00 a1 
ff 53 4d 42 32 00 00 00 00 80 41 c0 00 00 00
EIP: [<c01012e4>] kernel_thread+0x1/0x72 SS:ESP 0068:eff33f20


# lsmod
Module                  Size  Used by
vfat                    9216  0
fat                    40028  1 vfat
sd_mod                 13136  0
usb_storage            51392  0
scsi_mod               74440  2 sd_mod,usb_storage
michael_mic             2112  2
arc4                    1664  2
ieee80211_crypt_tkip     8768  2
ipw2100                72240  0
ieee80211              26504  1 ipw2100
ieee80211_crypt         4672  2 ieee80211_crypt_tkip,ieee80211
bridge                 41752  0
llc                     5140  1 bridge
isofs                  20740  1
ide_cd                 32324  1
cdrom                  32736  1 ide_cd
cifs                  181012  1
radeon                 97504  2
drm                    54100  3 radeon
pcmcia                 27556  2
firmware_class          7104  2 ipw2100,pcmcia
cpufreq_ondemand        4896  0
cpufreq_powersave       1408  0
cpufreq_performance     1600  1
rfcomm                 29208  10
l2cap                  17412  5 rfcomm
snd_pcm_oss            33632  0
snd_mixer_oss          14080  1 snd_pcm_oss
snd_seq_oss            26560  0
snd_seq_midi_event      5504  1 snd_seq_oss
snd_seq                41296  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          5772  2 snd_seq_oss,snd_seq
snd_intel8x0           25884  1
snd_ac97_codec         79200  1 snd_intel8x0
snd_ac97_bus            1792  1 snd_ac97_codec
snd_pcm                67784  3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              17860  2 snd_seq,snd_pcm
snd                    40100  11 
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore               6816  1 snd
snd_page_alloc          6984  2 snd_intel8x0,snd_pcm
tcp_westwood            2368  7
rtc                     6548  0
usbhid                 26564  0
hci_usb                12244  6
bluetooth              35620  15 rfcomm,l2cap,hci_usb
usbserial              24552  0
af_packet              14664  4
tun                     7552  0
ppp_generic            18004  0
slhc                    5376  1 ppp_generic
intel_agp              17948  1
agpgart                25392  2 drm,intel_agp
speedstep_centrino      5776  1
freq_table              3268  1 speedstep_centrino
uhci_hcd               18124  0
ehci_hcd               24200  0
usbcore                99456  7 
usb_storage,usbhid,hci_usb,usbserial,uhci_hcd,ehci_hcd
nvram                   6664  0
evdev                   7296  2
psmouse                31880  0
ipv6                  201376  12
fan                     4548  0
button                  6800  0
thermal                17416  0
processor              31808  2 speedstep_centrino,thermal
battery                10884  0
ac                      5060  0
yenta_socket           20940  2
rsrc_nonstatic          9664  1 yenta_socket
pcmcia_core            31632  3 pcmcia,yenta_socket,rsrc_nonstatic
e1000                  97208  0
unix                   19824  610


# uname -a
Linux skie 2.6.17.6 #1 PREEMPT Sat Jul 22 12:27:33 CEST 2006 i686 Intel(R) 
Pentium(R) M processor 1500MHz GNU/Linux


# lspci
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
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [FireGL 
9000] (rev 02)
02:00.0 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller 
(rev 01)
02:00.2 FireWire (IEEE 1394): Texas Instruments Unknown device 802a (rev 01)
02:01.0 Ethernet controller: Intel Corporation 82540EP Gigabit Ethernet 
Controller (Mobile) (rev 03)
02:02.0 Network controller: Intel Corporation PRO/Wireless LAN 2100 3B Mini 
PCI Adapter (rev 04)





--Boundary-00=_bpfxEx+jt491PEh
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.gz"

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
AAA=

--Boundary-00=_bpfxEx+jt491PEh--
