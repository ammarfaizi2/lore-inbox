Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbVJ0IYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbVJ0IYg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 04:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVJ0IYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 04:24:35 -0400
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:41482 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S964977AbVJ0IYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 04:24:35 -0400
To: bulb@ucw.cz
CC: viro@ftp.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <20051027080713.GA25460@djinn> (message from Jan Hudec on Thu, 27
	Oct 2005 10:07:13 +0200)
Subject: Re: [PATCH 2/8] VFS: per inode statfs (core)
References: <E1EU5bT-0005sq-00@dorka.pomaz.szeredi.hu> <20051025042519.GJ7992@ftp.linux.org.uk> <E1EUHbq-0006t6-00@dorka.pomaz.szeredi.hu> <20051026173150.GB11769@efreet.light.src> <E1EUqm3-00013A-00@dorka.pomaz.szeredi.hu> <20051026195240.GB15046@efreet.light.src> <E1EUrb7-0001AU-00@dorka.pomaz.szeredi.hu> <20051027080713.GA25460@djinn>
Message-Id: <E1EV338-0001vx-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 27 Oct 2005 10:23:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not _without__loss__of__functionality__. Part of the functionality is
> looking up the mount-point and other info about the filesystem, which is
> no longer correct when subfilesystems are exposed.

Sorry, I still don't get it.

'df path' looks up the mountpoint. Fine, no problem with that.
Displays it in in column 'Mounted on'.  Then goes on to do
statfs(path), and display the results.

Can you please explain why you think that's wrong?  It displayed the
free space in the directory I _aked_it_.  It displayed the mountpoint
under which this path happens to be.

If I want to find out the free space immediately under the mountpoint,
I can do 'df mountpoint' or just 'df'.  But that's not what the user
is interested in when it does 'df path', the user is interested in the
free space under 'path'.

What is the loss of functionality?  For mounts not having
subfilesystems, there will be _no_change_whatsoever_!

> > How will they give more confusing results?  Please ellaborate.
> 
> I mean specifically the case of df and similar things. So far remote
> filesystems generally return obviously invalid results so far. But when
> they are made to return correct values for subfilesystem, these tools
> need a way to find where those subfilesystems start.

Why?  What if that info is simply not available?

You are talking about missing functionality not _loss_ of
functionality.

Yes, possibility for finding out where subfilesystems are located
_will_ be missing for such filesystems as sshfs.  Is that a reason for
asuming subfilesystems don't exsist, and not allowing already existing
tools (filemanagers, openoffice, etc) to make use of a statfs() system
call which can return _meaningful_ results for subfilesystems?

Miklos
