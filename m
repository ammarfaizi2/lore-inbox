Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315936AbSETNE0>; Mon, 20 May 2002 09:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSETNEZ>; Mon, 20 May 2002 09:04:25 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:56325 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S315936AbSETNEY>; Mon, 20 May 2002 09:04:24 -0400
Date: Mon, 20 May 2002 08:04:22 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200205201304.IAA07423@tomcat.admin.navo.hpc.mil>
To: michael@hostsharing.net,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suid bit on directories
In-Reply-To: <20020518103432.5a3b4c67.michael@hostsharing.net>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hoennig <michael@hostsharing.net>:
> 
> Hello!
> 
> I am new on this list and thoroughly searched the FAQ, the archives and
> the web for this question, but couldn't find anything.
> 
> We wondererd why setting the guid bit on a directory makes all new files
> owned by the group of the directory, but this does not work for the suid
> bit, making new files owned by the owner of the directory.

The setgid bit on a directory is to support BSD activities. It used to be
used for mail delivery.

> It would be a good solution to make files created by Apaches mod_php in
> safe-mode, not owned by web:web (or httpd:httpd or somethign) anymore, but
> the Owner of the directory. 

No. You loose the fact that the file was NOT created by the user.

> I do not even see a security hole if nobody other than the user itself and
> httpd/web can reach this area in the file system, anyway. And it is still
> the users decision that files in this (his) directory should belong to
> him.

1. users will steal/bypass quota controls

2. Consider what happens if a user creates a file in such a directory and
   it is executable. - since the file is fully owned by a different user, it
   appears to have been created by that user. What protection mask is on
   the file? Can the creator (not owner) make it setuid? (nasty worm
   propagation method)

> It seems, this has to be patched for each file system separately, right?
> For example in linux/fs/ext2/ialloc.c.
> 
> Actually, the suid bit on directories works at least under FreeBSD. Is
> there any reason, why it does not work under Linux?

I don't believe it is in the POSIX definition.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
