Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287895AbSA0OLv>; Sun, 27 Jan 2002 09:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288050AbSA0OLl>; Sun, 27 Jan 2002 09:11:41 -0500
Received: from [195.63.194.11] ([195.63.194.11]:58893 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S287895AbSA0OL3>; Sun, 27 Jan 2002 09:11:29 -0500
Message-ID: <3C540A90.5020904@evision-ventures.com>
Date: Sun, 27 Jan 2002 15:11:28 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CRAP in 2.4.18-pre7
In-Reply-To: <20020126171545.GB11344@fefe.de> <3C52E671.605FA2F3@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to notice that the changes in 2.4.18-pre7 to the
tulip eth driver are apparently causing absymal performance drops
on my version of this card. Apparently the performance is dropping
from the expected 10MB/s to about 10kB/s. The only special
thing about the configuration in question is the fact that it's
a direct connection between two hosts. Well, more precisely it's
a cross-over link between my notebook and desktop.

Here is an excerpt from the lspci command:

00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 
[Tulip Pass 3] (rev 11)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d400 [size=128]
        Region 1: Memory at cfffdf80 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at cff80000 [disabled] [size=256K]

The motherboard is a SiS735 chip. The card is apparently sharing it's 
interrupt
(which I guess could be a cause of the problem) with nearly anything else
on the system:

          CPU0
  0:     654927          XT-PIC  timer
  1:      25591          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:        107          XT-PIC  bttv
  8:     283913          XT-PIC  rtc
 11:      70064          XT-PIC  usb-ohci, usb-ohci, eth0, SiS 7012
 12:      39738          XT-PIC  PS/2 Mouse
 14:     198652          XT-PIC  ide0
 15:          0          XT-PIC  ide1
NMI:          0
ERR:          0
[root@domek athlon]#

Oh well yes I have added the newest version of the i810_audio.c for
support of the on board sound card - it's working *GREATLY*.

Please revert the changes in question from the pre-patch.

