Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274337AbRJAAlY>; Sun, 30 Sep 2001 20:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274341AbRJAAlP>; Sun, 30 Sep 2001 20:41:15 -0400
Received: from unthought.net ([212.97.129.24]:18318 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S274337AbRJAAlD>;
	Sun, 30 Sep 2001 20:41:03 -0400
Date: Mon, 1 Oct 2001 02:41:30 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Evan Harris <eharris@puremagic.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: RAID5: mkraid --force /dev/md0 doesn't work properly
Message-ID: <20011001024130.A24589@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Evan Harris <eharris@puremagic.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109301841220.2459-100000@kinison.puremagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0109301841220.2459-100000@kinison.puremagic.com>; from eharris@puremagic.com on Sun, Sep 30, 2001 at 07:29:06PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2001 at 07:29:06PM -0500, Evan Harris wrote:
> 
> And yes, I'm using the real --force option.  :)

Good (hush now, it's a secret ;)

> 
> I have a 6 disk RAID5 scsi array that had one disk go offline through a
> dying power supply, taking the array into degraded mode, and then another
> went offline a couple of hours later from what I think was a loose cable.
> 
> The first drive to go offline was /dev/sde1.
> The second to go offline was /dev/sdd1.
> 
> Both drives are actually fine after fixing the connection problems and a
> reboot, but since the superblocks are out of sync, it won't init.

Ok.

...
[huge snip]
...
> 
> I set the first disk that went offline out with a failed-disk directive, and
> tried to recover with a:
> 
> mkraid --force /dev/md0

Good !

(to anyone reading this without having read the docs:  don't pull this trick
 unless you absolutely positively understand the consequences of screwing up
 here)

> 
> I'm _positive_ that the /etc/raidtab is correct, but it fails to force the
> update with:
> 
> DESTROYING the contents of /dev/md0 in 5 seconds, Ctrl-C if unsure!
> handling MD device /dev/md0
> analyzing super-block
> raid_disk conflict on /dev/sde1 and /dev/sdi1 (1)
> mkraid: aborted, see the syslog and /proc/mdstat for potential clues.
...

Read on


[snip]
> For info, here is my raidtab:
> 
> raiddev /dev/md0
>         raid-level              5
>         nr-raid-disks           6
>         nr-spare-disks          0
>         chunk-size              256
>         persistent-superblock   1
>         device                  /dev/sdd1
>         raid-disk               0
>         device                  /dev/sde1
>         raid-disk               1
>         device                  /dev/sdf1
>         raid-disk               2
>         device                  /dev/sdg1
>         raid-disk               3
>         device                  /dev/sdh1
>         raid-disk               4
>         device                  /dev/sdi1
>         raid-disk               5
>         failed-disk     1


Wrong !   device /dev/sdi1 is railed-disk 5 not failed-disk 1,
that's why mkraid is confused.

What you want is:
      device                  /dev/sdd1
      raid-disk               0
      device                  /dev/sde1
      raid-disk               1
      device                  /dev/sdf1
      raid-disk               2
      device                  /dev/sdg1
      raid-disk               3
      device                  /dev/sdh1
      raid-disk               4
      device                  /dev/sdi1
      failed-disk               5


Good luck,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
