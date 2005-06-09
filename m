Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVFISpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVFISpm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 14:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVFISpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 14:45:41 -0400
Received: from urchin.mweb.co.za ([196.2.24.26]:7248 "EHLO urchin.mweb.co.za")
	by vger.kernel.org with ESMTP id S262442AbVFISpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 14:45:16 -0400
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Subject: Re: Tyan Opteron boards and problems with parallel ports (badpmd)
Date: Thu, 9 Jun 2005 20:45:19 +0200
User-Agent: KMail/1.8.50
Cc: Christopher Warner <chris@servertogo.com>,
       Joel Jaeggli <joelja@darkwing.uoregon.edu>,
       Christopher Warner <cwarner@kernelcode.com>,
       "Peter J. Stieber" <developer@toyon.com>, linux-kernel@vger.kernel.org,
       Bill Davidsen <davidsen@tmr.com>, admin@list.net.ru
References: <3174569B9743D511922F00A0C943142309F815A6@TYANWEB> <1117190965.13932.36.camel@sabrina> <200506011316.29771.rathamahata@ehouse.ru>
In-Reply-To: <200506011316.29771.rathamahata@ehouse.ru>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200506092045.20274.bonganilinux@mweb.co.za>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 June 2005 11:16 am, Sergey S. Kostyliov wrote:
> On Friday 27 May 2005 14:49, Christopher Warner wrote:
> > What we need is to try and single out the variables that are causing the
> > badpmd's. Also the more people who report badpmd's with Andi Kleen's
> > intial patch the better. Especially on different archs; would also be
> > good. So far from lkml i'm only seeing Tyan S28* boards as of recent.
>
> We have run into different problem (for our different from S28*arch)
> for the box which had had badpmd issues with v2.6.11 (see:
>     http://seclists.org/lists/linux-kernel/2005/May/6369.html)
>
> with 2.6.12-rc5 we are always getting dozens of user-space segfaults:
>
> grep[25377]: segfault at 0000000000014aa0 rip 00002aaaaad37130 rsp
> 00007fffffb13cb8 error4 grep[29940]: segfault at 0000000000014aa0 rip
> 00002aaaaad37130 rsp 00007fffff913428 error4 sed[5849] general protection
> rip:40bac5 rsp:7fffffb231d0 error:0
> sed[27437] general protection rip:40bac5 rsp:7ffffff248c0 error:0
> sed[27473] general protection rip:40bac5 rsp:7fffff923740 error:0
> sed[27472] general protection rip:40bac5 rsp:7fffff923740 error:0
> sed[28434] general protection rip:406965 rsp:7fffffb23f10 error:0
> grep[32583]: segfault at 0000000000014aa0 rip 00002aaaaad37130 rsp
> 00007fffffd13b58 error4 sed[9074] general protection rip:40bac5
> rsp:7fffffb248a0 error:0
> sed[9546] general protection rip:406965 rsp:7fffffb23cc0 error:0
> sed[4331] general protection rip:40bac5 rsp:7fffff922fb0 error:0
> sed[17906] general protection rip:40bac5 rsp:7fffffd24b30 error:0
> sed[17934] general protection rip:40bac5 rsp:7fffffd243a0 error:0
> sed[19555] general protection rip:40bac5 rsp:7fffff924ad0 error:0
> sed[20453] general protection rip:40bac5 rsp:7ffffff23010 error:0
>
> during the build of mysql.
>
> There also was an oops with v2.6.12-rc3 for the same box:
> http://seclists.org/lists/linux-kernel/2005/May/6369.html
>
> Box passed two iterations of memtest86 (unfortunately this
> is a production box, so we can't wait for days).

I have a MSI board with Dual Opteron and I'm also getting a lot of these 
general protection errors, when compiling KDE and a few when compiling the 
kernel. They also seem to occur random. This occurs in kernel version 
2.6.12-rc*-mmX and 2.6.11-mm4. 2.6.10-rc1-mm4 is working fine.

rm[4297] general protection rip:2aaaaac32260 rsp:7fffff909b28 error:0
sed[25927] general protection rip:40870a rsp:7fffff919320 error:0
sed[6628] general protection rip:40870a rsp:7fffffd18610 error:0
sed[7468] general protection rip:40870a rsp:7fffffb1a020 error:0
sed[13251] general protection rip:40870a rsp:7fffffb197b0 error:0
sed[18727] general protection rip:40870a rsp:7fffffb19490 error:0
sed[19301] general protection rip:40870a rsp:7ffffff18680 error:0
sed[19895] general protection rip:40870a rsp:7ffffff19420 error:0
sed[8139] general protection rip:40870a rsp:7fffff918b80 error:0
sed[12275] general protection rip:40870a rsp:7fffff918c90 error:0
sed[12021] general protection rip:40870a rsp:7fffffb193d0 error:0
sed[14332] general protection rip:40870a rsp:7ffffff193d0 error:0
sed[14350] general protection rip:40870a rsp:7fffff9192c0 error:0
g++[21170] general protection rip:404c88 rsp:7ffffff16c10 error:0
sed[28312] general protection rip:40870a rsp:7fffffd18310 error:0
sed[21555] general protection rip:40870a rsp:7ffffff19210 error:0
sed[24421] general protection rip:40870a rsp:7fffffb196d0 error:0
sed[11782] general protection rip:40870a rsp:7ffffff184c0 error:0
sed[18738] general protection rip:40870a rsp:7fffffb192f0 error:0
sed[19054] general protection rip:40870a rsp:7fffff919930 error:0
sed[2726] general protection rip:40870a rsp:7ffffff196f0 error:0
sed[32070] general protection rip:40870a rsp:7fffffb19600 error:0


lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge 
(rev 01)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South]
00:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture 
(rev 11)
00:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
11)
00:08.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
00:08.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 
04)
00:08.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04)
00:0b.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705 Gigabit 
Ethernet (rev 03)
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID 
Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800 
South]
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM 
Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM 
Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
01:00.0 VGA compatible controller: nVidia Corporation NV36 [GeForce FX 5700LE] 
(rev a1)


[bongani@bongani64 scripts]$ ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux bongani64 2.6.12-rc6-mm1 #9 SMP Tue Jun 7 21:58:39 SAST 2005 x86_64 AMD 
Opteron(tm) Processor 244 unknown GNU/Linux

Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.36
reiserfsprogs          line
reiser4progs           line
nfs-utils              1.0.7
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   054
Modules Loaded         video thermal processor fan button ac isofs 
zlib_inflate udf snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq 
snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_seq_device 
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd 
soundcore tcp_bic i2c_isa i2c_viapro usbhid eth1394 tg3 ide_cd cdrom ohci1394 
ieee1394 loop nls_iso8859_1 nls_cp437 vfat fat tuner bttv video_buf 
firmware_class i2c_algo_bit v4l2_common btcx_risc tveeprom i2c_core videodev 
sata_via libata scsi_mod ehci_hcd uhci_hcd usbcore
