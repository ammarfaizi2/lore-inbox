Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285747AbRLTBi6>; Wed, 19 Dec 2001 20:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285754AbRLTBit>; Wed, 19 Dec 2001 20:38:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62188 "EHLO
	VL-MS-MR002.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S285747AbRLTBig>; Wed, 19 Dec 2001 20:38:36 -0500
Date: Wed, 19 Dec 2001 20:38:04 -0500
From: Jean-Francois Levesque <jfl@jfworld.net>
To: GOTO Masanori <gotom@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UDMA problem with Maxtor 7200rpm disk
Message-Id: <20011219203804.4c68f1ee.jfl@jfworld.net>
In-Reply-To: <w53k7viy91z.wl@megaela.fe.dis.titech.ac.jp>
In-Reply-To: <20011219151636.50e930ac.jfl@jfworld.net>
	<w53k7viy91z.wl@megaela.fe.dis.titech.ac.jp>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My disk is supposed to support ATA66 and ATA100...

I tried User Defined HD in the BIOS.  Changed PIO from 4 to 1...  and I also tried DMA 5,4,2,disabled...  (And I tried 'auto' disk detection)

Always same error...

I also got problems while trying to install RH 7.2...  Unabled to finish installation because it gave me I/O error while formatting /boot partition.

Any more ideas?

Thanks for your help!

Jean-François


On Thu, 20 Dec 2001 10:28:08 +0900
GOTO Masanori <gotom@debian.org> wrote:

> At Wed, 19 Dec 2001 15:16:36 -0500,
> Jean-Francois Levesque <jfl@jfworld.net> wrote:
> > I have a problem regarding my new Asus A7V266 board with VIA KT266 chipset.  Byron Stanoszek told me to ask my problem to this list so here it is :
> > 
> > My hard drive is a Maxtor 5T030H3 ATA DISK drive (30 gig).  The problem is that I'm not able to read more than 7 MB/sec :
> > 
> > [root@xyz jfl]# /sbin/hdparm -t /dev/hda
> > 
> > /dev/hda:
> >  Timing buffered disk reads:  64 MB in  9.18 seconds =  6.97 MB/sec
> > 
> > 
> > [root@xyz jfl]# /sbin/hdparm -d1 -X66 /dev/hda
> > 
> > /dev/hda:
> >  setting using_dma to 1 (on)
> >  setting xfermode to 66 (UltraDMA mode2)
> >  using_dma    =  1 (on)
> > [root@xyz jfl]# /sbin/hdparm -t /dev/hda
> > 
> > /dev/hda:
> >  Timing buffered disk reads:  64 MB in  9.70 seconds =  6.60 MB/sec
> > 
> > [root@xyz jfl]# /sbin/hdparm /dev/hda
> > 
> > /dev/hda:
> >  multcount    = 16 (on)
> >  I/O support  =  1 (32-bit)
> >  unmaskirq    =  1 (on)
> >  using_dma    =  0 (off)
> >  keepsettings =  0 (off)
> >  nowerr       =  0 (off)
> >  readonly     =  0 (off)
> >  readahead    =  8 (on)
> >  geometry     = 3736/255/63, sectors = 60030432, start = 0
> > [root@xyz jfl]#
> > 
> > I also have some idebus errors.
> > 
> > The problem seems to be the DMA (ATA100 compatible board and disk).
> 
> BIOS parameter of your machine is set as "DISK auto detection" ?  If
> you so, would you try to change your BIOS setting as "this disk have
> ultra DMA mode 4 (or 5, if your disk is ATA100)" explicitly ?
> 
> These behavior is very similar to my enviroment.
> I have Asus KT133A board, and I had this problem, but I changed BIOS
> setting, all problems were gone and became happy.
> If my suggestion is totally wrong, I apologize...
> (However, if my suggestion is relevant, then what's the problem?
>  IDE driver, or hardware problem?)
> 
> > PS: My disk also "freeze" my system for a few seconds (from 1/2 to maybe 3sec) while checking some data.
> 
> IMHO, the reason is that writing disk with PIO mode 4 (IIRC, 6.60MB/s
> is corresponding with PIO mode 4) invites CPU occupation.
> Andrew Morton also fixed 'low latency read problem', which is already
> resolved the latest 2.4.17-rc2.
> 
> -- gotom
