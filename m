Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317063AbSEXBG3>; Thu, 23 May 2002 21:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317064AbSEXBG2>; Thu, 23 May 2002 21:06:28 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:51211
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317063AbSEXBG1> convert rfc822-to-8bit; Thu, 23 May 2002 21:06:27 -0400
Date: Thu, 23 May 2002 18:04:36 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
cc: Vojtech Pavlik <vojtech@suse.cz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] Re: IDE problem: linux-2.5.17
In-Reply-To: <20020524022351.A8230@bouton.inet6-interne.fr>
Message-ID: <Pine.LNX.4.10.10205231803370.22581-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well now you know the use of the pass throught diagnotics interface of the
deleted IOCTL.  You could get there from here but not anymore.

On Fri, 24 May 2002, Lionel Bouton wrote:

> On Fri, May 24, 2002 at 12:55:25AM +0200, Vojtech Pavlik wrote:
> > 
> > If you rewrite the whole drive with zeros (or the original data) sector
> > by sector, the uncorrectable errors will go away. I've done this to my
> > 307030 and it works fine again. (Fortunately for me the errors were only
> > in my swap partition).
> > 
> 
> Don't know for the whole drive yet (currently running) but when I did a mkraid
> on a raid5 array using 4 partitions on the same drive the sync thread ended
> and left the array in degraded mode after a bunch of :
> May 24 02:05:06 twins kernel: hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> May 24 02:05:06 twins kernel: hdd: dma_intr: error=0x40 { UncorrectableError }, LBA sect=2097375, sector=2097298
> May 24 02:05:06 twins kernel: end_request: I/O error, dev 16:41 (hdd), sector 2097298
> 
> Then I tried to zero the offending sectors with a slight margin :
> [root@twins root]# dd if=/dev/zero of=/dev/hdd1 count=200 bs=512 seek=2097200
> dd: writing /dev/hdd1': Erreur d'entrée/sortie
> 113+0 enregistrements lus.
> 112+0 enregistrements écrits.
> 
> Same error each time, seems sector 2097312 is not my friend.
> 
> dd if=/dev/zero of=/dev/hdd bs=<cylinder_size> running.
> 
> Too bad lsof doesn't show offsets...
> I can't tell if dd passed the offending sector :-|
> 
> LB.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

