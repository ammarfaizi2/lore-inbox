Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUBNPpu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 10:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUBNPpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 10:45:50 -0500
Received: from [203.94.74.174] ([203.94.74.174]:25256 "EHLO
	ENETSLMAILI.enetsl.Virtusa.com") by vger.kernel.org with ESMTP
	id S262055AbUBNPg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 10:36:56 -0500
Subject: Implementing SQL on files
From: Anuradha Ratnaweera <anuradha@linux.lk>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Lanka Linux User Group
Message-Id: <1076773002.20087.42.camel@aratnaweera.enetsl.virtusa.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 14 Feb 2004 21:36:42 +0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2004 15:36:14.0128 (UTC) FILETIME=[4782B300:01C3F310]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I am starting to write some code to add a feature which I think would be
very useful, and like to get comments and suggessions from LKML.  Please
ignore this mail if it sounds like nonsense ;-)

Also, if this is already happenning somewhere, please enlighten me.

Short version: This feature will add a "table" file type and SQL
executioin premitives to the kernel, and also relevent userspace
programs.

Still reading?  Ok, here are the glory details:

Longer version
--------------

Both the two popular open source database systems, Postgres and Mysql
are going through the filesystem layer to manage databases, as opposed
to some commercial counterparts that talk to the block IO layer
directly.  Also, most databases implement user management seperate from
the UNIX user database.  And the database is seperate from the rest of
the filesystem.

The feature I am planning to implenet will overcome these limitations by
implementing a "table" filetype, and the primitive SQL operations in the
kernel.

Parsing SQL, optimizing etc. will happen at the user space.

But here comes the interesting part. I am planning to do this without
breaking VFS and traditional UNIX syscalls.  To clarify, consider this 
table:

Name                Version
----                -------
David Weinehall     2.0
Alan Cox            2.2
Marcelo Tosatti     2.4

Using the userspace tools, one can create a "table" file (say
maintainers), and insert the data to that file.  Each file (or may be
filesystem) has two characters (or strings) associated with them: field
seperator and record seperator.  Say, colon and newline.  If I cat the
file:

% cat maintainers
David Weinehall:2.0
Alan Cox:2.2
Marcelo Tosatti:2.4
%

Now, if I want to add something to the table, either I can use the
relevenet userspace tools, but the following also will work.

% echo 'Linus Torvalds:2.6' > maintainers
%

Even if one uses vi to edit the file instead of a simple echo, it won't
get that complicated.

The nice thing about this is that now we don't need a seperate
authentication mechanism.  Also, the database no longer needs to be a
seperate entity (it need not exist at first place!).

As far as I can see, the best way to implement this is as a ReiserFS 4
module.

Like to hear some comments and suggessions.

Thanks for reading all the way here ;-)

	Anuradha

-- 

http://www.linux.lk/~anuradha/


