Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbTADWs3>; Sat, 4 Jan 2003 17:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbTADWs3>; Sat, 4 Jan 2003 17:48:29 -0500
Received: from radius8.csd.net ([204.151.43.208]:19209 "EHLO
	bastille.tuells.org") by vger.kernel.org with ESMTP
	id <S261686AbTADWs0>; Sat, 4 Jan 2003 17:48:26 -0500
Date: Sat, 4 Jan 2003 15:48:01 -0700
From: marcus hall <marcus@tuells.org>
To: linux-kernel@vger.kernel.org
Subject: Missing interrupts from es1371 sound card
Message-ID: <20030104224801.GA1034@watermarks.tuells.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having a terrible time trying to get an Ensoniq es1371 sound card to
work on my system.  Everything appears to install and load correctly, but
when I attempt to send a sound to the file, sox writes the data out and
then hangs in the close() call (presumably waiting for the buffer to
drain.  I hear no sound.  I see no interrupts accounting on the interrupt
line, so I am presuming that the interrupt is not ocurring.

First off, here's an lspci -vv for the card:

00:0a.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d400 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

kernel messages during boot relevant to the card:

es1371: version v0.30 time 12:21:01 Sep  4 2002
PCI: Found IRQ 5 for device 00:0a.0
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x06
es1371: found es1371 rev 6 at io 0xd400 irq 5
es1371: features: joystick 0x0
PCI: Setting latency timer of device 00:0a.0 to 64
ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)

Finally, /proc/interrupts shows no activity on irq5:

           CPU0       
  0:    1181506          XT-PIC  timer
  1:        624          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  es1371
  8:          1          XT-PIC  rtc
  9:      18888          XT-PIC  usb-ohci, DC21041 (eth0)
 10:          8          XT-PIC  aic7xxx
 12:      61887          XT-PIC  PS/2 Mouse
 14:      18025          XT-PIC  ide0
 15:          2          XT-PIC  ide1
NMI:          0 
ERR:          0

As you can see, the interrupt isn't shared with anything else, so that
isn't an issue.

I have exchanged the card with another with the same results.  I have
routed the card's interrupt to IRQ11 with again the same results (this
also ends up assigning the aic7xxx to irq 5, and I do see interrupts
tallied there, so the irq line on the motherboard also seems to be
just fine.)

Under W98 (boo hiss) the card also does not function.  It thinks it is
playing a sound, but nothing comes out of the card.  So it isn't something
pecular to linux, but swapping the cards seems to indicate it isn't
pecular to the sound card either...  The motherboard is an ASUS P5A, if
there is any known issue with that MB (I'm beginning to think it must be..)

Any suggestions of what to try or where to look deeper?

Thanks!

marcus hall
marcus@tuells.org


