Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262329AbTCMOF7>; Thu, 13 Mar 2003 09:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262330AbTCMOF7>; Thu, 13 Mar 2003 09:05:59 -0500
Received: from mxic1.isus.emc.com ([168.159.129.100]:28938 "EHLO
	mxic1.corp.emc.com") by vger.kernel.org with ESMTP
	id <S262329AbTCMOFs>; Thu, 13 Mar 2003 09:05:48 -0500
Message-ID: <93F527C91A6ED411AFE10050040665D0049C0830@CORPUSMX1>
From: berthiaume_wayne@emc.com
To: Bart.Theunissen@pandora.be
Cc: gardiol@libero.it, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Harrison_Richard@emc.com
Subject: RE: Bug in IDE controllers when connected to PCI?
Date: Thu, 13 Mar 2003 09:15:35 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-15"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Native support of the PDC20269 chip did not show up until 2.4.19. If
I recall native 48LBA appeared in 2.4.16. You could try pulling
drivers/ide/pdc202xx.c from 2.4.19 and dropping it into 2.4.17 to replace
the present drivers/ide/pdc202xx.c and giving that a try.

> -----Original Message-----
> From: Bart Theunissen [mailto:Bart.Theunissen@pandora.be]
> Sent: Thursday, March 13, 2003 5:23 AM
> To: Bart Theunissen
> Cc: gardiol@libero.it; linux-kernel@vger.kernel.org;
> linux-ide@vger.kernel.org; Harrison_Richard@emc.com;
> berthiaume_wayne@emc.com
> Subject: Re: Bug in IDE controllers when connected to PCI?
> 
> 
> Hi,
> 
> unfortunately, linux-2.4.17 does not support promise-20269 ;-(
> 
> Greetings,
> 
> Bart
> 
> Bart Theunissen wrote:
> 
> > Hi,
> >
> > I am experiencing the same problem. The controller is a 
> promise-20269 
> > and four disks are attached to it (dma is turned on for all drives)
> > I get the same error messages on the console (except for the scsi 
> > message). The message 'seeking beyond end of device' is 
> also logged to 
> > console. Additionally, file corruption occurs in files that are 
> > changed very often (logfiles, database files). It seems that the 
> > erroneous data in the logfiles comes from other files on the same 
> > partition (/var). Sometimes it takes up to 12 hours before 
> corruption 
> > occurs. The program I am using to test this is a java program that 
> > does write/read/modify and uses md5 to see if a file was changed 
> > (corrupted) without accessing the file directly. Sometimes, the 
> > complete systems crashes (it cannot execute a binary or find a 
> > library). I encountered this on kernel 2.4.20.
> >
> > I am testing 2.4.17 to see if it has the same problem (gardiol said 
> > this one should be fine).
> >
> > What can be the cause of this problem ? If more information 
> is needed, 
> > or additional tests are required, let me know.
> >
> > Greets,
> >
> > Bart
> >
> > Willy Gardiol wrote:
> >
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >>
> >> Hi to all,
> >> i think i run into a bug in current stable kernel's regarding IDE 
> >> controllers and PCI.
> >> Sorry for the long post, but i need some help from you to 
> investigate 
> >> this deeper.
> >>
> >> I own a CDRW Philips 1610A, here is hdparm -i and -I output:
> >>
> >> (hdparm -i)
> >> /dev/hdf:
> >> Model=PHILIPS CDRW1610A, FwRev=0.010000, SerialNo=5VO2149DL13692
> >> Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
> >> RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
> >> BuffType=DualPortCache, BuffSize=128kB, MaxMultSect=0
> >> (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
> >> IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> >> PIO modes: pio0 pio1 pio2 pio3 pio4
> >> DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 udma2
> >> AdvancedPM=no
> >>
> >> (hdparm -I)
> >> /dev/hdf:
> >> ATAPI CD-ROM, with removable media
> >>        Model Number:           PHILIPS CDRW1610A
> >>        Serial Number:          5VO2149DL13692
> >>        Firmware Revision:      0.010000
> >> Standards:
> >> Configuration:
> >>        DRQ response: 50us.
> >>        Packet size: 12 bytes
> >> Capabilities:
> >>        LBA, IORDY(cannot be disabled)
> >>        Buffer size: 128.0kB
> >>        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2 udma0 udma1 udma2
> >>             Cycle time: min=120ns recommended=120ns
> >>        PIO: pio0 pio1 pio2 pio3 pio4
> >>             Cycle time: no flow control=120ns  IORDY flow 
> control=120ns
> >>
> >> It works and burns correctly with DMA enabled( hdparm -d1) when 
> >> connected to the on-board IDE controller, following is 
> /rpco/pci of it:
> >>  Bus  0, device   4, function  1:
> >>    IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master 
> >> IDE (rev 6).
> >>      Master Capable.  Latency=32.
> >>      I/O at 0xd800 [0xd80f].
> >>
> >> I also have two different PCI IDE ATA100/133 controllers:
> >> a Promise Ultra100 TX2 (chip PDC20268)
> >> a Sil  0680 based RAID ATA133 board
> >> Here is /proc/pci for the 0680 (the other one is not 
> conented right now)
> >>  Bus  0, device  11, function  0:
> >>    RAID bus controller: CMD Technology Inc PCI0680 (rev 2).
> >>      IRQ 10.
> >>      Master Capable.  Latency=32.
> >>      I/O at 0x9800 [0x9807].
> >>      I/O at 0x9400 [0x9403].
> >>      I/O at 0x9000 [0x9007].
> >>      I/O at 0x8800 [0x8803].
> >>      I/O at 0x8400 [0x840f].
> >>      Non-prefetchable 32 bit memory at 0xd4800000 [0xd48000ff].
> >>
> >> When connected to any of these two controllers (as hde, 
> hdf or hdg, 
> >> not tryed hdh but dont think it changes something) if i enable DMA 
> >> (hdparm -d1) the kernel hangs when i try to burn: no logs 
> are written 
> >> (!) but i managed to get this output (sending all logs to 
> /dev/tty12):
> >>
> >> IDE_DMAPROC: chipset supported IDE_DMA_TIMEOUT only: 14
> >> hdf: status timeout: status 0xd0 { Busy }
> >> hdf: drive not ready for command
> >> vmunix: scsi: aborting command due to timeout: pid 934, scsi0, 
> >> channel 0, id 0, lun 0 2x2a 00 00 00 00 00 00 1f 00
> >> IDE_DMAPROC: chipset supported IDE_DMA_TIMEOUT only: 14
> >> hdf: status timeout: status 0xd0 { Busy }
> >> hdf: drive not ready for command
> >> hdf: ATAPI reset complete
> >> unable to handle kernel null pointer dereference at 
> virtual address 
> >> 00018
> >> (follow a register dump, omitted because i didnt copied it)
> >> kernel panic: Aieee, killing interrupt handler!
> >> in interrupt handler - NOT SYNCING
> >>
> >> I had to copy this by hand so maybe there are some typo errors.
> >>
> >> I also own a DVD reader, also connected to this PCI 
> controllers which 
> >> uses UDMA5 (hdparm -d1 -X69) and has different troubles:
> >> - - with the Promise PCD20268 it causes a kernel panic 
> when i try to 
> >> read a dirty CD (which, on the other hand the cdburner 
> correctly reads)
> >> - - with the 0680 it reads the same CD without giving ANY 
> read errors 
> >> and without hanging the kernel! (but gives many reading 
> errors with 
> >> the burner...)
> >>
> >> Off course none of this problems had ever been noticed using the 
> >> motherboard-integrated IDE controllers....
> >>
> >> Please note, this troubles appeared first in kernel 
> 2.4.18, and are 
> >> reproducing up to 2.4.20 (i have not tryed 2.4.21-preX nor 2.5.x). 
> >> There where no troubles with any other 2.4.x i tryed 
> (2.4.7, 2.4.14, 
> >> 2.4.17 at least)
> >>
> >> What do you think of this? Where could be the problem? 
> what could i 
> >> do to get more info and solve this problem?
> >>
> >> Thanks to all!
> >>
> >> - --
> >> ! Willy Gardiol - gardiol@libero.it
> >> goemon.polito.it/~gardiol
> >> Use linux for your freedom.
> >>
> >>    Non ho parole, fratelli.    Quaranta paesi bambini    hanno 
> >> attaccato un asilo        e la chiamano guerra.
> >>    Gli eserciti più potenti del mondo    hanno attaccato il più 
> >> straccione.
> >>
> >>     Jack Folla ( 8/10/2001 )   
> >>
> >> -----BEGIN PGP SIGNATURE-----
> >> Version: GnuPG v1.2.1 (GNU/Linux)
> >>
> >> iD8DBQE+bxgnQ9qolN/zUk4RAlF4AJ431AQ7jTaaxJPugtEQTtimaqWZ7QCgryeJ
> >> TpRdVaO97yfsr08v8D6lwB0=
> >> =qUwm
> >> -----END PGP SIGNATURE-----
> >>
> >> -
> >> To unsubscribe from this list: send the line "unsubscribe 
> >> linux-kernel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> Please read the FAQ at  http://www.tux.org/lkml/
> >>
> >>  
> >>
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> 
