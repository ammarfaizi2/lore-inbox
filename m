Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269685AbUJAELX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269685AbUJAELX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 00:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269690AbUJAELW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 00:11:22 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:54934 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269685AbUJAEK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 00:10:57 -0400
Date: Thu, 30 Sep 2004 21:09:20 -0700
From: Paul Jackson <pj@sgi.com>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: rml@novell.com, akpm@osdl.org, ttb@tentacle.dhs.org,
       cfriesen@nortelnetworks.com, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       iggy@gentoo.org
Subject: Re: [RFC][PATCH] inotify 0.10.0
Message-Id: <20040930210920.707a5421.pj@sgi.com>
In-Reply-To: <1096593755.26742.168.camel@orca.madrabbit.org>
References: <1096250524.18505.2.camel@vertex>
	<20040926211758.5566d48a.akpm@osdl.org>
	<1096318369.30503.136.camel@betsy.boston.ximian.com>
	<1096350328.26742.52.camel@orca.madrabbit.org>
	<20040928120830.7c5c10be.akpm@osdl.org>
	<41599456.6040102@nortelnetworks.com>
	<1096390398.4911.30.camel@betsy.boston.ximian.com>
	<1096392771.26742.96.camel@orca.madrabbit.org>
	<1096403685.30123.14.camel@vertex>
	<20040929211533.5e62988a.akpm@osdl.org>
	<1096508073.16832.17.camel@localhost>
	<20040929200525.4e7bb489.pj@sgi.com>
	<1096558180.26742.133.camel@orca.madrabbit.org>
	<20040930092744.5eb5ea10.pj@sgi.com>
	<1096563193.26742.152.camel@orca.madrabbit.org>
	<20040930104808.291d9ddc.pj@sgi.com>
	<1096593755.26742.168.camel@orca.madrabbit.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray wrote:
> > So passing back an inode number doesn't come close to reintroducing
> > the forced tracking of all the interesting stat data of every file.
> 
> It certainly forces userspace to track all file names and inodes, at
> least. Userspace wishes to know about deletes and renames. Unless it
> caches everything, it won't know what was deleted, or what got renamed.

Aha ... you finally got through my thick skull.  Congratulations ;).

If file "foo" goes away, and if the kernel only reports that inode
314159 was unlinked from a given directory, unless some user code
previously remembered that inode 314159 was accessible from the
directory entry named "foo", you can't tell the user that "foo"
disappeared.

Do you have the same problem with directories, if some cookie, not the
full pathname, is passed back after an 'rmdir(2)' event?  Or is it just
that it's less onerous to track all the directories, because there's
fewer of them?


> You're saying pass the inode number, as it's smaller and makes for an
> easier and higher speed interface to get changes to userspace (if I
> understand you correctly).

That was the idea, yes.  Most of it anyway.  That and striving to keep
the API the kernel presents to the user minimal and orthogonal.


> I'm saying that if the kernel has the information already, and we're not
> passing it to userspace, and userspace *needs* that information, then
> all we've done is guarantee another long set of syscalls while it tries
> to pull the directory contents to match up item for item against its
> cache of previously known file states.

If there is a way, any way, for user code to get something from the
kernel, then I don't mind dragging my feet on providing other ways,
until I see a good reason.  It's always worth a bit of effort to keep
kernel API's minimal and orthogonal.

Your "delete and rename" point above seems now like a good reason.


> I've been avoiding saying this, as this really will be a bit more
> complex than even my suggestions, but perhaps everyone would be happier
> if we crammed all this through a netlink socket instead. Got me.

No comment ;).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
