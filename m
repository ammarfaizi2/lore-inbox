Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWH0Gzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWH0Gzd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 02:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWH0Gzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 02:55:33 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:56287 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750764AbWH0Gzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 02:55:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=P4vyEW/qenmJx2dBzwcktw2Tmw9DelO5seBGXgYWv14EAiW96NHVqRMr6Qt574iRZDNVOJQY0PXj4AhceYVUGLDRjIj+fUcIi7zkrwp0QNhtcBtJny9xIYyn4YxxJ/Hzf8L5wrGKlWGu+xmIS4PK5/O5jsVlqb7SQr0RxwzSjvc=
Message-ID: <a44ae5cd0608262355q51279259lc6480f229e520fd5@mail.gmail.com>
Date: Sat, 26 Aug 2006 23:55:32 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, "akpm@osdl.org" <akpm@osdl.org>
Subject: 2.6.18-rc4-mm3 -- intel8x0 audio busted
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't had working audio in 2.6.18-rc4-mm series (1,2,3).
I haven't been able to track down the cause yet.  The modules
all load, and there seems to be the expected enties in /proc,
but my sound preferences panel shows no available audio card.

# ls /proc/asound/card0/
codec97#0  id  intel8x0  oss_mixer  pcm0c  pcm0p  pcm1c  pcm2c  pcm3c  pcm4p

0000:00:1f.5 Multimedia audio controller: Intel Corporation
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
        Subsystem: Hewlett-Packard Company: Unknown device 3080
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at 1c00 [size=256]
        Region 1: I/O ports at 18c0 [size=64]
        Region 2: Memory at e0100c00 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at e0100800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

snd_intel8x0           28316  0
snd_ac97_codec         92576  1 snd_intel8x0
snd_ac97_bus            2176  1 snd_ac97_codec
snd_pcm_oss            25632  0
snd_mixer_oss          15104  1 snd_pcm_oss
snd_pcm                73352  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              19204  1 snd_pcm
snd                    48256  6
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               6880  1 snd
snd_page_alloc          8584  2 snd_intel8x0,snd_pcm

Aug 26 23:16:56 localhost kernel: intel8x0_measure_ac97_clock:
measured 50093 usecs
Aug 26 23:16:56 localhost kernel: intel8x0: clocking to 48000
Aug 26 23:16:56 localhost kernel: PM: Adding info for No Bus:pcmC0D4p
Aug 26 23:16:56 localhost kernel: PM: Adding info for No Bus:pcmC0D3c
Aug 26 23:16:56 localhost kernel: PM: Adding info for No Bus:pcmC0D2c
Aug 26 23:16:56 localhost kernel: PM: Adding info for No Bus:pcmC0D1c
Aug 26 23:16:56 localhost kernel: PM: Adding info for No Bus:adsp
Aug 26 23:16:56 localhost kernel: PM: Adding info for No Bus:pcmC0D0p
Aug 26 23:16:56 localhost kernel: PM: Adding info for No Bus:pcmC0D0c
Aug 26 23:16:56 localhost kernel: PM: Adding info for No Bus:dsp
Aug 26 23:16:56 localhost kernel: PM: Adding info for No Bus:audio
Aug 26 23:16:56 localhost kernel: PM: Adding info for ac97:0-0:unknown codec
Aug 26 23:16:56 localhost kernel: PM: Adding info for No Bus:controlC0
Aug 26 23:16:56 localhost kernel: PM: Adding info for No Bus:mixer
Aug 26 23:16:56 localhost kernel: warning: process `alsactl' used the
obsolete sysctl system call
Aug 26 23:16:56 localhost kernel: warning: process `ls' used the
obsolete sysctl system call
Aug 26 23:16:56 localhost kernel: warning: process `alsactl' used the
obsolete sysctl system call
Aug 26 23:16:56 localhost kernel: warning: process `amixer' used the
obsolete sysctl system call
Aug 26 23:16:56 localhost kernel: warning: process `amixer' used the
obsolete sysctl system call

Linux Dumbleedor 2.6.18-rc4-mm3 #31 Sat Aug 26 22:48:34 PDT 2006 i686 GNU/Linux

Gnu C                  4.0.3
Gnu make               3.81beta4
binutils               2.16.91
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.19
reiser4progs           1.0.5
xfsprogs               2.7.7
pcmcia-cs              3.2.8
PPP                    2.4.4b1
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.93
udev                   079
Modules Loaded         binfmt_misc apm ipv6 processor
cpufreq_powersave cpufreq_performance cpufreq_ondemand freq_table
cpufreq_conservative nls_ascii nls_cp437 vfat fat nls_utf8 ntfs
nls_base sr_mod sbp2 scsi_mod parport_pc lp parport snd_intel8x0
snd_ac97_codec snd_ac97_bus pcmcia snd_pcm_oss snd_mixer_oss
yenta_socket rsrc_nonstatic snd_pcm snd_timer snd ide_cd sdhci
mmc_core ipw2200 ohci1394 ieee1394 pcmcia_core 8139cp 8139too mii
soundcore uhci_hcd ehci_hcd cdrom psmouse shpchp pci_hotplug
snd_page_alloc usbcore intel_agp agpgart evdev
