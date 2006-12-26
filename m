Return-Path: <linux-kernel-owner+w=401wt.eu-S1754588AbWLZAPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbWLZAPz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 19:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754593AbWLZAPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 19:15:55 -0500
Received: from smtp-out.rrz.uni-koeln.de ([134.95.19.53]:42215 "EHLO
	smtp-out.rrz.uni-koeln.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588AbWLZAPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 19:15:54 -0500
Message-ID: <459069AA.20809@rrz.uni-koeln.de>
Date: Tue, 26 Dec 2006 01:15:38 +0100
From: Berthold Cogel <cogel@rrz.uni-koeln.de>
User-Agent: IceDove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Regression in kernel linux-2.6.20-rc1/2: Problems with poweroff
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

'shutdown -h now' doesn't work for my system (Acer Extensa 3002 WLMi)
with linux-2.6.20-rc kernels. The system reboots instead.
I've checked linux-2.6.19.1 with an almost identical .config file
(differences because of new or changed options). For pre 2.6.20 kernels
shutdown works for my computer.

lspci:

00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
00:01.0 PCI bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to AGP Controller (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2
EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 83)
00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface
Bridge (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE
Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
SMBus Controller (rev 03)
00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
AC'97 Modem Controller (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility
Radeon 9600 M10]
02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
02:04.0 Network controller: Intel Corporation PRO/Wireless 2200BG
Network Connection (rev 05)
02:06.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
02:06.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394
Host Controller
02:06.3 Mass storage controller: Texas Instruments PCIxx21 Integrated
FlashMedia Controller


lsmod:

Module                  Size  Used by
binfmt_misc            10888  1
radeon                111008  2
drm                    73748  3 radeon
rfcomm                 35100  0
l2cap                  22148  5 rfcomm
bluetooth              47588  4 rfcomm,l2cap
nfs                   116796  0
lockd                  57736  1 nfs
nfs_acl                 3584  1 nfs
sunrpc                147004  4 nfs,lockd,nfs_acl
af_packet              20104  0
thermal                13832  0
fan                     4868  0
button                  7952  0
sbs                    14752  0
i2c_ec                  5120  1 sbs
autofs4                19972  0
snd_intel8x0m          16780  5
dm_crypt               12680  0
dm_mirror              18836  0
ipw2200               170056  0
b44                    24716  0
mii                     5504  1 b44
ieee80211_crypt_tkip    10752  0
ieee80211_crypt_ccmp     7168  0
ieee80211_crypt_wep     5248  0
ieee80211              30792  1 ipw2200
ieee80211_crypt         6016  4
ieee80211_crypt_tkip,ieee80211_crypt_ccmp,ieee80211_crypt_wep,ieee80211
cpufreq_conservative     6432  0
cpufreq_ondemand        7548  1
cpufreq_performance     2304  0
cpufreq_powersave       2048  0
acpi_cpufreq            7308  1
freq_table              4484  2 cpufreq_ondemand,acpi_cpufreq
processor              23340  2 thermal,acpi_cpufreq
sg                     28956  0
scsi_mod               93448  1 sg
usbhid                 23968  0
hid                    20612  1 usbhid
snd_intel8x0           31132  1
nsc_ircc               21776  0
snd_ac97_codec         87712  2 snd_intel8x0m,snd_intel8x0
ac97_bus                2432  1 snd_ac97_codec
snd_pcm_oss            36768  0
snd_mixer_oss          15744  1 snd_pcm_oss
snd_pcm                64776  6
snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
joydev                  9280  0
irda                  171068  1 nsc_ircc
snd_timer              20868  1 snd_pcm
ide_cd                 36512  0
pcmcia                 27808  0
firmware_class          9728  2 ipw2200,pcmcia
tifm_7xx1               7808  0
tifm_sd                 9992  0
mmc_block               8712  0
mmc_core               25492  2 tifm_sd,mmc_block
ohci1394               32688  0
snd                    47972  17
snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
crc_ccitt               2304  1 irda
ehci_hcd               29452  0
uhci_hcd               21900  0
cdrom                  33184  1 ide_cd
tifm_core               8976  2 tifm_7xx1,tifm_sd
ieee1394               88760  1 ohci1394
yenta_socket           25100  1
rsrc_nonstatic         12288  1 yenta_socket
pcmcia_core            36752  3 pcmcia,yenta_socket,rsrc_nonstatic
i2c_i801                7564  0
psmouse                34696  0
rtc                    12848  0
pcspkr                  3072  0
soundcore               7904  1 snd
snd_page_alloc          9864  3 snd_intel8x0m,snd_intel8x0,snd_pcm
intel_agp              22556  1
usbcore               120984  4 usbhid,ehci_hcd,uhci_hcd
agpgart                30128  2 drm,intel_agp
evdev                   9344  4
unix                   25776  732


Regards,

Berthold Cogel
