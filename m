Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWC3Oza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWC3Oza (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWC3Oza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:55:30 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50307 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750727AbWC3Oz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:55:29 -0500
Date: Thu, 30 Mar 2006 23:55:14 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH][RFC] splice support
Message-Id: <20060330235514.947a77fa.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060330143809.GN13476@suse.de>
References: <20060329122841.GC8186@suse.de>
	<20060330175406.fbd6d82c.kamezawa.hiroyu@jp.fujitsu.com>
	<20060330135346.GL13476@suse.de>
	<20060330230509.b1ae0d8c.kamezawa.hiroyu@jp.fujitsu.com>
	<20060330143809.GN13476@suse.de>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006 16:38:10 +0200
Jens Axboe <axboe@suse.de> wrote:

> On Thu, Mar 30 2006, KAMEZAWA Hiroyuki wrote:
> > On Thu, 30 Mar 2006 15:53:46 +0200
> > Jens Axboe <axboe@suse.de> wrote:
> > 
> > > > I don't know about sendfile() but this looks client can hold server's
> > > > memory, when server uses sendfile() 64k/conn.
> > > 
> > > You mean when the server uses splice, 64kb (well 16 pages actually) /
> > > connection? That's a correct observation, I wouldn't think that pinning
> > > that small a number of pages is likely to cause any issues. At least I
> > > can think of much worse pinning by just doing IO :-)
> > > 
> > My point is consumer can sleep forever and pages are pinnded forever.
> > And people who use splice() will not notice they are pinning pages.
> > 
> > But as you say, it's not problem in usual situation.
> > Maybe I'm too pessimistic how my cusomers play with Linux ;)
> 
> It's a valid concern, however as mentioned there's a number of ways in
> which a user can pin memory already. 
Yes.

>Perhaps this general problem should be capped elsewhere?
> 
I don't know. but this new one cannot be catched by overcommit_memory but
a user can consume not-reclaimable memory.

To be honest, I have to work with crash-dump. Sometimes cutomers request me to 
find out "how pages is used and why memory cannot be reclaimed ?" from dump.
So, I don't like unknown "1" reference to page-cache from some codes.
splice can increase this unkonwn 1 reference to some extent.

But I like idea of splice itself :).

-Kame

