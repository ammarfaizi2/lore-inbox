Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTLEGlJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 01:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTLEGlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 01:41:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:39326 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263880AbTLEGlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 01:41:07 -0500
Date: Thu, 4 Dec 2003 22:40:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nathan Scott <nathans@sgi.com>
cc: Neil Brown <neilb@cse.unsw.edu.au>, pinotj@club-internet.fr,
       manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
In-Reply-To: <20031205030018.GA1693@frodo>
Message-ID: <Pine.LNX.4.58.0312042232310.9125@home.osdl.org>
References: <mnet1.1070562461.26292.pinotj@club-internet.fr>
 <Pine.LNX.4.58.0312041035530.6638@home.osdl.org> <Pine.LNX.4.58.0312041050050.6638@home.osdl.org>
 <20031205030018.GA1693@frodo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Dec 2003, Nathan Scott wrote:
>
> This patch removes that code, fixes a small memory leak that was
> lurking in there too, and adds the missing-bio_put-on-error case
> that Neil found in pagebuf.

Ok, so we've got the RAID5 issue explained, does anybody have any idea
about what's wrong with the non-RAID5 cases? We've got at least one report
of page corruption on RAID0, and one on a plain disk. Both of which looked
XFS-related - or at least shared that in their configs.

Jerome - can you test Nathan's patch together with my "avoid the
complicated slab logic"? The slab avoidance thing got ext3 stable for you,
now with Nathan's patch hopefully XFS will be stable too.

Which still doesn't _explain_ anything, but it would be interesting to see
if that removes your problems. It would definitely point to a slab issue,
but the big question is why it's not more common if so. Compiler bug?
Other strange trigger?

			Linus
