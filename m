Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274351AbRJAAvZ>; Sun, 30 Sep 2001 20:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274362AbRJAAvQ>; Sun, 30 Sep 2001 20:51:16 -0400
Received: from cs666814-197.austin.rr.com ([66.68.14.197]:35569 "EHLO
	kinison.puremagic.com") by vger.kernel.org with ESMTP
	id <S274351AbRJAAu7> convert rfc822-to-8bit; Sun, 30 Sep 2001 20:50:59 -0400
Date: Sun, 30 Sep 2001 19:51:25 -0500 (CDT)
From: Evan Harris <eharris@puremagic.com>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: RAID5: mkraid --force /dev/md0 doesn't work properly
In-Reply-To: <20011001024130.A24589@unthought.net>
Message-ID: <Pine.LNX.4.33.0109301944430.2459-100000@kinison.puremagic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the fast reply!

I'm not sure I understand why drive 5 should be failed.  It is one of the
four disks with the most recently correct superblocks.  The disk with the
oldest superblock is #1.  Can you point me to documentation which explains
this better?  I'm a little afraid of doing that without reading more on it,
since it seems to mark yet another of the 4 remaining "good" drives as
"bad".

Also, should the failed-disk directive be substituted for the raid-disk
directive (as your example was), or should it be:

       device                   /dev/sdd1
       raid-disk                0
       device                   /dev/sde1
       raid-disk                1
       device                   /dev/sdf1
       raid-disk                2
       device                   /dev/sdg1
       raid-disk                3
       device                   /dev/sdh1
       raid-disk                4
       device                   /dev/sdi1
       raid-disk		5
       failed-disk              5

or should it really be:

       device                   /dev/sdd1
       raid-disk                0
       device                   /dev/sde1
       raid-disk                1
       failed-disk              1
       device                   /dev/sdf1
       raid-disk                2
       device                   /dev/sdg1
       raid-disk                3
       device                   /dev/sdh1
       raid-disk                4
       device                   /dev/sdi1
       raid-disk                5

Thanks!

Evan

-- 
| Evan Harris - Consultant, Harris Enterprises - eharris@puremagic.com
|
| Custom Solutions for your Software, Networking, and Telephony Needs

On Mon, 1 Oct 2001, Jakob Østergaard wrote:

> On Sun, Sep 30, 2001 at 07:29:06PM -0500, Evan Harris wrote:
> >
> > And yes, I'm using the real --force option.  :)
>
> Good (hush now, it's a secret ;)
>
> >
> > I have a 6 disk RAID5 scsi array that had one disk go offline through a
> > dying power supply, taking the array into degraded mode, and then another
> > went offline a couple of hours later from what I think was a loose cable.
> >
> > The first drive to go offline was /dev/sde1.
> > The second to go offline was /dev/sdd1.
> >
> > Both drives are actually fine after fixing the connection problems and a
> > reboot, but since the superblocks are out of sync, it won't init.
>
> Ok.
>
> ...
> [huge snip]
> ...
> >
> > I set the first disk that went offline out with a failed-disk directive, and
> > tried to recover with a:
> >
> > mkraid --force /dev/md0
>
> Good !
>
> (to anyone reading this without having read the docs:  don't pull this trick
>  unless you absolutely positively understand the consequences of screwing up
>  here)
>
> >
> > I'm _positive_ that the /etc/raidtab is correct, but it fails to force the
> > update with:
> >
> > DESTROYING the contents of /dev/md0 in 5 seconds, Ctrl-C if unsure!
> > handling MD device /dev/md0
> > analyzing super-block
> > raid_disk conflict on /dev/sde1 and /dev/sdi1 (1)
> > mkraid: aborted, see the syslog and /proc/mdstat for potential clues.
> ...
>
> Read on
>
>
> [snip]
> > For info, here is my raidtab:
> >
> > raiddev /dev/md0
> >         raid-level              5
> >         nr-raid-disks           6
> >         nr-spare-disks          0
> >         chunk-size              256
> >         persistent-superblock   1
> >         device                  /dev/sdd1
> >         raid-disk               0
> >         device                  /dev/sde1
> >         raid-disk               1
> >         device                  /dev/sdf1
> >         raid-disk               2
> >         device                  /dev/sdg1
> >         raid-disk               3
> >         device                  /dev/sdh1
> >         raid-disk               4
> >         device                  /dev/sdi1
> >         raid-disk               5
> >         failed-disk     1
>
>
> Wrong !   device /dev/sdi1 is railed-disk 5 not failed-disk 1,
> that's why mkraid is confused.
>
> What you want is:
>       device                  /dev/sdd1
>       raid-disk               0
>       device                  /dev/sde1
>       raid-disk               1
>       device                  /dev/sdf1
>       raid-disk               2
>       device                  /dev/sdg1
>       raid-disk               3
>       device                  /dev/sdh1
>       raid-disk               4
>       device                  /dev/sdi1
>       failed-disk               5
>
>
> Good luck,
>
> --
> ................................................................
> :   jakob@unthought.net   : And I see the elder races,         :
> :.........................: putrid forms of man                :
> :   Jakob Østergaard      : See him rise and claim the earth,  :
> :        OZ9ABN           : his downfall is at hand.           :
> :.........................:............{Konkhra}...............:
>

