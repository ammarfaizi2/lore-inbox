Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWF0NJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWF0NJD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWF0NJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:09:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30548 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932119AbWF0NJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:09:00 -0400
Date: Tue, 27 Jun 2006 15:10:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org
Subject: Re: 2.6.17-ck1: fcache problem...
Message-ID: <20060627131033.GU22071@suse.de>
References: <20060625093534.1700e8b6@localhost> <20060625102837.GC20702@suse.de> <20060625152325.605faf1f@localhost> <20060625174358.GA21513@suse.de> <20060627112105.0b15bfa1@localhost> <20060627095443.GQ22071@suse.de> <20060627122457.2cabc4d7@localhost> <20060627150440.0aaf07e1@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627150440.0aaf07e1@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27 2006, Paolo Ornati wrote:
> On Tue, 27 Jun 2006 12:24:57 +0200
> Paolo Ornati <ornati@fastwebnet.it> wrote:
> 
> > So I suppose that it's already fixed.
> > 
> > :)
> 
> Oppss... even with your GIT tree it doesn't work :(
> 
> But this time I think I've found the problem:
> 
> --- fs/ext3/super.c ---
> 
> ext3_remount()
> {
> ...
> 	unsigned long fcache_devnum = 0;
> ...
> 	if (!parse_options(data, sb, NULL, NULL, &fcache_devnum, &n_blocks_count, 1))
> ...
>         if (fcache_devnum) {
>                 ext3_close_fcache(sb);
>                 ext3_open_fcache(sb, fcache_devnum);
>         }
> ...
> }
> 
> ---------------------
> 
> 
> If I understand correctly I have to pass the "fdev=..." option not only
> when remounting "rw" but even when remounting "ro" before shutdown or
> reboot.
> 
> Cannot the code figure out this himself al let "mount -o remount,ro"
> work?

It could be fixed up, yes, but for now you have to always pass the fdev
option for it to work. Sorry, I thought you knew that, I think I wrote
that in the original mail as well.

But it needs to be fixed of course, also so you don't have to do it for
'rw' remounts (which I sometimes do just to check stats).

-- 
Jens Axboe

