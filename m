Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVEAF4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVEAF4z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 01:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVEAF4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 01:56:54 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:32691 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261538AbVEAF4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 01:56:50 -0400
To: jamie@shareable.org
CC: hch@infradead.org, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <20050430235453.GA11494@mail.shareable.org> (message from Jamie
	Lokier on Sun, 1 May 2005 00:54:54 +0100)
Subject: Re: [PATCH] private mounts
References: <20050425071047.GA13975@vagabond> <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu> <20050430083516.GC23253@infradead.org> <E1DRoDm-0002G9-00@dorka.pomaz.szeredi.hu> <20050430094218.GA32679@mail.shareable.org> <E1DRoz9-0002JL-00@dorka.pomaz.szeredi.hu> <20050430143609.GA4362@mail.shareable.org> <E1DRuNU-0002el-00@dorka.pomaz.szeredi.hu> <20050430164258.GA6498@mail.shareable.org> <E1DRvRc-0002lq-00@dorka.pomaz.szeredi.hu> <20050430235453.GA11494@mail.shareable.org>
Message-Id: <E1DS7RB-0004Md-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 01 May 2005 07:56:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not necessary.
> 
> Why not have the FUSE daemon keep open a file descriptor for the
> directory it's mounted on, and have it sent that to new would-be
> mounters of the same directory using a unix domain socket (rather as
> Pavel suggested)?

How does that help?  It doesn't matter _which_ process you try to bind
mount /proc/XXX/fd/N from, the result will be the same.

> No.  The check is to prevent processes in chroot jails from accessing
> directories outside their jail.  Even CAP_SYS_ADMIN processes must be
> forbidden from doing that.

As someone pointed out, CAP_SYS_ADMIN processes can already escape the
chroot jail with CLONE_NEWNS.  (fd=open("."); clone(CLONE_NEWNS);
[child:] fchdir(fd); chdir(".."))

> But proc_check_root is unnecessarily strict, in that it prevents a
> process from traversing into a "child" namespace.
> 
> IMHO, a better security restriction anyway would be for processes in
> chroot jails to not be able to see processes outside the jail in /proc
> - only processes inside the jail should be visible.  I think everyone
> agrees that would be best.

Dunno.  It's a big change possibly breaking existing applications.
Chroot probably has other uses than jailing.

> If that were implemented, then proc_check_root would be redundant and
> could be removed entirely.

Yes. 

Miklos
