Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265192AbSKKKvP>; Mon, 11 Nov 2002 05:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265238AbSKKKvP>; Mon, 11 Nov 2002 05:51:15 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:65250 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id <S265192AbSKKKvP>; Mon, 11 Nov 2002 05:51:15 -0500
Date: Mon, 11 Nov 2002 11:57:56 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: kernel BUG at kernel/timer.c:333!
Message-ID: <20021111115756.A12243@cistron.nl>
References: <aqj8bf$ff2$1@ncc1701.cistron.net> <3DCD5917.FEEA7C5D@digeo.com> <20021110153236.A18563@cistron.nl> <3DCE93CF.79AF516C@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DCE93CF.79AF516C@digeo.com>; from akpm@digeo.com on Sun, Nov 10, 2002 at 09:13:51AM -0800
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Andrew Morton:
> Miquel van Smoorenburg wrote:
> > 
> > I've booted 2.5.46bk5 on the machine, and it has been running for over
> > 2 hours with extra heavy diskio. That reliably crashed the machine
> > in about 45 minutes with 2.4.45 and 2.5.46, machine is still up now.
> 
> OK, thanks.

It survived the night and is still up. Looks like it runs slightly
faster than 2.4.20-X.

> This is a blockdev which was under mmap(), yes?  No, I haven't looked at
> that yet.  It'll be a matter of just killing the warning.

OK.

> mmapping a blockdev is a pretty dopey thing to do, btw.  It doesn't
> allow the use of highmem, the IO uses tiny BIOs (in fact I think
> it uses 512-byte or 1k blocksize too) and there are buffer_heads
> all over the place.  You'll get better results from mmapping a
> regular file.

It's just that the news server uses its own 'filesystem'. It does
normal read/write i/o on it, but the allocation bitmap at the
beginning of the 'file' is mmap()ed. Using a regular file means
creating a 160 GB file, the triple indirect blocks will probably
kill performance.

I guess that means I have to resurrect rawfs, then (a filesystem
I wrote for 2.2 that shows partitions as fixed-size files). But
that seems so .. unnecessary.

Mike.
