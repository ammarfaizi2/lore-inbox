Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314554AbSEUNeZ>; Tue, 21 May 2002 09:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSEUNeY>; Tue, 21 May 2002 09:34:24 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:46347 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S314554AbSEUNeX>; Tue, 21 May 2002 09:34:23 -0400
Date: Tue, 21 May 2002 08:34:07 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200205211334.IAA21448@tomcat.admin.navo.hpc.mil>
To: dax@gurulabs.com, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: suid bit on directories
cc: linux-kernel@vger.kernel.org,
        "michael@hostsharing.net" <michael@hostsharing.net>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson <dax@gurulabs.com>
> On Mon, 20 May 2002, Jesse Pollard wrote:
> 
> > > > No. You loose the fact that the file was NOT created by the user.
> > > 
> > > the user in my example above would be wwwrun or httpd - and that does not
> > > make any sense at all! It would make much more sense if the new files
> > > belonged to the owner of the directory, who is the one who owns the
> > > virtual host.
> > 
> > You can't tell who the user is. ANY user would be able to do that.
> 
> Bzzzt.  Only if the permissions permitted it.
> 
> 
> Example 1:
> 
> /home/bob/public_html
> 
> public_html  is user/group  bob/httpd
> 
> the perms are 2770
> 
> ============================
> 
> Example 2:
> 
> All users on the system have a primary or secondary group "users"
> 
> /home/bob   user/group  bob/users
> 
> perms are 701
> 
> This explictly denies "users", yet allows Apache in (since it is running 
> as httpd).


And if "bob" makes the file world readable it can't be read by someone else?
And if the file is supposed to be updated by the web server it can't be
created (truncated, unless also world writeable)? If not, then his implies that
besides changing the owner of created files, the changed owner is also
used to verify authorization to create.

Granted, this limits the identity of the attacker to anyone in the group
httpd or the user.

And the world x doesn't grant access? (have you seen the attempts to get
a "open file by inode" added? very usefull for file migration - and almost
mandatatory for performance reasons. And also usefull for attacks.
Fortunately, it isn't there yet, and hopefully it will be restricted).

The attacker may not be able to read the directory, but he can certanly
attack it by just creating/opening files in the home directory. That could gain 
access to OTHER files in the home directory.

You also have problems with backup/restore done by users. Tar/cpio will/can
change the group ownership of the directory, and will change group ownership
of any files/subdirectories restored. Even cp would cause problems
by preventing the web server from access (again, it must be created world
readable). Also exposes potential damage in crash situations (though not
as bad as external attack - lost files become world accessable).

ACLs would be much easer to support. Try them out..

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
