Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272592AbRIRQq1>; Tue, 18 Sep 2001 12:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272828AbRIRQqS>; Tue, 18 Sep 2001 12:46:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27148 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272592AbRIRQqJ>; Tue, 18 Sep 2001 12:46:09 -0400
Date: Tue, 18 Sep 2001 09:45:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <Pine.GSO.4.21.0109180527450.25323-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0109180935180.2077-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Sep 2001, Alexander Viro wrote:
>
> Umm...  Linus, had you actually read through the fs/block_device.c part
> of that?  It's not just ugly as hell, it's (AFAICS) not hard to oops
> if you have several inodes sharing major:minor.  ->bd_inode and its
> treatment are bogus.  Please, read it through and consider reverting -
> in its current state code is an ugly mess.

Funny that you mention it, because I actually have a cunning plan, and
you're an unwitting part of it.

Or actually, I hope you're a "witting" part of it, because it's going to
be your code.

Take your "struct block_device" code, add a "struct address_space" to it,
and whenever a block device inode is opened, make the inode->i_mapping
point to &bdev->b_data, and voila..

You already get all the reference counting right, and it's the only
sensible place to do it anyway, wouldn't you agree?

I thought you'd be thrilled. It seems to match your lazy allocation patch
very well..

		Linus

