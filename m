Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313167AbSEAQfz>; Wed, 1 May 2002 12:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313448AbSEAQfy>; Wed, 1 May 2002 12:35:54 -0400
Received: from unthought.net ([212.97.129.24]:1672 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S313167AbSEAQfy>;
	Wed, 1 May 2002 12:35:54 -0400
Date: Wed, 1 May 2002 18:35:53 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Kent Borg <kentborg@borg.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
        Jaime Medrano <overflow@eurielec.etsit.upm.es>,
        linux-kernel@vger.kernel.org
Subject: Re: raid1 performance
Message-ID: <20020501183553.D31556@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Kent Borg <kentborg@borg.org>, Arjan van de Ven <arjanv@redhat.com>,
	Jaime Medrano <overflow@eurielec.etsit.upm.es>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204301411210.4658-100000@cuatro.eurielec.etsit.upm.es> <3CCE9038.F4C830B4@redhat.com> <20020430102148.D4470@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002 at 10:21:48AM -0400, Kent Borg wrote:
> On Tue, Apr 30, 2002 at 01:38:16PM +0100, Arjan van de Ven wrote, very
> roughly: 
> [that RAID 1 is only as fast in reading as the fastest disk because of
> seeking over alternate blocks, and ]
> 
> > The only way to get the "1 thread sequential read" case faster is by
> > modifying the disk layout to be
> > 
> > Disk 1: ACEGIKBDFHJ
> > Disk 2: ACEGIKBDFHJ
> > 
> > where disk 1 again reads block A, and disk 2 reads block B.  To read
> > block C, disk 1 doesn't have to move it's head or read a dummy block
> > away, it can read block C sequention, and disk 2 can read block D
> > that way.
> >
> > That way the disks actually each only read the relevant blocks in a
> > sequential way and you get (in theory) 2x the performance of 1 disk.
> 
> I am confused.  
> 
> Assuming a big enough read is requested to allow a parallelizing to
> two disks, why can't the second disk be told not to read alternate
> blocks but to start reading sequential blocks starting half way up the
> request?

This is *not* as simple as it sounds.  Believe me, I spent a week trying...

However, with ext2 (and other filesystems as well), a large sequential file
read is *not* sequential on the disk.  You should actually see better performance
on RAID-1 than on a single disk for very large reads, becuase some of the lookups
needed (block indirection or whatever) will be run by the "best" disk in the given
situation.

> 
> Also, why does hdparm give me significantly faster read numbers on
> /dev/md<whatever> than it does on /dev/hd<whatever>?  I had assumed
> there was parallelizing going on.  Does this mean I would get a speed
> improvement if I ran my single disk notebook as a single disk RAID 1
> because there is some bigger or better buffering going on in that code
> even without parallelizing?

hdparm is not a good benchmark for this.

Use bonnie, bonnie++, tiotest, or even 'dd' with *huge* files.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
