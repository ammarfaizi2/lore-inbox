Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWCSVYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWCSVYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 16:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWCSVYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 16:24:25 -0500
Received: from orca.ele.uri.edu ([131.128.51.63]:4570 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S1751029AbWCSVYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 16:24:24 -0500
Subject: Re: Question regarding to store file system metadata in database
From: Ming Zhang <mingz@ele.uri.edu>
Reply-To: mingz@ele.uri.edu
To: lkml@societasilluminati.org
Cc: Al Viro <viro@ftp.linux.org.uk>, Xin Zhao <uszhaoxin@gmail.com>,
       mikado4vn@gmail.com, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <441DC2D6.4060001@societasilluminati.org>
References: <4ae3c140603182048k55d06d87ufc0b9f0548574090@mail.gmail.com>
	 <441CE71E.5090503@gmail.com>
	 <4ae3c140603190948s4fcd135er370a15003a0143a8@mail.gmail.com>
	 <1142791121.31358.21.camel@localhost.localdomain>
	 <4ae3c140603191011r7b68f4aale01238202656d122@mail.gmail.com>
	 <1142792787.31358.28.camel@localhost.localdomain>
	 <4ae3c140603191050k3bf7e960q9b35fe098e2fbe35@mail.gmail.com>
	 <20060319194723.GA27946@ftp.linux.org.uk>
	 <441DC2D6.4060001@societasilluminati.org>
Content-Type: text/plain
Date: Sun, 19 Mar 2006 16:24:09 -0500
Message-Id: <1142803449.2553.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-19 at 15:45 -0500, Ian Young wrote:
> Indeed. I think the issue here is that someone doesn't grasp that the
> filesystem is already a database: that in fact path and filenames are
> already metadata, with inode as the pkey, and they are indexed by
> linked lists, b-trees, or hashtables,  just as you might have going on
> inside the "black box" that is a database. The problem is that he
> thinks databases are somehow different because you use SQL to interact
> with them, when in fact the very same things that go on in
> filesystems, are going on in databases, just that with a database, you
> have strict pre-set agreements about what you'll be storing, so you
> can lay it out on-disk more efficiently. In a filesystem, there's no
> guarantee, or way to guarantee "this group of things will always be
> written in 256-word chunks", so it seems like something you could
> optimise using "a database" but it only shows ignorance of what
> exactly databases do. And... I'm fairly sure someone could write a
> SQL-like 'find' implementation in userland, and then you could query
> your "Database".

agree. all fancy/complex algorithm and data structures like trees are
used here already. and with some file systems get ACID as well, it can
be called as a database, if someone really want to call it in that
name. ;)


> 
> A better suggestion would be along the lines of "why don't we
> standardize a common set of metadata types to expand on directory,
> filename, size, mtime, ctime, atime, owner, and group? Why not 'type'
> 'title' 'author' 'revision' 'comment' 'icon' 'readers' 'writers'
> 'executors' 'checksum' etc.. etc...?" Now, THAT's something I'd like
> to see. 

that is why we have VFS right?


> 
> 
> Al Viro wrote: 
> > On Sun, Mar 19, 2006 at 01:50:22PM -0500, Xin Zhao wrote:
> >   
> > > Last, database-based file system is not so complex. As first step, I
> > > am just proposing to store pathanem-to-inode number in database. So it
> > > is basically a simple table. We don't really need any fancy features
> > > provided by db system. That's why I said a reduced  db system is
> > > enough. So the only difference betwen db-based file system and a
> > > regular one is that regular file system use directory file to store
> > > entries, but db-based file system use database to achieve the same
> > > goal. Looks like db will be a more efficient way. ;-)
> > >     
> > 
> > Define "database".  And explain how any of existing filesystems manages
> > to _not_ qualify your definition.
> > 
> > As for "more efficient"...  300 lookups per second is less than an
> > improvement.  It's orders of magnitude worse than e.g. ext2; I don't
> > know in which world that would be considered more efficient, but I
> > certainly glad that I don't live there.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >   

