Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274627AbRJAGZ3>; Mon, 1 Oct 2001 02:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274628AbRJAGZU>; Mon, 1 Oct 2001 02:25:20 -0400
Received: from cs666814-197.austin.rr.com ([66.68.14.197]:58867 "EHLO
	kinison.puremagic.com") by vger.kernel.org with ESMTP
	id <S274627AbRJAGZR> convert rfc822-to-8bit; Mon, 1 Oct 2001 02:25:17 -0400
Date: Mon, 1 Oct 2001 01:25:42 -0500 (CDT)
From: Evan Harris <eharris@puremagic.com>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: RAID5: mkraid --force /dev/md0 doesn't work properly
In-Reply-To: <20011001055619.B24589@unthought.net>
Message-ID: <Pine.LNX.4.33.0110010113420.2459-100000@kinison.puremagic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, thanks.  I did that and it worked.  But I have (unfortunately) one more
question about how raid disks are used.  I've now remade the restarted the
raid, having left the oldest drive (/dev/sde1) as a failed-disk.  I do a
raidhotadd /dev/md0 /dev/sde1, and this starts the raid parity rebuild and
gives this status in /proc/mdstat:

md0 : active raid5 sde1[6] sdi1[5] sdh1[4] sdg1[3] sdf1[2] sdd1[0]
      179203840 blocks level 5, 256k chunk, algorithm 0 [6/5] [U_UUUU]
      [=>...................]  recovery =  8.4% (3023688/35840768)
finish=88.9min speed=6148K/sec

Now, my question is: the hotadd seems to have reordered the disks, so when
the rebuild is completed, do I need to reorder my raidtab to reflect this?
Like this?

        device                  /dev/sdd1
        raid-disk               0
        device                  /dev/sdf1
        raid-disk               1
        device                  /dev/sdg1
        raid-disk               2
        device                  /dev/sdh1
        raid-disk               3
        device                  /dev/sdi1
        raid-disk               4
        device                  /dev/sde1
        raid-disk               5

Or does the kernel still keep the drives in order as the raidtab already is,
even though they seem to be out of order in the syslog and /proc/mdstat?  If
I have to force the recreation of the superblocks at some later point, which
way will keep the data from being lost?

Thanks.  Evan

-- 
| Evan Harris - Consultant, Harris Enterprises - eharris@puremagic.com
|
| Custom Solutions for your Software, Networking, and Telephony Needs

On Mon, 1 Oct 2001, Jakob Østergaard wrote:

> On Sun, Sep 30, 2001 at 07:51:25PM -0500, Evan Harris wrote:
> >
> > Thanks for the fast reply!
> >
> > I'm not sure I understand why drive 5 should be failed.  It is one of the
> > four disks with the most recently correct superblocks.  The disk with the
> > oldest superblock is #1.  Can you point me to documentation which explains
> > this better?  I'm a little afraid of doing that without reading more on it,
> > since it seems to mark yet another of the 4 remaining "good" drives as
> > "bad".
>
> Oh, sorry,   of course the oldest disk should be marked as failed.
>
> But the way you mark a disk failed is to replace "raid-disk" with "failed-disk".
>
> What you did in your configuration was to say that sde1 was disk 1, and sdi1 was
> disk 5 *AND* disk 1 *AND* it was failed.
>
> Replace "raid-disk" with "failed-disk" for the device that you want to mark
> as failed.  Don't touch the numbers.
>
> Cheers,
>
> --
> ................................................................
> :   jakob@unthought.net   : And I see the elder races,         :
> :.........................: putrid forms of man                :
> :   Jakob Østergaard      : See him rise and claim the earth,  :
> :        OZ9ABN           : his downfall is at hand.           :
> :.........................:............{Konkhra}...............:
>

