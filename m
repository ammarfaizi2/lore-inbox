Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274411AbRITKiQ>; Thu, 20 Sep 2001 06:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274412AbRITKiG>; Thu, 20 Sep 2001 06:38:06 -0400
Received: from unthought.net ([212.97.129.24]:38021 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S274411AbRITKh7>;
	Thu, 20 Sep 2001 06:37:59 -0400
Date: Thu, 20 Sep 2001 12:38:23 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: David Hajek <david@atrey.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: high cpu load with sw raid1
Message-ID: <20010920123823.B17911@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	David Hajek <david@atrey.karlin.mff.cuni.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010920102616.A2753@pida.ulita.cz> <20010920111048.B17066@unthought.net> <20010920112342.A3253@pida.ulita.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20010920112342.A3253@pida.ulita.cz>; from david@atrey.karlin.mff.cuni.cz on Thu, Sep 20, 2001 at 11:23:42AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 11:23:42AM +0200, David Hajek wrote:
> Inlined.
> 
> On Thu, Sep 20, 2001, Jakob Rstergaard wrote:
> > On Thu, Sep 20, 2001 at 10:26:16AM +0200, David Hajek wrote:
> > > Hi,
> > > 
> > > I have linux box with 70GB SW Raid1. This box runs for half
> > > a year without problems but now I meet the high cpu load 
> > > problems. I suspect that it can be caused by not enough 
> > > free disk space on this md device. I see following:
> > > 
> > > 1 GB free  - load > 5
> > > 5 GB free  - load < 1
> > 
> > RAID does not know about "free space" (that is a filesystem thing), so that
> > would be either some strange interaction between the filesystem and lower
> > layers, or a measurement error - I guess.
> > 
> > High fragmentation could lead to extra filesystem activity, but that's not
> > really something the RAID can influence.
> 
> Why not? I do not say that it is cause be the RAID. It can be caused
> by filesystem. Do you think that fsck helps to defrag filesystem?

Ok, I was just trying to rule out the RAID.

I know for a fact that fsck does not defrag the filesystem.  However, if you
do run fsck, it will tell you how much is fragmented.

A few percent shouldn't matter.  But see what the fragmentation is when you
have only one gig available, compared to when you have five.

...
> 
> I use SCSI disks for this raid. Here is the output:
> 
> [root@marvin /root]# hdparm /dev/sda
> 
> /dev/sda:
>  readonly     =  0 (off)
>  geometry     = 8924/255/63, sectors = 143374738, start = 0
> [root@marvin /root]# hdparm -t /dev/sda
> 
>   /dev/sda:
>    Timing buffered disk reads:  64 MB in  1.87 seconds = 34.22 MB/sec
> [root@marvin /root]#   

Oh, silly me.  I'm mixing up mails here...  Sure, with SCSI you'll be fine.

> 
> I think disk speeds are ok - it works for really fine for half a year.

Yep.

If everything is slowed down by disk seeks due to high fragmentation, you
should actually be able to hear your disks seek like mad when the load is high.
Throughput doesn't matter much in that case - have you noticed the sound of
disk-heads (sonic booms, heads catching on fire, etc.)  ?

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
