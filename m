Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318790AbSHRByt>; Sat, 17 Aug 2002 21:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318791AbSHRByt>; Sat, 17 Aug 2002 21:54:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:39144 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318790AbSHRBys>;
	Sat, 17 Aug 2002 21:54:48 -0400
Date: Sat, 17 Aug 2002 21:58:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Anton Altaparmakov <aia21@cantab.net>,
       alan@lxorguk.ukuu.org, Andre Hedrick <andre@linux-ide.org>,
       axboe@suse.de, vojtech@suse.cz, bkz@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: Re: IDE?
In-Reply-To: <Pine.LNX.4.44.0208171839420.1310-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0208172149410.750-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 17 Aug 2002, Linus Torvalds wrote:

> 
> On 17 Aug 2002, Alan Cox wrote:
> > 
> > If we can do it that way I'll do the job. If Linus applies random IDE
> > "cleanup" patches to his 2.5 tree that don't pass through Jens and me
> > then I'll just stop listening to 2.5 stuff.
> 
> That may work for the low-level driver stuff, but not for things like the
> partitioning fixes. Especially as some of that is different in 2.5.x 
> relative to 2.4.x.
> 
> In other words, I'll clearly apply anything that comes from Al, at the 
> very least.

I'm going to run these patches by Alan first anyway, so...

BTW, most of partitioning patches apply to both branches - it's preliminary
cleanup part that is tricky; some of partitioning stuff is already in Jens
code and the rest will be a matter of not moving add_gendisk()/del_gendisk()
in 2.4 branch and leaving the calls of grok_partitions()/wipe_partitions()
in ide_revalidate() (2.4) while removing them in 2.5.

Cleanup that comes before that stage is common for 2.4 and 2.5, makes sense
in both and will be synced with Alan - if nothing else, to keep PITA for
Jens minimal.

Look at the patches for other drivers - gendisk splitup / removal of
BLKRRPART handling / removal of ad-hackery in open/reread partitions /
removal of grok_partitions() and wipe_partitions() is fairly small
_if_ driver has clean rules for places where it used to register disks.
That's the main trouble with IDE for my current purposes - and fixing it
makes sense for 2.4 as well as for 2.5.

