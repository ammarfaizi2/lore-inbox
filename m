Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAIOGG>; Tue, 9 Jan 2001 09:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130747AbRAIOFp>; Tue, 9 Jan 2001 09:05:45 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:24128 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S129226AbRAIOFb>; Tue, 9 Jan 2001 09:05:31 -0500
Date: Tue, 9 Jan 2001 08:05:29 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101091405.IAA24807@tomcat.admin.navo.hpc.mil>
To: phillips@innominate.de, "Michael D. Crawford" <crawford@goingware.com>,
        Stephen Rothwell <sfr@linuxcare.com.au>, linux-kernel@vger.kernel.org
Subject: Re: FS callback routines
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@innominate.de>:
> "Michael D. Crawford" wrote:
> > 
> > Regarding notification when there's a change to the filesystem:
> > 
> > This is one of the most significant things about the BeOS BFS filesystem, and
> > something I'd dearly love to see Linux adopt.  It makes an app very efficient,
> > you just get notified when a directory changes and you never waste time polling.
> > 
> > I think it would require changes to the VFS layer, not just to the filesystems,
> > because this is a concept POSIX filesystems do not presently possess.
> > 
> > The other is indexed filesystem attributes, for example a file can have its
> > mimetype in the filesystem, and any application can add an attribute and have it
> > indexed.
> > 
> > There's a method to do boolean queries on indexed attributes, and you can find
> > files in an entire filesystem that match a query in a blazingly short time, much
> > faster than walking the directory tree.
> > 
> > If you want to try out the BeOS, there's a free-as-in-beer version at
> > http://free.be.com for Pentium PC's.  You can also purchase a version that comes
> > for both PC's and certain PowerPC macs.
> > 
> > There are read-only versions of this for Linux which I believe are under the
> > GPL.  The original author is here:
> > 
> > http://hp.vector.co.jp/authors/VA008030/bfs/
> > 
> > He refers you to here to get a version that works under 2.2.16:
> > 
> > http://milosch.net/beos/
> > 
> > The author's intention was to take it read-write, but it's complex because it is
> > a journaling filesystem.
> > 
> > Daniel Berlin, a BeOS developer modified the Linux BFS driver so it works with
> > 2.4.0-test1.  I don't know if it works with 2.4.0.  The web site where it used
> > to be posted isn't there anymore, and the laptop where I had it is in for
> > repair.  I may have it on a backup, and I'll see if I can track Daniel down.
> > 
> > While Be, Inc.'s implementation is closed-source, the design of the BFS (_not_
> > "befs" as it is sometimes called) is explained in Practical File System Design
> > with the Be File System by Dominic Giampolo, ISBN 1-55860-497-9.  Dominic has
> > since left Be and I understand works at Google now.
> 
> fs/dnotify.c:
> 
>    /*
>     * Directory notifications for Linux.
>     *
>     * Copyright (C) 2000 Stephen Rothwell
>     ...
> 
> The currently defined events are:
> 
> 	DN_ACCESS	A file in the directory was accessed (read)
> 	DN_MODIFY	A file in the directory was modified (write,truncate)
> 	DN_CREATE	A file was created in the directory
> 	DN_DELETE	A file was unlinked from directory
> 	DN_RENAME	A file in the directory was renamed
> 	DN_ATTRIB	A file in the directory had its attributes
> 			changed (chmod,chown)
> 
> It was done last year, quietly and without fanfare, by Stephen Rothwell:
> 
>   http://www.linuxcare.com/about-us/os-dev/rothwell.epl
> 
> This may be the most significant new feature in 2.4.0, as it allows us
> to take a fundamentally different approach to many different problems. 
> Three that come to mind: mail (get your mail instantly without polling);
> make (don't rely on timestamps to know when rebuilding is needed, don't
> scan huge directory trees on each build); locate (reindex only those
> directories that have changed, keep index database current).  As you
> noticed, there are many others.
> 
> Stephen, it would be very interesting to know more about the development
> process you went through and what motivated you to provide this
> fundamental facility.

It would also be very nice if the security of the feature could be
confirmed. The problem with SGI's implementation is that it becomes
possible to monitor files that you don't own, don't have access to,
or are not permitted to know even exist. For these reasons, we have
disabled the feature.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
