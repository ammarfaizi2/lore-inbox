Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262184AbTCMGzK>; Thu, 13 Mar 2003 01:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262186AbTCMGzK>; Thu, 13 Mar 2003 01:55:10 -0500
Received: from lns-th2-1-62-147-67-92.adsl.proxad.net ([62.147.67.92]:899 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262184AbTCMGzI>; Thu, 13 Mar 2003 01:55:08 -0500
Message-ID: <3E702DCC.9030503@ruault.com>
Date: Thu, 13 Mar 2003 08:05:48 +0100
From: Charles-Edouard Ruault <ce@ruault.com>
Reply-To: Charles-Edouard Ruault <kernel@ruault.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [kernel 2.4.21-pre5 : process stuck in D state
References: <3E6F199E.5000001@ruault.com> <200303121241.41914.m.c.p@wolk-project.de>
In-Reply-To: <200303121241.41914.m.c.p@wolk-project.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:
> On Wednesday 12 March 2003 12:27, Charles-Edouard Ruault wrote:
> 
> Hi Charles-Edouard,
> 
> 
>>i've been running kernel 2.4.21-preX series for a while on my ASUS A7V8X
>>motherboard ( with an athlon XP 2400+ )  and i've noticed the following
>>annoying problem.
>>Very often, mozilla ( 1.2.1 ) dies and is stuck in D state, waiting on a
>>semaphore, here's the output of ps :
>>
>>ps -elf | grep mozill
>>000 S userX 2615  1462  0  69   0    -   972 wait4  00:50 ?
>>00:00:00 /bin/sh /usr/local/mozilla/run-mozilla.sh
>>/usr/local/mozilla/mozilla-bin
>>000 D userX   2621  2615  0  69   0    - 13623 down   00:50 ?
>>00:00:02 /usr/local/mozilla/mozilla-bin
>>
>>Has anyone noticed the same behaviour ? Is this a well known problem ?
>>Thanks for your help.
> 
> There is a patch from Andrea for a long long time now. You may try it.
> 
> ciao, Marc
> 

Hi Marc-Christian,

i applied the patch over 2.4.21-pre5 and did some more testing.
I'm still having a problem but a different one ( i strongly suspect it's 
due to the patch since i never had this before and this occured when i 
tried to reproduce my previous problem ).
Here's a exerpt of the logs:

Mar 12 10:19:38 localhost kernel: hda: dma_timer_expiry: dma status == 
0x21
Mar 12 10:21:19 localhost kernel: hda: timeout waiting for DMA
Mar 12 10:21:19 localhost kernel: hda: timeout waiting for DMA 

Mar 12 10:21:19 localhost kernel: hda: (__ide_dma_test_irq) called while 
not waiting
Mar 12 10:21:19 localhost kernel: hda: status error: status=0x51 { 
DriveReady SeekComplete Error }
  Mar 12 10:21:19 localhost kernel: hda: status error: error=0x04 { 
DriveStatusError }
Mar 12 10:21:19 localhost kernel: hda: no DRQ after issuing MULTWRITE 

Mar 12 10:21:19 localhost kernel: hda: status error: status=0x51 { 
DriveReady SeekComplete Error }
Mar 12 10:21:19 localhost kernel: hda: status error: error=0x04 { 
DriveStatusError }
Mar 12 10:21:19 localhost kernel: hda: no DRQ after issuing MULTWRITE
Mar 12 10:21:19 localhost kernel: hda: status error: status=0x51 { 
DriveReady SeekComplete Error }
Mar 12 10:21:19 localhost kernel: hda: status error: error=0x04 { 
DriveStatusError }
Mar 12 10:21:19 localhost kernel: hda: no DRQ after issuing MULTWRITE 

Mar 12 10:21:19 localhost kernel: hda: status error: status=0x51 { 
DriveReady SeekComplete Error }
Mar 12 10:21:19 localhost kernel: hda: status error: error=0x04 { 
DriveStatusError }
  Mar 12 10:21:19 localhost kernel: hda: no DRQ after issuing WRITE
Mar 12 10:21:19 localhost kernel: ide0: reset: success 

Mar 12 10:21:19 localhost kernel: hda: dma_timer_expiry: dma status == 0x21
Mar 12 10:21:19 localhost kernel: hda: timeout waiting for DMA 

Mar 12 10:21:19 localhost kernel: hda: timeout waiting for DMA
Mar 12 10:21:19 localhost kernel: hda: (__ide_dma_test_irq) called while 
not waiting
Mar 12 10:21:19 localhost kernel: hda: status error: status=0x58 { 
DriveReady SeekComplete DataRequest } 

Mar 12 10:21:19 localhost kernel: hda: drive not ready for command
Mar 12 10:21:19 localhost kernel: hda: status timeout: status=0xd0 { 
Busy }
Mar 12 10:21:19 localhost kernel: hda: drive not ready for command 

Mar 12 10:21:19 localhost kernel: ide0: reset: success
Mar 12 10:21:19 localhost kernel: hda: dma_timer_expiry: dma status == 0x21


and basically the whole machine locked up ... reset was the only way out :-(
I have an ASUS A7V8X motherboard with a VIA Technologies, Inc. VT82C586B 
PIPC Bus Master IDE (rev 06)and a Maxtor 6Y080L0 hard drive.
Any other idea/hint to solve this ?
Thanks again for your help

-- 
Charles-Edouard Ruault
PGP Key ID 4370AF2D

