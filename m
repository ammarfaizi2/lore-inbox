Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130833AbRBAQRs>; Thu, 1 Feb 2001 11:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130849AbRBAQRi>; Thu, 1 Feb 2001 11:17:38 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:30459 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130833AbRBAQRV>; Thu, 1 Feb 2001 11:17:21 -0500
Date: Thu, 1 Feb 2001 14:16:43 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: David Ford <david@linux.com>
cc: LKML <linux-kernel@vger.kernel.org>, Chris Mason <mason@suse.com>,
        reiserfs-list@namesys.com
Subject: Re: VM brokenness, possibly related to reiserfs
In-Reply-To: <3A790A16.C964877@linux.com>
Message-ID: <Pine.LNX.4.21.0102011411540.1321-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, David Ford wrote:

> The dumps are large so they are located at http://stuph.org/VM/.

I can't seem to resolve this domain ...

> Here's the story.  I boot and startx, I load xmms and netscape
> to eat away memory.  When free buffers/cache falls below 7M the
> system stalls and the only recovery is sysrq-E or reboot.  At
> the moment of stall the disk will grind continuously for about
> 25 to 30 minutes then go silent.  At this point in time the only
> recovery is reboot, sysrq-E won't work.

> Kernel 2.4.1, with reiserfs, devfs, no patches applied.

Between 2.4.0 and 2.4.1, a few VM changes were made by
Linus and Marcelo. These are good changes, but they seem
to need a little bit of tuning in related code to get
system behaviour right again.

I'm working on these changes and should have a (few)
rebalancing patches out soon to fix the performance
problem.

About the system hanging completely, I wonder if it goes
away by pressing sysrq-S (sync all disks). If it does,
maybe Reiserfs was blocking all the pages in the inactive
list from being written because one of the active pages
(not a replacement candidate) needed to be written out
first?  Or does the Reiserfs ->writepage() function handle
this?

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
