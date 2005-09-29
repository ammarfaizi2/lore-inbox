Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbVI2Vaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVI2Vaf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVI2Vae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:30:34 -0400
Received: from torrent.CC.McGill.CA ([132.206.27.49]:35549 "EHLO
	torrent.cc.mcgill.ca") by vger.kernel.org with ESMTP
	id S1751334AbVI2Vad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:30:33 -0400
Subject: Re: problem with 2.6.13.[0-2]
From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Reply-To: David.Ronis@mcgill.ca
To: Jean Delvare <khali@linux-fr.org>
Cc: David Ronis <David.Ronis@mcgill.ca>, LKML <linux-kernel@vger.kernel.org>,
       Parag Warudkar <kernel-stuff@comcast.net>, linux-ide@vger.kernel.org
In-Reply-To: <20050929082048.0cca3f58.khali@linux-fr.org>
References: <Pine.WNT.4.63.0509272247550.2588@home-comp>
	 <1127957830.6261.5.camel@montroll.chem.mcgill.ca>
	 <20050929082048.0cca3f58.khali@linux-fr.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Department of Chemistry, McGill University
Date: Thu, 29 Sep 2005 17:26:58 -0400
Message-Id: <1128029218.15252.16.camel@montroll.chem.mcgill.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

I'm sending this to the linux-ide list as suggested, so first a very
brief summary of the problem:

                I'm running a hp pavillion ZV5240ca laptop.  The kernel
                has the ATIIXP driver installed, and this is what is
                loaded for the hard-drive (according to lshw).  On
                upgrading from 2.6.12.6 to 2.6.13.[0-2] I noticed a huge
                slowdown in disk performance (see below for timings) and
                have been getting some help tracking the problem down on
                the linux-kernel list.  (I don't subscribe to either
                list so please CC me).
                
Ok, bakc to Jean.  I tried your suggestion; here's what I get running
hdparm -i /dev/hda

On 2.6.12.6:

/dev/hda:

 Model=ST9100823A, FwRev=3.00, SerialNo=3LG0V6AP
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=195371568
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: unknown setting WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2: 

 * signifies the current active mode

On 2.6.13.2:

/dev/hda:

 Model=ST9100823A, FwRev=3.00, SerialNo=3LG0V6AP
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=195371568
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: unknown setting WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2: 

 * signifies the current active mode

They are identical except for the MultSect field (which was already
apparent from the simple hdparm output).  As I wrote earlier, I tried
changing it to 16 in 2.6.13.2, but it made a next to no change in the
timings.

I will post the full dmesg output next time I reboot, but greping for
hda or ide0 shows nothing out of the ordinary, at least to me.


David


On Thu, 2005-09-29 at 08:20 +0200, Jean Delvare wrote:
> Hi David,
> 
> [David Ronis]
> > In 2.6.12.6:
> > 
> > /dev/hda:
> >  Timing cached reads:   1140 MB in  2.00 seconds = 569.80 MB/sec
> >  Timing buffered disk reads:  102 MB in  3.02 seconds =  33.80 MB/sec
> > 
> > In 2.6.13.2:
> > 
> > /dev/hda:
> >  Timing cached reads:    28 MB in  2.15 seconds =  13.03 MB/sec
> >  Timing buffered disk reads:   14 MB in  3.30 seconds =   4.24 MB/sec
> > 
> > and after hdparm -m 16 /dev/hda (recall this is the default in 2.6.12.6)
> > 
> > /dev/hda:
> >  Timing cached reads:    24 MB in  2.05 seconds =  11.73 MB/sec
> >  Timing buffered disk reads:   36 MB in  3.11 seconds =  11.56 MB/sec
> > 
> > I ran thing a few times in each case and the results were close.  There
> > was nothing in dmesg.
> 
> Try hdparm -i /dev/hda on both kernels, this will tell you the
> controller/drive operation mode:
> 
>  PIO modes:  pio0 pio1 pio2 pio3 pio4 
>  DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
>  * signifies the current active mode
> 
> I expect you to find that your IDE controller is in UDMA mode on
> 2.6.12.6 but not on 2.6.13.2. The figures you obtain for the latter
> suggest mdma2 (those max throughput is 16 MB/sec IIRC) at best.
> 
> If I'm right, then you will have to find out which driver your IDE
> controller uses, and why it decided that UDMA was no good for your
> controller/driver combination. You may want to try the linux-ide list
> for a more assistance, my own knowledge of that matter stops here ;)
> 

