Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVIKGKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVIKGKl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 02:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbVIKGKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 02:10:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:11994 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964780AbVIKGKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 02:10:40 -0400
Date: Sat, 10 Sep 2005 22:09:06 -0700
From: Greg KH <gregkh@suse.de>
To: Mike Bell <mike@mikebell.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
Message-ID: <20050911050906.GA6635@suse.de>
References: <20050909214542.GA29200@kroah.com> <20050910082732.GR13742@mikebell.org> <20050910215254.GA15645@suse.de> <20050910230310.GS13742@mikebell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910230310.GS13742@mikebell.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 04:03:12PM -0700, Mike Bell wrote:
> On Sat, Sep 10, 2005 at 02:52:54PM -0700, Greg KH wrote:
> > I didn't say it was a "nice" solution, fully LSB compliant and all.  All
> > it is is a solution that can work for some people, if they just want a
> > small, in-kernel devfs-like solution.
> 
> It's not a solution if it doesn't /work/. If you think this works for
> anyone who likes devfs, you clearly still don't understand what said
> people like about devfs in the first place.

Said people who like devfs are lazy and don't like running userspace
programs.  They pretty much also are pretty restricted to embedded
systems.  That's all I have been able to determine so far.  Care to help
flush this profile out some?

> > And it works just fine for alsa and input devices for me, just no
> > subdirs :)
> 
> What version of alsa libraries are you using that can deal with the
> device nodes in the root of /dev? I'm grepping the latest source code
> right now and I don't see it. Or is this yet another one of those facts
> you just made up? In what sense can alsa be said to work if zero alsa
> programs work?

My applogies, I used the OSS compatible module for ALSA when I tested
this out.  Hey, might as well use 1990's style interfaces, for 1990's
style kernel features... :)

> > Anyway, I'm not offering it up for inclusion in the kernel tree at
> > all, but for a proof-of-concept for those who were insisting that it
> > was impossible to keep a devfs-like patchset out of the main kernel
> > tree easily.
> 
> You can use ndevfs, if you don't care about your device nodes working.
> However that kind of defeats the purpose. To have a /working/ devfs-like
> solution you need the names, and currently the only way to get those is
> the devfs hooks.

Hm, ok, ALSA will not work.  Can you point to anything else?  Who cares
about sound on embedded systems anyway...

> Nobody is obligating you to provide a working ndevfs, but don't claim
> it's a solution when it's not. A devfs-like solution whose device nodes
> have random names which break programs is copying the form of devfs
> (exporting nodes from kernel space) and ignoring the point of devfs.

I'm claiming that the people who insisted that keeping the devfs
patchset outside of the mainline kernel was impossible.  I show how to
do this with 3 calls to "add a node" and three calls to "remove a node",
in a total of only 2 different kernel files.  Such a patch is _easily_
maintainable for pretty much forever outside the kernel tree.  Distros
maintain patches _way_ more complex and rough than that all the time.

That is my main point about ndevfs.

thanks,

greg k-h
