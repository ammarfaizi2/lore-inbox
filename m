Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbULNRVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbULNRVt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 12:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbULNRVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 12:21:48 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:36244 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261564AbULNRVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:21:40 -0500
Date: Tue, 14 Dec 2004 18:21:33 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
cc: Hans Reiser <reiser@namesys.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
In-Reply-To: <1103043518.21728.159.camel@pear.st-and.ac.uk>
Message-ID: <Pine.LNX.4.61.0412141812250.5600@yvahk01.tjqt.qr>
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl> 
 <41ACA7C9.1070001@namesys.com> <1103043518.21728.159.camel@pear.st-and.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Following the recent discussions on the lists on "file as directory", I
[...]

Recently I discovered that calling "joe /etc" on FreeBSD opens the directory 
itself (rather than erroring out with EISDIR). The byte string looked like a 
number of "struct dirent"s. Did it break apps in BSD? I donot think so.

(Hell, I just voted _for_ the directory-as-a-file and vice-versa stuff, I'm 
never gonna regret it to myself :)

>would automatically give you the glued file (without having to add the
>.glued !) and when you access it as a directory (using readdir(), for
>instance), you would get the components listed as a directory.
>(I am not sure whether the access method, e.g. read() vs. readdir() is
>sufficient to distinguish the meaning. Another way may be putting a "/"
>after the objectname to indicate that you want it as a directory.)

I would not rely on that. Many apps strip a trailing slash (just to add it 
later again) or vice versa!

>If we do this, the applications don't need to know whether they are
>dealing with an object consisting of small files, aggregated, or whether
>they are looking at a big file with some way of accessing their parts.
>If an old application (or user) looks for the /etc/passwd file, it will
>still get what it expects without having to know that the file is an
>aggregate.

What will ls do? Consider this on a "normal" filesystem:

ls -l /etc/passwd
-rw-r--r--  1 root root 1614 Dec 12 23:57 /etc/passwd
ls -l /etc
[lots of files]


What will happen on v4 then?
ls -l /etc
-rw-r--r-- 1 root root 123456 Dec 01 23:45 /etc
ls -l /etc/passwd
-rw-r--r-- 1 root root 1234 Dec 01 23:45 root
-rw-r--r-- 1 root root 1234 Dec 01 23:45 jengelh
-rw-r--r-- 1 root root 1234 Dec 01 23:45 daemon
-rw-r--r-- 1 root root 1234 Dec 01 23:45 sys
-rw-r--r-- 1 root root 1234 Dec 01 23:45 stduser

It's because "ls" checks the type of the argument to decide what to do (unless
you add -d).


Jan Engelhardt
-- 
ENOSPC
