Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUFYAAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUFYAAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 20:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUFYAAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 20:00:49 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:28584 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id S265957AbUFYAA3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 20:00:29 -0400
Date: Thu, 24 Jun 2004 16:07:35 -0700 (PDT)
From: alan <alan@clueserver.org>
X-X-Sender: alan@www.fnordora.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       <linux-kernel@vger.kernel.org>, Amit Gud <gud@eth.net>
Subject: Re: Elastic Quota File System (EQFS)
In-Reply-To: <20040624220318.GE20649@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0406241544010.19187-100000@www.fnordora.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004, Pavel Machek wrote:

> Hi!
> 
> > > On one school server, theres 10MB quota. (Okay, its admins are
> > > BOFHs^H^H^H^H^HSISAL). Everyone tries to run mozilla there (because
> > > its installed as default!), and immediately fills his/her quota with
> > > cache files, leading to failed login next time (gnome just will not
> > > start if it can't write to ~).
> > > 
> > > Imagine mozilla automatically marking cache files "elastic".
> > > 
> > > That would solve the problem -- mozilla caches would go away when disk
> > > space was demanded, still mozilla's on-disk caching would be effective
> > > when there is enough disk space.
> > 
> > How does Mozilla (or any process) react when its files are deleted from 
> > under it?  Would the file remain until all the open processes close the 
> > file or would it just "disappear"? 
> 
> Of course, if mozilla marked them "elastic" it should better be
> prepared for they disappearance. I'd disappear them with simple
> unlink(), so they'd physically survive as long as someone held them
> open.

Hard to get the client to support a feature in an experimental file 
system.  You are more likely to handle this like a system policy than 
something set by the client.  (Especially since an app designed to fill 
disk space could just mark its files as elastic to get around quotas.)

> >  Would it delete entire directories or 
> > just some of the files?  How does it choose?  (First up against the delete 
> > when the drive space fills...)
> 
> Probably just some of the files... Or you could delete directory, too,
> if it was marked "elastic". What to delete first... probably file with
> oldest access time? Or random file, with chance of being selected
> proportional to file size?
> 
> I'm not implementing it, I'm just arguing that it is usefull.

I think that would make a bunch of headaches for the app designer.  
Imaging having a cache directory with an indexed database in a directory 
marked as elastic.  What happens whenone part of the multi-file database 
gets nuked in the middle on operation?  You are going to have to 
handle much more error conditions for weird special cases to deal with 
files wandering away without having the app just halt.  (Most programs I 
have seen just halt when a file they need is not found.)

A better option in this case is to reduce the default size of Mozilla's 
cache or expand the size of the quota for each user to deal with the added 
space requirements.

If you are concerned about disk usage from caches, you can always create 
a script that removes the cache(s) when the user logs out.


