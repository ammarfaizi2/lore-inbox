Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265957AbUFYARq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265957AbUFYARq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 20:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265950AbUFYARp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 20:17:45 -0400
Received: from gprs214-211.eurotel.cz ([160.218.214.211]:2434 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265957AbUFYAQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 20:16:02 -0400
Date: Fri, 25 Jun 2004 02:15:45 +0200
From: Pavel Machek <pavel@suse.cz>
To: alan <alan@clueserver.org>
Cc: "Fao, Sean" <Sean.Fao@dynextechnologies.com>, linux-kernel@vger.kernel.org,
       Amit Gud <gud@eth.net>
Subject: Re: Elastic Quota File System (EQFS)
Message-ID: <20040625001545.GI20649@elf.ucw.cz>
References: <20040624220318.GE20649@elf.ucw.cz> <Pine.LNX.4.44.0406241544010.19187-100000@www.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0406241544010.19187-100000@www.fnordora.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Of course, if mozilla marked them "elastic" it should better be
> > prepared for they disappearance. I'd disappear them with simple
> > unlink(), so they'd physically survive as long as someone held them
> > open.
> 
> Hard to get the client to support a feature in an experimental file 
> system.  You are more likely to handle this like a system policy than 
> something set by the client.  (Especially since an app designed to fill 
> disk space could just mark its files as elastic to get around
> quotas.)

I believe application support is right thing to do... It may not be
the easiest thing to do, through.

> > >  Would it delete entire directories or 
> > > just some of the files?  How does it choose?  (First up against the delete 
> > > when the drive space fills...)
> > 
> > Probably just some of the files... Or you could delete directory, too,
> > if it was marked "elastic". What to delete first... probably file with
> > oldest access time? Or random file, with chance of being selected
> > proportional to file size?
> > 
> > I'm not implementing it, I'm just arguing that it is usefull.
> 
> I think that would make a bunch of headaches for the app designer.  
> Imaging having a cache directory with an indexed database in a directory 
> marked as elastic.  What happens whenone part of the multi-file database 
> gets nuked in the middle on operation?  You are going to have to 
> handle much more error conditions for weird special cases to deal with 
> files wandering away without having the app just halt.  (Most programs I 
> have seen just halt when a file they need is not found.)

Well, that's arguably application bug. Anyway, noone says that right
thing to do is easy.

> A better option in this case is to reduce the default size of Mozilla's 
> cache or expand the size of the quota for each user to deal with the added 
> space requirements.
> 
> If you are concerned about disk usage from caches, you can always create 
> a script that removes the cache(s) when the user logs out.

That's not the right thing.. that way you loose caching effects around
logins even when there's plenty of space.

There's quite a lot of data -- at least on my systems -- that can be
removed with "only" loss of performance...

1) browser caches

2) package lists, downloaded packages

3) object files

heck, if you know you have reliable network connection 4), you could
even mark stuff like /usr/bin/mozilla elastic, and re-install it from
the network when it is needed... Doing anything more complex than 1)
requires extensive changes all around the kernel and userland, and
you'd probably not call that system unix any more.

I'm not saying that "elastic" feature should go into 2.6 or 2.8 or
whatever, but it still seems interesting to me.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
