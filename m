Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130211AbRCFJfY>; Tue, 6 Mar 2001 04:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130083AbRCFJfO>; Tue, 6 Mar 2001 04:35:14 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:54278 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130082AbRCFJfE>;
	Tue, 6 Mar 2001 04:35:04 -0500
Date: Tue, 6 Mar 2001 10:34:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-ac12 unknown southbridge
Message-ID: <20010306103435.A1339@suse.cz>
In-Reply-To: <20010306101654.A1281@suse.cz> <Pine.LNX.4.33.0103061020310.2291-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0103061020310.2291-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Tue, Mar 06, 2001 at 10:29:00AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2001 at 10:29:00AM +0100, Mike Galbraith wrote:
> On Tue, 6 Mar 2001, Vojtech Pavlik wrote:
> 
> > On Tue, Mar 06, 2001 at 10:09:05AM +0100, Mike Galbraith wrote:
> >
> > > The driver forget what it always called a vt82c596b before.  Reverting
> > > the below brought it back on-line, and all seems well again.  (hope I
> > > don't receive any unpleasant suprises.. I've not the foggiest clue what
> > > that number means;)
> > >
> > > -	{ "vt82c596b",	PCI_DEVICE_ID_VIA_82C596,   0x12, 0x2f, VIA_UDMA_66 },
> > > +	{ "vt82c596b",	PCI_DEVICE_ID_VIA_82C596,   0x10, 0x2f, VIA_UDMA_66 },
> >
> > Can you verify it's a 596b and not 596a? Preferably by looking on the
> > chip? This change was brought in because I wasn't sure for the 10 and 11
> > revisions. 586a doesn't have a functional UDMA66 engine and causes
> > crashes if programmed to UDMA66.
> 
> *blur* SQUINT (I _definitely_ need new glasses) it's a 596b.
> 
> Probably dumb question wrt hdparm -i output...
> 
> /dev/hda:
> 
>  Model=IBM-DJNA-352030, FwRev=J58OA30K, SerialNo=GQ0GQFP8740
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
>  BuffType=DualPortCache, BuffSize=1966kB, MaxMultSect=16, MultSect=off
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39876480
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
> 
> Why is it defaulting to udma4, and :) why the heck does it work?

Thanks. That means your change is correct. I'll send an update to Alan.

-- 
Vojtech Pavlik
SuSE Labs
