Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130360AbQKMX6u>; Mon, 13 Nov 2000 18:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130350AbQKMX6f>; Mon, 13 Nov 2000 18:58:35 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:10244 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130024AbQKMX6P>; Mon, 13 Nov 2000 18:58:15 -0500
Date: Mon, 13 Nov 2000 18:28:08 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: UDMA66/100 errors...
Message-ID: <Pine.LNX.4.21.0011131822090.793-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel == 2.2.17 + ReiserFS + IDE patches

I'm getting the following error when I try and enable UDMA on my
new IBM Deskstar UDMA100 drive:


/dev/hdb:

 Model=IBM-DTLA-307030, FwRev=TX4OA50C, SerialNo=YKDYKGF1437
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=60036480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5


1 root@asdf:/stuff# hdparm -c1m16k1d1X67 /dev/hdb

/dev/hdb:
 setting 32-bit I/O support flag to 1
 setting multcount to 16
 setting using_dma to 1 (on)
 setting keep_settings to 1 (on)
 setting xfermode to 67 (UltraDMA mode3)
ide0: Speed warnings UDMA 3/4/5 is not functional.
 HDIO_DRIVE_CMD(setxfermode) failed: Bad address
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 using_dma    =  1 (on)
 keepsettings =  1 (on)

1 root@asdf:/stuff# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo PRO] (rev 23)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050 (rev 30)
00:11.0 Multimedia video controller: 3Dfx Interactive, Inc. Voodoo (rev 02)
00:12.0 VGA compatible controller: Cirrus Logic GD 5446
00:13.0 Ethernet controller: Winbond Electronics Corp W89C940


I'm using a standard 40pin cable measured at just less than 18 inches.
/dev/hda1 is a Quantum Fireball EL 7.6G.  The setup works at UDMA66
aparently no problem, however if I try to enable UDMA mode 3/4/5 I get
the above error.  Must I use the 80 conductor cable?  Is it safe to use
the 80 pin cable and have both drives plugged into it?  Here is the
stats on the Quantum:

/dev/hda:

 Model=QUANTUM FIREBALL EL7.6A, FwRev=A08.1100, SerialNo=347816714615
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=15907/15/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=418kB, MaxMultSect=16, MultSect=16
 CurCHS=15907/15/63, CurSects=1597178085, LBA=yes, LBAsects=15032115
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2







----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

#[Mike A. Harris bash tip #1 - separate history files per virtual console]
# Put the following at the bottom of your ~/.bash_profile
[ ! -d ~/.bash_histdir ] && mkdir ~/.bash_histdir
tty |grep "^/dev/tty[0-9]" >& /dev/null && \
        export HISTFILE=~/.bash_histdir/.$(tty | sed -e 's/.*\///')

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
