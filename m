Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286267AbRLTOvh>; Thu, 20 Dec 2001 09:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286266AbRLTOv1>; Thu, 20 Dec 2001 09:51:27 -0500
Received: from mail5.speakeasy.net ([216.254.0.205]:26248 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP
	id <S286261AbRLTOvQ> convert rfc822-to-8bit; Thu, 20 Dec 2001 09:51:16 -0500
Subject: Re: Poor performance during disk writes
From: safemode <safemode@speakeasy.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Helge Hafting <helgehaf@idb.hist.no>, jlm <jsado@mediaone.net>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011220132729Z286241-18285+3296@vger.kernel.org>
In-Reply-To: <20011220132729Z286241-18285+3296@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 20 Dec 2001 09:51:14 -0500
Message-Id: <1008859875.2857.0.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-12-20 at 08:27, Dieter Nützel wrote:
> On Thursday, 20.12.201, 10:49 Helge Hafting wrote:
> > jlm wrote:
> [-]
> > > So I guess I don't really care what mode the hard drive is operating in
> > > (udma, mdma, dma or plain ide), I just don't want to have to go get a
> > > cup of coffee while the hard drive saves some data. Is there a "don't
> >
> > Devices generally get the cpu before anything else.  A good disk system
> > don't need much cpu.  Running IDE in PIO mode require a lot
> > of cpu though.   Using any of the DMA modes avoids that.
> 
> Amen..
> Sorry, Helge sure you are right in theory but try dbench 32 (maybe 
> bonnie/bonnie++) and playing an MP3/Ogg-Vorbis in parallel...
> That's my first test on any "new" kernel version.
> 
> Even with an 1 GHz Athlon II, 640 MB, U160 DDYS 18 GB, 10k IBM disk (on an 
> AHA-2940UW) it stutters like mad. I am running all my kernel _with_ Robert 
> Love's preempt + lock-break patches and it doesn't solve the problem.
> CPU load is (very) low but it do not work like it should.

try it with vanilla 2.4.17-rc1.  I just did and i'm getting no
stuttering at all.   nice -n 20 dbench 32.   Worked quite nicely. Of
course i'm using an ext3 fs which is more important than your cpu speed
or ram.   This kind of discussion has been talked about and argued over
many times in the past here already.  Too many factors go into this and
in the end,  dbench is _Meant_ to preempt everything else.  if you want
a real test find a real program you really use and use it.  


 
> > > pre-empt the rest of the system" switch for the eide drives? Is there
> > > something fundamental/unique going on here that I'm missing?
> > dma, udma, etc. is that switch.  It lets the cpu do other work (such as
> > redrawing X) while the disk is busy.  Plain ide is what you don't want.
> 
> See above the whole system show some bad hiccup.
> 
> > The problem of waiting for other files or swapping while a really big
> > write is going on is different.  Get more drives, so the big writes go
> > to one drive while you get stuff swapped in (or other file access)
> > on other drive(s).  The kernel is capable of getting fast response
> > from one drive while another is completely bogged down with
> > enormous writes.
> 
> Tried this already. Neither I put my test files (MP3/Ogg-Vorbis) in /dev/shm 
> or a nother disk it do not change anything.
> 
> There must be something in the VFS?
> 
> -Dieter
> 
> -- 
> Dieter Nützel
> Graduate Student, Computer Science
> University of Hamburg
> @home: Dieter.Nuetzel@hamburg.de
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


