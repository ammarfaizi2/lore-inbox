Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261749AbSJUWYR>; Mon, 21 Oct 2002 18:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261747AbSJUWYR>; Mon, 21 Oct 2002 18:24:17 -0400
Received: from 2-136.ctame701-1.telepar.net.br ([200.193.160.136]:55005 "EHLO
	2-136.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261749AbSJUWYO>; Mon, 21 Oct 2002 18:24:14 -0400
Date: Mon, 21 Oct 2002 20:30:06 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
Subject: Re: ZONE_NORMAL exhaustion (dcache slab)
In-Reply-To: <309670000.1035236015@flay>
Message-ID: <Pine.LNX.4.44L.0210212028100.22993-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, Martin J. Bligh wrote:

> > Blockdevices only use ZONE_NORMAL for their pagecache.  That cat will
> > selectively put pressure on the normal zone (and DMA zone, of course).
>
> Ah, I recall that now. That's fundamentally screwed.

It's not too bad since the data can be reclaimed easily.

The problem in your case is that the dentry and inode cache
didn't get reclaimed. Maybe there is a leak so they can't get
reclaimed at all or maybe they just don't get reclaimed fast
enough.

I'm looking into the "can't be reclaimed fast enough" problem
right now. First on 2.4-rmap, but if it works I'll forward-port
the thing to 2.5 soon (before Linus returns from holidays).

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

