Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVHAOsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVHAOsc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 10:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVHAOsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 10:48:32 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:7858 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S262212AbVHAOsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 10:48:21 -0400
Date: Mon, 1 Aug 2005 16:48:20 +0200
From: Sander <sander@humilis.net>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Sander <sander@humilis.net>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: IO scheduling & filesystem v a few processes writing a lot
Message-ID: <20050801144820.GC7686@favonius>
Reply-To: sander@humilis.net
References: <20050731163933.GB7280@gallifrey> <20050731191607.GA7186@favonius> <20050801085426.GA12516@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801085426.GA12516@gallifrey>
X-Uptime: 15:03:36 up 12 days,  4:22, 22 users,  load average: 1.02, 1.19, 1.61
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dr. David Alan Gilbert wrote (ao):
> * Sander (sander@humilis.net) wrote:
> > Dr. David Alan Gilbert wrote (ao):
> > > I was using rsync, but the problem with rsync is that I have
> > > a back up server then filled with lots and lots of small files
> > > - I want larger files for spooling to tape.
> > > (Other suggestions welcome)
> > 
> > Can't you just tar the small files from the backupserver to tape? (or,
> > what is the problem with that?).
> 
> Lots of small files->slow; it is an LTO-2 tape drive that is spec'd
> at 35MByte/s - it won't get that if I'm feeding it from something
> seeking all over.

ic. Sorry if the question is stupid, but is it bad not to reach
35MB/sec?

> > > write a lot more data.
> > 
> > You also do incremental backups?
> 
> I could - but they are a pain at restore time.

Well, bare metal restores are rare, and if you need to do one, IMHO one
full restore and six incrementals (worst case, and with one full backup
a week) are not that painful. Very IMHO of course. You could lessen the
pain with incrementals_since_last_full (can't remember the correct term
ATM).

If you go with weekly fulls, you can almost have a single system per
day streaming a full backup to your backupserver.

> > What mount options? And how many disks?
> 
> 7 active discs, raid5; mounted with noatime, nodiratime

Should perform at least a bit..

> > > Reiser3 is used because I couldn't get ext3 stable on a filesystem of
> > > this size (-64ZByte free shown in df),
> > 
> > That is not a sign of instability per se AFAIK.
> 
> When I fsck it fixes it - this to me is an indication something is
> wrong with the ondisc data; now it might only be the freespace totals
> - but the fact that the disc contents are wrong makes me worry - I
> don't like having to fsck a 1.5TB partition.

Yes, I understand.

> > How is the cache configured in the bios?
> 
> Write cache is on in the 3ware bios as is the battery backup.

According to the docs it is just 'enable' or 'disable'. I remember raid
controllers (Intel?) which also have 'write through' or 'write back'.
That was what I was looking for, but no such thing it seems.

> > > I'm open for all suggestions.
> >  
> > Would it be possible to test software raid to see if that gives
> > different numbers?
> 
> Erm I guess I could - but the controller does manage
> 60/70MB/s write as a raw stream, so as far as I can tell if I can
> persuade the kernel not to chop my writes into silly small
> chunks things should be good.

Yes, but if you can lift the performance at some point, it might get
acceptable. You could for example also try a raid0 stripe across the 7
disks.

	Kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
