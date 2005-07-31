Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVGaTRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVGaTRM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 15:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVGaTRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 15:17:12 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:40880 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S261922AbVGaTRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 15:17:09 -0400
Date: Sun, 31 Jul 2005 21:16:12 +0200
From: Sander <sander@humilis.net>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: IO scheduling & filesystem v a few processes writing a lot
Message-ID: <20050731191607.GA7186@favonius>
Reply-To: sander@humilis.net
References: <20050731163933.GB7280@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050731163933.GB7280@gallifrey>
X-Uptime: 20:31:05 up 11 days,  9:49, 25 users,  load average: 3.66, 3.11, 2.84
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dr. David Alan Gilbert wrote (ao):
>   I've got a backup system that I'm trying to eek some more performance
> out of - and I don't understand the right way to get the kernel to
> do disc writes efficiently - and hence would like some advice.
> 
> I was using rsync, but the problem with rsync is that I have
> a back up server then filled with lots and lots of small files
> - I want larger files for spooling to tape.
> (Other suggestions welcome)

Can't you just tar the small files from the backupserver to tape? (or,
what is the problem with that?).

> So I'm trying switching to streaming gzip'd tars from each
> client to backup to the server. I have one server that
> opens connections to each of the clients and sucks the data
> using netcat (now netcat6 in ipv4 mode) and writes it to
> disc, one file per client. Now the downside here
> relative to rsync is that it is going to transfer and
> write a lot more data.

You also do incremental backups?

> Now the clients are on 100Mb/s, and the server on GigE,
> the clients sometime have to think while they gzip their data, so I'd
> like to suck data from multiple clients at once.  So I run multiple of
> these netcat's in parallel - currently about 9.
> 
> I've benchmarked write performance on the filesystem at
> 60-70MB/s for a single write process (as shown with iostat)
> for a simple dd if=/dev/zero of=abigfile bs=1024k
> 
> My problem is that with the parallel writes iostat is showing
> I'm actually getting ~3MB/s write bandwidth - that stinks!

How many parallel streams can the system currently handle before the
write bandwith gets unacceptable?

> The machine is a dual xeon with 1GB of RAM, an intel GigE
> card and a 2.6.11 kernel, a 3ware-9000 series pci-x controller
> with a 1.5TB RAID5 partition running Reiser3.

What mount options? And how many disks?

> Reiser3 is used because I couldn't get ext3 stable on a filesystem of
> this size (-64ZByte free shown in df),

That is not a sign of instability per se AFAIK.

> and xfs didn't seem stable on recovering from an arbitrarily placed
> reset. The 3ware has write caching (with battery backup).

How is the cache configured in the bios?

> I'm open for all suggestions.
 
Would it be possible to test software raid to see if that gives
different numbers?

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
