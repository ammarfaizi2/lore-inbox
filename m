Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbUBVQXa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 11:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbUBVQXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 11:23:30 -0500
Received: from lakemtao04.cox.net ([68.1.17.241]:55431 "EHLO
	lakemtao04.cox.net") by vger.kernel.org with ESMTP id S261683AbUBVQX0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 11:23:26 -0500
From: "Jack S. Lai" <laitcg@cox.net>
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.3 bttv bt848 problem
Date: Sun, 22 Feb 2004 11:23:17 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402221123.17258.laitcg@cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading from 2.6.2, to 2.6.3 (using make oldconfig [1]), and trying to 
run tvtime, I cannot change tv stations and dmesg shows:
tuner: Huh? tv_set is NULL?

Reverting to kernel 2.6.2 is a work around.

Details:
dmesg:
Linux video capture interface: v1.00
bttv: driver version 0.9.12 loaded
bttv: using 4 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
PCI: Found IRQ 11 for device 0000:00:0a.0
IRQ routing conflict for 0000:00:0a.0, have irq 9, want irq 11
bttv0: Bt848 (rev 18) at 0000:00:0a.0, irq: 9, latency: 64, mmio: 0xe7001000
bttv0: using: Diamond DTV2000 [card=5,insmod option]
bttv0: gpio: en=00000000, out=00000000 in=00ffff8f [init]
tuner: chip found @ 0xc2
tuner: type forced to 17 (Philips NTSC_M (MK2)) [insmod]
tuner: type already set (17)
bttv0: using tuner=-1
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h
a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951),ta8874z
tvaudio: found tda9850 @ 0xb6
bttv0: registered device video0
bttv0: registered device vbi0
tuner: Huh? tv_set is NULL?
tuner: Huh? tv_set is NULL?
tuner: Huh? tv_set is NULL?
tuner: Huh? tv_set is NULL?
tuner: Huh? tv_set is NULL?

lspci shows:
00:0a.0 Multimedia video controller: Brooktree Corporation Bt848 Video
Capture (rev 12)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e7001000 (32-bit, prefetchable) [size=4K]

Hardware:
Diamond DTV2000 Rev B
Chips:
 Philips NTSC
 BT848A
 TDA9855
 230710
 DSD 9522 2 Y

/etc/modprobe.conf:
options bttv card=5 gbuffers=4
options tuner type=2 (and tried 17 as the dmesg above reports)

A non-related issue that maybe someone else has resolved with the DTV2000 is
my sound only works when I don't set the "tvaudio" as with:
options tvaudio tda9850=0 tda9855=1 (in modules.conf/modprobe.conf) but let
it select its own and dmesg shows it selecting the tda9850. This sound
"works" but I only get the left channel, or the right channel, or no
channels, or both channels... as I change stations. :(

Although I read the linux.kernel newsgroup, please CC any responses as I do 
not subscribe to the lkml. Thank you.

[1] Answered No to:
Plug and Play BIOS /proc interface (PNPBIOS_PROC_FS) [N/y/?]
FSC Hermes (SENSORS_FSCHER) [N/m/?]
Genesys Logic GL518SM (SENSORS_GL518SM) [N/m/?]
ATI Radeon display support (Old driver) (FB_RADEON_OLD) [N/m/y/?]
Bt87x Audio Capture (SND_BT87X) [N/m/y/?]
-- 
Slackware Tips & Tricks
http://members.cox.net/laitcg/slack.htm
