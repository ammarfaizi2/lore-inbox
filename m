Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTJQSIG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 14:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263577AbTJQSIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 14:08:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12169 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263578AbTJQSIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 14:08:01 -0400
Date: Fri, 17 Oct 2003 20:08:01 +0200
From: Jens Axboe <axboe@suse.de>
To: "Mudama, Eric" <eric_mudama@Maxtor.com>
Cc: "'Greg Stark'" <gsstark@mit.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031017180801.GC8230@suse.de>
References: <785F348679A4D5119A0C009027DE33C105CDB2DD@mcoexc04.mlm.maxtor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785F348679A4D5119A0C009027DE33C105CDB2DD@mcoexc04.mlm.maxtor.com>
X-OS: Linux 2.4.22aa1-axboe i686
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17 2003, Mudama, Eric wrote:
> 
> 
> > -----Original Message-----
> > From: Jens Axboe [mailto:axboe@suse.de]
> >
> > Yes that would be very nice, but unfortunately I think FUA in ATA got
> > defined as not implying ordering (the FUA write would typically go
> > straight to disk, ahead of any in-cache dirty data). Which 
> > makes it less
> > useful, imo.
> 
> None of the TCQ/FUA components of the spec mention ordering.  According to
> the "letter" of the specification, if you issue two queued writes for the
> same LBA, the drive has the choice of which one to do first and which one to
> put on the media first, which is totally broken in common sense land.
> 
> Luckilly, us drive guys are a bit smarter (if only a bit)...

Some of you? :)

> If you issue a FUA write for data already in cache, and you put the FUA
> write onto the media, there's no problem if you discard the cached data that
> you were going to write.
> 
> In drives with a unified cache, they'll always be consistent provided the
> overlapping interface transfers happen in the same order they were
> issued.... this is common sense.
> 
> However, you're right in that non-overlapping cached write data may stay in
> cache a long time, which potentially gives you a very large time hole in
> which your FUA'd data is on the media and your user data is still hangin' in
> the breeze prior to a flush on a very busy drive.

That's why for IDE I prefer handling it in software. Let the queue drain,
issue a barrier write, and continue. That works, regardless of drive
firmware implementations. As long as the spec doesn't make it explicit
what happens, there's no way I can rely on it.

Jens

