Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263319AbSJCOrw>; Thu, 3 Oct 2002 10:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263330AbSJCOrw>; Thu, 3 Oct 2002 10:47:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:21992 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263319AbSJCOqR>;
	Thu, 3 Oct 2002 10:46:17 -0400
Date: Thu, 3 Oct 2002 10:51:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Kevin Corry <corryk@us.ibm.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: EVMS Submission for 2.5
In-Reply-To: <02100308045305.05904@boiler>
Message-ID: <Pine.GSO.4.21.0210031042210.15787-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Oct 2002, Kevin Corry wrote:

> > I might agree with something along the lines of
> > 	* when evms is initialized, it's notified of all existing gendisks
> > 	* whenever disk is added after evms initialization, we notify evms
> > 	* whenever disk is removed, we notify evms
> 
> This sounds like it would be exactly what EVMS needs. The only thing we would 
> want to add to this list is: "*whenever a disk is modified, notify evms". For 
> example, with removable media drives (such as Zip and Jaz), when a cartidge 
> is changed, the capacity of the drive might change, and we would like to be 
> notified of that event.

Umm...  OK.  There were some plans to add a notifier chain for such events
and EVMS looks like a possible user of that beast.  However, it's not
obvious whether we need to do any of that in the kernel - we definitely
can have userland up and running before _any_ block devices are initialized,
so it might be a work for userland helper.

Speaking of which...  Linus, mind if I start feeding initramfs stuff?

> > However, I doubt that it's what you really want.  In particular, you
> > probably want to see partitioning changes as well as gendisk ones
> > (and no, "evms will handle all partitioning" is _not_ an acceptable
> > answer).
> 
> EVMS won't really be interested in partitioning changes. It only cares about 
> whole devices, i.e. minor_shift == 0.
> 
> > Moreover, "gendisk is here" != "something is in the drive".
> 
> Will there be a common method for determining "media present"? The current 
> method EVMS uses to determine "media changes" is somewhat inconsistent 
> between IDE and SCSI.

There's none.  We need some way to deal with that, but for that we need
at least sane and stable interfaces.  Right now _all_ "media changed"
stuff on the driver side is ad-hackery.

> > IOW, the real question is what are you going to do with that list of
> > gendisks?
> 
> EVMS will try to read volume metadata from each device and activate volumes 
> if it finds any pertinent metadata.

_Ouch_.  "Each" as in...?  E.g. do you want to do that for floppies?  Cdroms?
EVMS volumes themselves?  Things like /dev/loop? (and if yes, at which point
do you do that?)

