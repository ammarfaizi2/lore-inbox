Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129283AbRCBQJa>; Fri, 2 Mar 2001 11:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbRCBQJV>; Fri, 2 Mar 2001 11:09:21 -0500
Received: from [212.12.57.226] ([212.12.57.226]:60420 "HELO spot.local")
	by vger.kernel.org with SMTP id <S129283AbRCBQJG>;
	Fri, 2 Mar 2001 11:09:06 -0500
Date: Fri, 2 Mar 2001 17:10:49 +0100
From: Oliver Feiler <kiza@lionking.org>
To: linux-kernel@vger.kernel.org
Subject: Mixing UDMA33/66 drives, VIA IDE, Linux 2.2.18
Message-ID: <20010302171049.A555@lionking.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.18 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I've run into a problem while using the follwing different drives:
IBM-DTTA-351010 and IBM-DJNA-351520. The first one is a UDMA33 drive and the 
second one seems to be a UDMA66 capable drive, UDMA4. I have attached a 
"hdparm -i" of both drives at the end of the mail.

	Both drives are connected to the same IDE channel on a VIA686A board 
with a 80pin IDE cable. When I try to access the UDMA33 drive I get:

Mar  2 16:08:30 kiza kernel: hda: irq timeout: status=0x58 { DriveReady 
SeekComplete DataRequest }
Mar  2 16:08:41 kiza kernel: hda: timeout waiting for DMA
Mar  2 16:08:41 kiza kernel: hda: irq timeout: status=0x58 { DriveReady 
SeekComplete DataRequest }
Mar  2 16:08:51 kiza kernel: hda: timeout waiting for DMA
Mar  2 16:08:51 kiza kernel: hda: irq timeout: status=0x58 { DriveReady 
SeekComplete DataRequest }
Mar  2 16:09:01 kiza kernel: hda: timeout waiting for DMA
Mar  2 16:09:01 kiza kernel: hda: irq timeout: status=0x58 { DriveReady 
SeekComplete DataRequest }
Mar  2 16:09:01 kiza kernel: hda: DMA disabled
Mar  2 16:09:01 kiza kernel: hdb: DMA disabled
Mar  2 16:09:01 kiza kernel: ide0: reset: success

	and the system continues to work with DMA disabled.

	If I use a 40pin cable to connect the drives there are no problems. If 
I try to set -X66 with hdparm for the UDMA66 disk (that should set UDMA33 
mode, right?) and use the 80 pin cable the problem is not solved.

	The problem seems to be the 80 pin cable. Can't the drives operate in 
different modes independently? Setting a slower transfer mode with hdparm does 
not work. Can it be set otherwise? With a kernel parameter?

	I'm using 2.2.18 with the IDE driver that came with it. Is this maybe 
a problem that was solved in 2.4?

	Or is it just a theoretical "that will not work" problem? :)

Thanks for any help.

Oliver


Output of hdparm -i for both drives. Both are connected with a 40pin cable 
this time:

 Model=IBM-DTTA-351010, FwRev=T56OA73A, SerialNo=WF0KFTR8113
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=466kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=19807200
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2 

 Model=IBM-DJNA-351520, FwRev=J56OA30K, SerialNo=G80GLW69191
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=430kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=30033360
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 



-- 
Oliver Feiler                                               kiza@gmx.net
http://www.lionking.org/~kiza/pgpkey              PGP key ID: 0x561D4FD2
http://www.lionking.org/~kiza/
