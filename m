Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286173AbRLJG5T>; Mon, 10 Dec 2001 01:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286174AbRLJG5K>; Mon, 10 Dec 2001 01:57:10 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:7955 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S286173AbRLJG44>; Mon, 10 Dec 2001 01:56:56 -0500
Date: Mon, 10 Dec 2001 00:56:41 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Slight Return (was Re: [VM] 2.4.14/15-pre4 too "swap-happy"?)
Message-ID: <20011210005641.A11697@asooo.flowerfire.com>
In-Reply-To: <20011208071259.C24098@asooo.flowerfire.com> <Pine.LNX.4.21.0112091650410.24337-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0112091650410.24337-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Sun, Dec 09, 2001 at 04:51:14PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, any kind of fairly heavy, spread-out I/O combined with updatedb
will do the trick, like samba.  NFS isn't required, it just seems to be
a particularly good trigger.

It seems like anything that hits the inode/dentry caches hard, actually,
and doesn't always happen when freepages (or its 2.4.x equivalent) has
been hit.  I had a little applet that malloc'ed and memcpy'ed 1GB of RAM
and exited, which doesn't really help like it did before 2.4.15-pre[56].

It also happens for me a lot more with my 4GB machines, though I have
seen it on my 1GB HIGHMEM boxes as well.  If the problem is related to
scanning the cache, perhaps more RAM simply makes it worse.

I'm planning on trying Andrew Morton's patches as soon as I'm able.

Thanks,
-- 
Ken.
brownfld@irridia.com


On Sun, Dec 09, 2001 at 04:51:14PM -0200, Marcelo Tosatti wrote:
| 
| 
| On Sat, 8 Dec 2001, Ken Brownfield wrote:
| 
| > Just a quick followup to this, which is still a near show-stopper issue
| > for me.
| > 
| > This is easy to reproduce for me if I run updatedb locally, and then run
| > updatedb on a remote machine that's scanning an NFS-mounted filesystem
| > from the original local machine.  Instant kswapd saturation, especially
| > on large filesystems.
| > 
| > Doing updatedb on NFS-mounted filesystems also seems to cause kswapd to
| > peg on the NFS-client side as well.
| 
| Can you reproduce the problem without the over NFS updatedb? 
| 
| Thanks 
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
