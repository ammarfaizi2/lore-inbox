Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273360AbRI3M2t>; Sun, 30 Sep 2001 08:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273361AbRI3M23>; Sun, 30 Sep 2001 08:28:29 -0400
Received: from dclient217-162-28-40.hispeed.ch ([217.162.28.40]:53628 "HELO
	fw.nixs.ch") by vger.kernel.org with SMTP id <S273360AbRI3M2T>;
	Sun, 30 Sep 2001 08:28:19 -0400
From: Magic Phibo <phibo@gmx.li>
To: linux-kernel@vger.kernel.org
Subject: Problem recording audio with Kernel-2.4.x and ISAPnp Soundcard
Date: Sun, 30 Sep 2001 14:06:40 +0200
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01093014284200.16080@spyrux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list

>From Kernel 2.4.x on I got problems recording audio files over a Yamaha
ISAPnp Soundcard with OPL3SA3 chip. I tried with the isapnp tools aka
'pnpdump > /etc/isapnp.conf' and then 'isapnp /etc/isapnp.conf'. Here is my
isapnp.conf:

(READPORT 0x0273)
(ISOLATE PRESERVE)
(IDENTIFY *)
(VERBOSITY 2)
(CONFLICT (IO FATAL)(IRQ FATAL)(DMA FATAL)(MEM FATAL)) # or WARNING
(CONFIGURE YMH0800/-1 (LD 0
  (IO 0 (SIZE 16) (BASE 0x0220))
  (IO 1 (SIZE 8) (BASE 0x0530))
  (IO 2 (SIZE 8) (BASE 0x0388))
  (IO 3 (SIZE 2) (BASE 0x0330))
  (IO 4 (SIZE 2) (BASE 0x0370))
  (INT 0 (IRQ 5 (MODE +E)))
  (DMA 0 (CHANNEL 0))
  (DMA 1 (CHANNEL 1))
  (NAME "YMH0800/-1[0]{OPL3-SA3 Sound Board}")
   (ACT Y)
))
(CONFIGURE YMH0800/-1 (LD 1
  (IO 0 (SIZE 1) (BASE 0x0201))
 (NAME "YMH0800/-1[1]{OPL3-SA3 Sound Board}")
  (ACT Y)
))
(WAITFORKEY)

and here is my /etc/modules.conf:

alias sound-slot-0 opl3sa2
options sound dmabuf=1
alias midi opl3
options opl3 io=0x388
options opl3sa2 mss_io=0x530 irq=5 dma=0 dma2=1 mpu_io=0x330 io=0x370

This worked fine with Kernel-2.2.x. With Kernel-2.4.x however (currently 2.4.10)
the soundcard is recognized properly, any kind of soundfile can be played, but
I'm not able to record an audiofile aka

'rec soundfile.au' or 'cat > /tmp/sound.au < /dev/audio' 

with the following error message:
  
Sep 29 03:54:05 osiris kernel: Sound: DMA (input) timed out - IRQ/DRQ configerror?

I also tried with other DMA channels and with isapnp compiled into the Kernel
and the result was always the same: soundcard recognized, soundfiles can be
played but NO recording.

What can I try else to get this to work ? 

Thanks in advance for your help !


Cheers,
Phibo
