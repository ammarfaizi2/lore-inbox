Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWFNJr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWFNJr6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 05:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWFNJr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 05:47:57 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:27594 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964828AbWFNJr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 05:47:57 -0400
Date: Wed, 14 Jun 2006 11:47:38 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Marc Perkel <marc@perkel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Visionary ideas for SQL file systems
In-Reply-To: <448F8F18.4030200@perkel.com>
Message-ID: <Pine.LNX.4.61.0606141135230.5349@yvahk01.tjqt.qr>
References: <448F8F18.4030200@perkel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why not put an SQL filesystem directly on a block devices where files are
> really blobs within the filesystem and file names and file attributes are all
> indexed data withing the SQL database. The operating system will have SQL built
> in.

Yet another potential security hole. A kernel oops/panic or even exploit is 
more critical than a userspace exploit. Hey, mysql for example runs as 
unprivilegued, but can your kernel do that? Hardly, I suppose.

> Right now we have a variety of name spaces, file attributes, cluster sises,
> inodes and other nasty stuff that are too exposed. Suppose that you could add
> any fileds you want, any keys you want. Suppose that users and groups could
> have any number of fields. Suppose you wanted to add more levels like
> "managers" and some of the fancy Novell stuff. With a database the user could
> create any kind of an interface to access files that they want.
>
> Picture this. When listing a directory how do we determine who gets to see what
> file names?

Why not just add another directory which is read-protected for all unknown 
users? At least that's what suffices for me.

> I siggest that the rule be an SQL query that the system owner can
> configure anyway they want. That way you can set it up so that the users only
> see the file names that they have access to and you could emulate Linux, or you
> could emulate Windows, or you could emulate Netware, or each directory could
> have it's own embedded rules that are itself stored within the database.
>
> Now - we hav files that we can read, write, lock, create, delete, etc. The file
> appear to be a colection of bytes, but what if they aren't really a collection
> of bytes?

Unpredictable application behavior may arise.

> Suppose what appeard as a text file was really the output of a query
> that created what looks like a file but eack line was a record in an SQL
> database? Writing the file might not be storing bytes but rather storing rows
> in a database. The reading and writing of the file would be controlled by the
> files read query and write query, So if you want it to work like today's files
> then you are reading and writing a blob. But that would be just one of many
> options.

IIRC databases are better off storing simple data rather than blobs. Too 
bad most files are rather big.

> For example, if you are using an embedded query to read and write files the
> lines of one file might also be lines in a different file that has a query that
> intersects the same data. So if you write a line in one file you could change
> the corisponding line in another file that includes the same data element.

Unpredictable application behavior may arise.

> So if your writing a program and you change the name of an include file then
> everything that references that file changes the moment you rename it.
>
> A tar file wouldn't be a separate file. It might just be a query that creates a
> tar file view of other existing files. By creating a name with a .tar extension
> and pointing it to a directory makes a tar view of an existing directory. But
> you can edit the contents of the tar file by editing the files withing the
> directory that the tar query points to.

An SQL server generating tar archives? Goes against Unix philosophy that 
one thing should only do one thing, and do that thing well.

> So - this is totally outside the bix thinking but use you imagination and
> envision what could be done if we lose the file system paradyme and embrace the
> SQL based data paradhyme.
>
> Will it be faster? Doing only what we are limited to today, no. Doing what we
> would be able to do, yes. This is a radically new concept and you should be
> very stoned to fully appreciate it. I just wanted to throw the idea out there
> so that people can start rolling it around and thinking about it. It's an idea
> that is similar in some ways to the /proc filesystem where things appear as
> files that aren't

that are not what? Real? That is because it lists information about dynamic 
"things", processors, memory state, etc. But files are mostly static (esp. 
file and ftp servers). The SQL approach for such fileservers seems to me 
like the outer maximum opposite idea to XFS realtime.


Jan Engelhardt
-- 
