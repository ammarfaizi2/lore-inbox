Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbUKOWlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUKOWlQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbUKOWjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:39:32 -0500
Received: from fep18.inet.fi ([194.251.242.243]:58518 "EHLO fep18.inet.fi")
	by vger.kernel.org with ESMTP id S261440AbUKOWhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:37:12 -0500
Date: Tue, 16 Nov 2004 00:37:09 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vm-pageout-throttling.patch: hanging in throttle_vm_writeout/blk_congestion_wait
Message-ID: <20041115223709.GD6654@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041115012620.GA5750@m.safari.iki.fi> <Pine.LNX.4.44.0411152140030.4171-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0411152140030.4171-100000@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 09:56:29PM +0000, Hugh Dickins wrote:
> On Mon, 15 Nov 2004, Sami Farin wrote:
> > 
> > this time I had some swapspace on /dev/loop1 (file-backed, reiserfs,
> > loop-AES-2.2d)...  I think (!) it caused this deadlock.
> 
> That's not at all surprising.  See the swap_extent work Andrew did
> for 2.5 (in mm/swapfile.c), by which swap to a swapfile now avoids
> the filesystem altogether (except while swapon prepares the map of
> disk blocks).  By swapping to a loop device over a file, you're
> sneaking past his work, and putting the filesystem back under swap.

Aha...  interesting.

> It is begging for deadlocks: I'm not saying it couldn't be got to
> work, and of course it would be nice to boast that there's no such
> issue; but there are so many better places to invest such effort...

So, this was a known issue and it's hard to fix?  I didn't know that.

I know it's a "nicer" idea to use some partition for the swap
instead of a file on reiserfs, but I created too small swap partitions
originally and I can't(/bother?) resize the other partitions.
And sometimes some memhog forces me to add even more swap.

BTW. your MUA does not generate References: header field,
it makes scoring hard...  With References I would easily
notice when someone writes a followup to some of the threads I have
participated in.  But I could patch my MUA... 8)

-- 

