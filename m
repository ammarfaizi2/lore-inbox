Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTKMP2C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 10:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbTKMP2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 10:28:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47083 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264324AbTKMP1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 10:27:31 -0500
Date: Thu, 13 Nov 2003 16:27:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pascal Schmidt <der.eremit@email.de>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031113152729.GL4441@suse.de>
References: <20031113143521.GK4441@suse.de> <Pine.LNX.4.44.0311130712120.8093-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311130712120.8093-100000@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13 2003, Linus Torvalds wrote:
> 
> On Thu, 13 Nov 2003, Jens Axboe wrote:
> 
> > On Thu, Nov 13 2003, Pascal Schmidt wrote:
> > >  
> > > My patch from yesterday should handle that situation. 
> > > cdrom_get_last_written is allowed to override the capacity from
> > > cdrom_read_capacity.
> > 
> > Yep, that is fine.
> 
> Well, there is a good argument for not bothering with the 
> "cdrom_get_last_written" at all: the SCSI layer never does anything like 
> that as far as I can see, so arguably everybody who ever used ide-scsi 
> would only ever have seen the READ_CAPACITY command be used. And nobody 
> ever complained about bad capacitites as far as I can remember..
> 
> But I might have missed something in the SCSI driver. But I actually see a
> 
> 		if (cdrom_get_last_written(..)
> 
> in sr.c, and it's been #if 0'ed out since before the Bitkeeper tree 
> started. And that code definitely does the READ_CAPACITY first.
> 
> The "sd.c" code (which is what a MO device would use) obviously doesn't do 
> cdrom_get_last_written either - it just does a READ_CAPACITY. (Well, it 
> does a READ_CAPACITY_16 if it hits a really big disk, but that only hits 
> if the disk has more than 4G sectors, so we can ignore it for CD-ROM's for 
> a while.
> 
> So I'd argue for just dropping the cdrom_get_last_written() call entirely.

Your argument isn't very good, imo. I was the one that added the
cdrom_get_last_written() calls, because with the pktcdvd written media
reading the toc or using READ_CAPACITY just didn't work.

For MO drives, DVD-RAM, and that sort of thing there's no argument -
read capacity is the way to go. For CDROMs it's not so clear.

-- 
Jens Axboe

