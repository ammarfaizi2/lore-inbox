Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267766AbUIFLym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267766AbUIFLym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 07:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267770AbUIFLyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 07:54:41 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:39148 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S267766AbUIFLyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 07:54:39 -0400
Date: Mon, 6 Sep 2004 13:54:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Message-ID: <20040906115428.GA25429@wohnheim.fh-wedel.de>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de> <20040904153902.6ac075ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040904153902.6ac075ea.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 September 2004 15:39:02 -0700, Andrew Morton wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> >
> > o Add sendfile() support for file targets to normal mm/filemap.c.
> 
> This comes up fairly regularly.  See, for example,
> http://lwn.net/Articles/88751/ for what appears to be a much simpler
> implementation.

Yes, I saw it and commented on it.  Al didn't seem to like the set_fs
very much, so that specific implementation appears to be dead.

> I discussed file->file sendfile with Linus a while back and he said
> 
> > I think it was about doing a 2GB file-file sendfile, and see your system
> > grind to a halt without being able to kill it.
> > 
> > That said, we have some of the same problems with just regular read/write 
> > too. sendfile just makes it easier.
> > 
> > We should probably make read/write be interruptible by _fatal_ signals.  
> > It would require a new task state, though (TASK_KILLABLE or something, and
> > it would show up as a normal 'D' state).
> 
> I don't know how much of a problem this is in practice - there are all
> sorts of nasty things which unprivileged apps can do to the system by
> overloading filesystems.  Although most of them can be killed off by the
> sysadmin.
>
> (My infamous bash-shared-mappings stresstest can spend ten or more minutes
> within a single write() call, but you have to try hard to do this).

Sure, a 2GB copyfile(2) is nasty (sendfile can at least return a short
count), esp. with slow media like a usb1 attached hard drive.  Might
be a reasonable short-term solution to return -EFBIG whenever a user
tries to copy a file >$PRETTY_LARGE and doesn't have CAP_WHATNOT.

Would you accept such a solution?  And if you would, which magic
constants should I use?

Jörn

-- 
When you close your hand, you own nothing. When you open it up, you
own the whole world.
-- Li Mu Bai in Tiger & Dragon
