Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbUB2Jha (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 04:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUB2Jha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 04:37:30 -0500
Received: from eta.fastwebnet.it ([213.140.2.50]:27380 "EHLO eta.fastwebnet.it")
	by vger.kernel.org with ESMTP id S262024AbUB2Jh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 04:37:27 -0500
From: Paolo Ornati <ornati@fastwebnet.it>
To: Bill Davidsen <davidsen@tmr.com>, Rik van Riel <riel@redhat.com>
Subject: Re: 2.6.x: iowait problem while burning a CD
Date: Sun, 29 Feb 2004 10:37:53 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200402271802.51604.ornati@fastwebnet.it> <Pine.LNX.4.44.0402271915590.1747-100000@chimarrao.boston.redhat.com> <404118A2.1060301@tmr.com>
In-Reply-To: <404118A2.1060301@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402291037.53521.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 February 2004 23:39, Bill Davidsen wrote:
> >
> > At that point, mkisofs is probably running into a bazillion
> > small files, in subdirectories all over the place.
> >
> > Because a disk seek + track read takes 10ms, it's simply not
> > possible to read more than maybe 100 of these small files a
> > second, so mkisofs can't keep up.
>
> I certainly have seen this, although there is something odd in the
> process with large files as well. I sometimes see it in 2.4 as well, so
> it may be a characteristic of the application.
>
> What to do about it (things to try, not requirements):
>

I was talking about one big file... however:

> - use fs= to increase the size of the fifo a bit, remember to put "m"
>    after the buffer size or it will be taken in bytes. This helps with
>    the problem Rik describes

I have tried with 8 / 16 / 24 MB of buffer! (without big results)

> - be sure DMA is on the CD and the drive

yes

> - allow ints during io

yes

___________________________________________________________
/dev/hdc:
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  1 (on)
 readahead    = 256 (on)

/dev/hdc:

 Model=HL-DT-ST GCE-8400B, FwRev=1.03, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 *mdma2
 AdvancedPM=no
___________________________________________________________

> - I'm told deadline schedular but haven't tried it
> - get a new version of cdrecord, build with the 2.6 headers, use
>    ATAPI:/dev/hdX for dev= instead of ide-scsi (this is probably not
>    critical for data CD in 2.6.2 and later, ide-scsi seems to work)

I have never used IDE-SCSI with 2.6.x ;-)

> - use burn-free

yes


Bye

-- 
	Paolo Ornati
	Linux v2.6.3

