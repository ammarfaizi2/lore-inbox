Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283748AbRLEEmH>; Tue, 4 Dec 2001 23:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283751AbRLEEl6>; Tue, 4 Dec 2001 23:41:58 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:42113 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S283748AbRLEElt>; Tue, 4 Dec 2001 23:41:49 -0500
Message-ID: <3C0DA588.2080000@optonline.net>
Date: Tue, 04 Dec 2001 23:41:44 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Mikocevic <mozgy@hinet.hr>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



got this during a quake run with only DEBUG_INTERRUPTS enabled

it seems that we aren't making it properly chase its tail during mmap 
mode. so it runs through once and then stops. the final timeout is 
waiting for a completion that's never going to come.

Dec  4 23:33:50 lasn-001 kernel: Intel 810 + AC97 Audio, version 0.07, 
23:28:08 Dec  4 2001
Dec  4 23:33:50 lasn-001 kernel: PCI: Setting latency timer of device 
00:1f.5 to 64
Dec  4 23:33:50 lasn-001 kernel: i810: Intel ICH 82801AA found at IO 
0x2400 and 0x2000, IRQ 17
Dec  4 23:33:51 lasn-001 kernel: i810_audio: Audio Controller supports 2 
channels.
Dec  4 23:33:51 lasn-001 kernel: ac97_codec: AC97 Audio codec, id: 
0x4144:0x5360 (Analog Devices AD1885)
Dec  4 23:33:51 lasn-001 kernel: i810_audio: AC'97 codec 0 Unable to map 
surround DAC's (or DAC's not present), total channels = 2
Dec  4 23:33:51 lasn-001 kernel: i810_audio: setting clocking to 41231
Dec  4 23:34:00 lasn-001 kernel: NVRM: AGPGART: allocated 257 pages
Dec  4 23:34:00 lasn-001 kernel: NVRM: AGPGART: allocated 128 pages
Dec  4 23:34:00 lasn-001 kernel: CHANNEL NUM 1 PORT 10 IRQ ( ST8 DAC HWP 
16384,0,16384
Dec  4 23:34:00 lasn-001 kernel: COMP 8 )
Dec  4 23:34:01 lasn-001 kernel: CHANNEL NUM 1 PORT 10 IRQ ( ST8 DAC HWP 
32768,16384,16384
Dec  4 23:34:01 lasn-001 kernel: COMP 16 )
Dec  4 23:34:01 lasn-001 kernel: CHANNEL NUM 1 PORT 10 IRQ ( ST8 DAC HWP 
49152,32768,16384
Dec  4 23:34:01 lasn-001 kernel: COMP 24 )
Dec  4 23:34:01 lasn-001 kernel: CHANNEL NUM 1 PORT 10 IRQ ( ST15 DAC 
HWP 65536,49152,16384
Dec  4 23:34:01 lasn-001 kernel: COMP 32 DAC HWP 65536,65536,0
Dec  4 23:34:01 lasn-001 kernel: LVI DAC HWP 65536,65536,0
Dec  4 23:34:01 lasn-001 kernel: DCH - STOP )
Dec  4 23:34:02 lasn-001 kernel: cdrom: open failed.
Dec  4 23:34:03 lasn-001 kernel: DAC HWP 65536,65536,0
Dec  4 23:34:07 lasn-001 kernel: NVRM: AGPGART: freed 128 pages
Dec  4 23:34:07 lasn-001 kernel: NVRM: AGPGART: freed 257 pages
Dec  4 23:34:07 lasn-001 kernel: DAC HWP 65536,65536,0
Dec  4 23:34:10 lasn-001 kernel: i810_audio: drain_dac, dma timeout?

