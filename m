Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVDZQlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVDZQlR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVDZQlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:41:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:42193 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261680AbVDZQkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:40:47 -0400
Date: Tue, 26 Apr 2005 09:42:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Mason <mason@suse.com>
cc: Mike Taht <mike.taht@timesys.com>, Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
In-Reply-To: <200504260713.26020.mason@suse.com>
Message-ID: <Pine.LNX.4.58.0504260939440.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251938210.18901@ppc970.osdl.org>
 <Pine.LNX.4.58.0504252032500.18901@ppc970.osdl.org> <200504260713.26020.mason@suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Apr 2005, Chris Mason wrote:
> 
> This agrees with my tests here, the time to apply patches is somewhat disk 
> bound, even for the small 100 or 200 patch series.  The io should be coming 
> from data=ordered, since the commits are still every 5 seconds or so.

Yes, ext3 really does suck in many ways.

One of my (least) favourite suckage is a process that does "fsync" on a
single file (mail readers etc), which apparently causes ext3 to sync all
dirty data, because it can only sync the whole log. So if you have stuff
that writes out things that aren't critical, it negatively affects
something totally independent that _does_ care.

I remember some early stuff showing that reiserfs was _much_ better for 
BK. I'd be willing to bet that's probably true for git too.

		Linus
