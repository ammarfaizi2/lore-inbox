Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBGMXr>; Wed, 7 Feb 2001 07:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRBGMXi>; Wed, 7 Feb 2001 07:23:38 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:45586 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129044AbRBGMXb>;
	Wed, 7 Feb 2001 07:23:31 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Wed, 7 Feb 2001 13:22:13 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: VIA silent disk corruption - fixed for me
CC: pdh@colonel-panic.com, andre@linux-ide.org, sorisor@hell.wh8.tu-dresden.de
X-mailer: Pegasus Mail v3.40
Message-ID: <14CC8D943BE7@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote on 6 Feb evening CET:
> On  6 Feb 01 at 15:24, Udo A. Steinberg wrote:
> > 
> > > So for today I'm back on [UMS]DMA disabled. I'll try downgrading BIOS
> > > today, but it looks to me like that something is severely broken here.
> > 
> > Are your drives connected to the VIA or the Promise controller? Mine
> > are both connected to the PDC20265 and running in UDMA-100 mode. There
> > have been several threads on lkml about corruption on disks connected
> > to Via chipset IDE controllers, although I didn't follow them in great
> > detail. Maybe your problem is not related to the host bridge, but to
> > the IDE controller?
> 
> They are connected to Promise, I reserved VIA for CDROM drive.
> One HDD runs in UDMA5 mode, another in UDMA2. Corruption is often
> when I run md5sum in parallel on both HDDs - in that case almost
> no file generates same checksum which was generated using PIO4.
> When I run md5sum on only one HDD, there are about 4 checksum errors
> in 6GB of data. But I'm more and more inclined to throw this A7V away,
> as it is impossible to get datasheet from Promise, and for VIA host
> bridge I was just able to slow down normal system operation by factor
> of 3... but still with same corruption :-( Just if page could have
> 4092 and not 4096 bytes ;-)

After upgrading BIOS (it did not help) I decided to switch my secondary
harddisk to master. And voila - hde running UDMA5, hdg running UDMA2
(hdf/hdh does not exist), whole night stresstests, no corruption.

So at least for me it means that Promise Linux driver does not support
slave-only configuration. I did not checked whether master-slave pair
works, but master alone for sure works for me.

That is, for me problem was not in VIA bridge, but in PDC20265 driver...
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
