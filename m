Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284664AbRLRSzp>; Tue, 18 Dec 2001 13:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284753AbRLRSyO>; Tue, 18 Dec 2001 13:54:14 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:43761 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S284604AbRLRSxC>;
	Tue, 18 Dec 2001 13:53:02 -0500
Date: Tue, 18 Dec 2001 11:52:43 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Doug Ledford <dledford@redhat.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
Message-ID: <20011218115243.Y855@lynx.no>
Mail-Followup-To: Doug Ledford <dledford@redhat.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112181216341.1237-100000@admin> <Pine.LNX.4.33.0112180922500.2867-100000@penguin.transmeta.com> <20011218105459.X855@lynx.no> <3C1F8A9E.3050409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C1F8A9E.3050409@redhat.com>; from dledford@redhat.com on Tue, Dec 18, 2001 at 01:27:42PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 18, 2001  13:27 -0500, Doug Ledford wrote:
> Andreas Dilger wrote:
> > Yes, esd is an interrupt hog, it seems.  When reading this thread, I
> > checked, and sure enough I was getting 190 interrupts/sec on the
> > sound card while not playing any sound.  I killed esd (which I don't
> > use anyways), and interrupts went to 0/sec when not playing sound.
> > Still at 190/sec when using mpg123 on my ymfpci (Yamaha YMF744B DS-1S)
> > sound card.
> 
> Weel, evidently esd and artsd both do this (well, I assume esd does now, it 
> didn't do this in the past).  Basically, they both transmit silence over the 
> sound chip when nothing else is going on.  So even though you don't hear 
> anything, the same sound output DMA is taking place.  That avoids things 
> like nasty pops when you start up the sound hardware for a beep and that 
> sort of thing.

Hmm, I _do_ notice a pop when the sound hardware is first initialized at
boot time, but not when mpg123 starts/stops (without esd running) so I
personally don't get any benefit from "the sound of silence".  That said,
asside from the 190 interrupts/sec from esd, it doesn't appear to use any
measurable CPU time by itself.

> Context switches per second not playing any sound: 8300 - 8800
> Context switches per second playing an MP3: 9200 - 9900

Hmm, something seems very strange there.  On an idle system, I get about
100 context switches/sec, and about 150/sec when playing sound (up to 400/sec
when moving the mouse between windows).  9000 cswitches/sec is _very_ high.
This is with a text-only player which has screen output (other than the
ID3 info from the currently played song).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

