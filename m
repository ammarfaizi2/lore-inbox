Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268440AbRHAWI3>; Wed, 1 Aug 2001 18:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268441AbRHAWIT>; Wed, 1 Aug 2001 18:08:19 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:27565 "EHLO mail.inf.elte.hu")
	by vger.kernel.org with ESMTP id <S268440AbRHAWIH>;
	Wed, 1 Aug 2001 18:08:07 -0400
Date: Thu, 2 Aug 2001 00:08:00 +0200 (CEST)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: kswapd eats the cpu without swap
Message-ID: <Pine.A41.4.31.0108012357130.28452-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

kernel is 2.4.7-ac3 with the used-once patch.
I have 160M of ram, and I don't use swap at all, but some minutes before
kswapd was eating lot's of cpu (98-100%). the system did not responded for
some 10 seconds, then it worked for some seconds, then it did not responded
again, until I did a swapon. after adding the swap to the system, it
swapped out 148k then everything was ok. kswapd still eat some of the cpu
(0.5% of a k6-2/450). then swapoff, and everything is OK, again.

szabi@traktor:~# cat /proc/modules
nls_iso8859-1           2880   0 (autoclean)
sr_mod                 13408   0 (autoclean)
ide-scsi                7680   0
cdrom                  27488   0 (autoclean) [sr_mod]
scsi_mod               80112   2 (autoclean) [sr_mod ide-scsi]
isofs                  18000   0 (autoclean)
ppp_deflate            39264   0 (autoclean)
bsd_comp                4160   0 (autoclean)
ppp_async               6416   1 (autoclean)
snd-pcm-oss            36768   1 (autoclean)
snd-mixer-oss           8912   0 (autoclean) [snd-pcm-oss]
ppp_generic            14240   3 (autoclean) [ppp_deflate bsd_comp
ppp_async]
slhc                    4800   0 (autoclean) [ppp_generic]
agpgart                12704   2 (autoclean)
snd-card-ymfpci         3520   1
snd-opl3                5712   0 [snd-card-ymfpci]
snd-hwdep               3760   0 [snd-opl3]
snd-ymfpci             36272   0 [snd-card-ymfpci]
snd-ac97-codec         21712   0 [snd-ymfpci]
snd-pcm                45888   0 [snd-pcm-oss snd-ymfpci]
snd-timer               8848   0 [snd-opl3 snd-pcm]
snd-mpu401-uart         2848   0 [snd-card-ymfpci]
snd-rawmidi            11744   0 [snd-mpu401-uart]
snd-seq-device          4080   0 [snd-opl3 snd-rawmidi]
snd                    25760   0 [snd-pcm-oss snd-mixer-oss
snd-card-ymfpci snd-opl3 snd-hwdep snd-ymfpci snd-ac97-codec snd-pcm
snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3984   3 [snd]
iptable_filter          2048   0 (autoclean) (unused)
ip_tables              10592   1 [iptable_filter]
reiserfs              149904   4 (autoclean)
ne2k-pci                5152   1
8390                    6176   0 [ne2k-pci]
szabi@traktor:~#

tell me what to do. anything to try? or something about the system?
I will try to reproduce it, but I don't think I will succeed.

Bye,
Szabi



