Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270663AbTGNRod (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270704AbTGNRod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:44:33 -0400
Received: from greenie.frogspace.net ([64.6.248.2]:9710 "EHLO
	greenie.frogspace.net") by vger.kernel.org with ESMTP
	id S270663AbTGNRoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:44:32 -0400
Date: Mon, 14 Jul 2003 10:59:14 -0700 (PDT)
From: Peter <cogwepeter@cogweb.net>
X-X-Sender: cogwepeter@greenie.frogspace.net
To: linux-kernel@vger.kernel.org
Subject: Trying to get DMA working with IDE alim15x3 controller
In-Reply-To: <Pine.LNX.4.44.0307140015390.9819-100000@greenie.frogspace.net>
Message-ID: <Pine.LNX.4.44.0307141055060.5673-100000@greenie.frogspace.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is on the ALim15x3 with the 2.5.69 kernel on a vpr matrix 200a5 
laptop -- I just did this to get DMA5:

    *  set ide0=ata66 in lilo to get the 100MHz bus and DMA5
    *  add "hdparm -c 1 -m 16 -S 242 -k 1 /dev/hda" to /etc/init.d/bootmisc.sh

Nice results:

hda: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=77520/16/63, UDMA(100)

# hdparm -i /dev/hda

    /dev/hda:

     Model=IC25N040ATCS04-0, FwRev=CA4OA71A, SerialNo=CSH405DCLW5UVB
     Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
     RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
     BuffType=DualPortCache, BuffSize=1768kB, MaxMultSect=16, MultSect=16
     CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78140160
     IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
     PIO modes:  pio0 pio1 pio2 pio3 pio4
     DMA modes:  mdma0 mdma1 mdma2
     UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
     AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
     Drive conforms to: ATA/ATAPI-5 T13 1321D revision 3:  2 3 4 5

# hdparm -tT /dev/hda

    /dev/hda:
     Timing buffer-cache reads:   128 MB in  0.45 seconds =283.23 MB/sec
     Timing buffered disk reads:  64 MB in  3.23 seconds = 19.79 MB/sec

# hdparm /dev/hda

    /dev/hda:
     multcount    = 16 (on)
     IO_support   =  1 (32-bit)
     unmaskirq    =  0 (off)
     using_dma    =  1 (on)
     keepsettings =  1 (on)
     readonly     =  0 (off)
     readahead    = 256 (on)
     geometry     = 11984/16/63, sectors = 78140160, start = 0

Cheers,
Peter


