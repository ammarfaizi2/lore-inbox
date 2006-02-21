Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbWBULka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbWBULka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 06:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbWBULka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 06:40:30 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1705 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932686AbWBULk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 06:40:29 -0500
Date: Tue, 21 Feb 2006 12:39:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Andy Lutomirski <luto@myrealbox.com>, Matthias Hensler <matthias@wspse.de>,
       kernel list <linux-kernel@vger.kernel.org>,
       Sebastian Kgler <sebas@kde.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060221113952.GR21557@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220094728.GD19293@kobayashi-maru.wspse.de> <43FA97D9.4070902@myrealbox.com> <200602211446.04123.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602211446.04123.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I can only speak for myself, but I want to work with my system from the
> > > moment my desktop is back.
> >
> > I Am Not A VM Hacker, but:
> >
> > What's the point of saving pagecache during suspend?  This seems like a
> > total waste.  Why don't we save a list of pages in pagecache to disk,
> > then, after resume, prefetch them all back in.  This will slow down
> > resume (extra seeks, minimized if we sort the list, and inability
> > to compress these pages), but it will speed up suspend, and it sounds
> > a lot simpler.  There's already a patch to add swap prefetching, and
> > this can't be much more complicated.
> 
> The page cache contains the process pages, among other things, so it can't all 
> be discarded with impunity. You're right in suggesting that
> discarding them 

Well, we already have perfectly good code to free pagecache.

> and then prefetching them would be a potential alternative, but it would 
> actually be more complicated: you'd still have to remember which pages you 
> wanted to fault back in, and some how store that info in the
> image. You'd 

That's okay. Imagine 

"cat /proc/vm/pagecache-contents > /tmp/delme" just before suspend and
"cat /tmp/delme | prefetcher" just after it. Prefetcher is actually
simple app that reads specified pages, then discards them. It can
actually be done in userspace around regular swsusp/uswsusp/suspend2
with no impact on it.

								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
