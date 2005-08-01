Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVHAI4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVHAI4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 04:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVHAIx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 04:53:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:21385 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S261856AbVHAIwN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 04:52:13 -0400
Date: Mon, 1 Aug 2005 09:54:26 +0100
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Sander <sander@humilis.net>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: IO scheduling & filesystem v a few processes writing a lot
Message-ID: <20050801085426.GA12516@gallifrey>
References: <20050731163933.GB7280@gallifrey> <20050731191607.GA7186@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050731191607.GA7186@favonius>
User-Agent: Mutt/1.4.1i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.11-1.14_FC3smp (i686)
X-Uptime: 09:47:27 up 109 days,  8:16, 43 users,  load average: 0.00, 0.00, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Sander (sander@humilis.net) wrote:
> Dr. David Alan Gilbert wrote (ao):

> > I was using rsync, but the problem with rsync is that I have
> > a back up server then filled with lots and lots of small files
> > - I want larger files for spooling to tape.
> > (Other suggestions welcome)
> 
> Can't you just tar the small files from the backupserver to tape? (or,
> what is the problem with that?).

Lots of small files->slow; it is an LTO-2 tape drive that is spec'd
at 35MByte/s - it won't get that if I'm feeding it from something
seeking all over.

> > write a lot more data.
> 
> You also do incremental backups?

I could - but they are a pain at restore time.

> > I've benchmarked write performance on the filesystem at
> > 60-70MB/s for a single write process (as shown with iostat)
> > for a simple dd if=/dev/zero of=abigfile bs=1024k
> > 
> > My problem is that with the parallel writes iostat is showing
> > I'm actually getting ~3MB/s write bandwidth - that stinks!
> 
> How many parallel streams can the system currently handle before the
> write bandwith gets unacceptable?

I'll be honest I don't know; this was running with 9 streams; but 
I know the overall speed of the backup goes up as I increase
the parallelism from 5 through 9 - but it still sucks.

> > The machine is a dual xeon with 1GB of RAM, an intel GigE
> > card and a 2.6.11 kernel, a 3ware-9000 series pci-x controller
> > with a 1.5TB RAID5 partition running Reiser3.
> 
> What mount options? And how many disks?

7 active discs, raid5; mounted with noatime, nodiratime

> > Reiser3 is used because I couldn't get ext3 stable on a filesystem of
> > this size (-64ZByte free shown in df),
> 
> That is not a sign of instability per se AFAIK.

When I fsck it fixes it - this to me is an indication something is wrong
with the ondisc data; now it might only be the freespace totals - but
the fact that the disc contents are wrong makes me worry - I don't
like having to fsck a 1.5TB partition.

> > and xfs didn't seem stable on recovering from an arbitrarily placed
> > reset. The 3ware has write caching (with battery backup).
> 
> How is the cache configured in the bios?

Write cache is on in the 3ware bios as is the battery backup.

> > I'm open for all suggestions.
>  
> Would it be possible to test software raid to see if that gives
> different numbers?

Erm I guess I could - but the controller does manage
60/70MB/s write as a raw stream, so as far as I can tell if I can
persuade the kernel not to chop my writes into silly small
chunks things should be good.

Dave
--
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
