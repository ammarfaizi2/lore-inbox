Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316257AbSETT2r>; Mon, 20 May 2002 15:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316261AbSETT2r>; Mon, 20 May 2002 15:28:47 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:33800 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S316257AbSETT2p>; Mon, 20 May 2002 15:28:45 -0400
Date: Mon, 20 May 2002 14:28:34 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200205201928.OAA13328@tomcat.admin.navo.hpc.mil>
To: michael@hostsharing.net, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: suid bit on directories
In-Reply-To: <20020520165312.3fb29ba2.michael@hostsharing.net>
Cc: pollard@tomcat.admin.navo.hpc.mil, linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hoennig <michael@hostsharing.net>:
> Hi Jesse,
> 
> > > > No. You loose the fact that the file was NOT created by the user.
> > > 
> > > the user in my example above would be wwwrun or httpd - and that does
> > > not make any sense at all! It would make much more sense if the new
> > > files belonged to the owner of the directory, who is the one who owns
> > > the virtual host.
> > 
> > You can't tell who the user is. ANY user would be able to do that.
> 
> of course not, but many features have to be used carefully, like the suid
> bit on files too!

That CAN be audited. Putting a suid on a directory CAN'T.

> I don't want to make the bahaviour or a suid bit on directories the
> default! I just would like it as a mount option, or even something which
> you have to compile into the kernel.

Once mounted/compiled in you have lost control.

> > > > > I do not even see a security hole if nobody other than the user
> > > > > itself and httpd/web can reach this area in the file system,
> > > > > anyway. And it is still the users decision that files in this
> > > > > (his) directory should belong to him.
> > > > 
> > > > 1. users will steal/bypass quota controls
> > > 
> > > Not in my example - acutally even the other way around.
> > 
> > And just how is it prevented? quotas are applied based on either group
> > or user. Normally it is based on user. Once the uid is set, then the
> > quotas start being deducted. If the the user procedes to store 10 G of
> > music files, who is charged? And how do you know who put them there.
> 
> Why do you ignore my example? In my example the use who runs the webserver
> owns all the files, that is wrong. With the suid bit on directories, this
> could be fixed. 

That is NOT wrong. The files belong to the server. Not a user. I've been
running a server that way for years.

And ANY user can put files into YOUR directory. Even files you don't want
there. AND you can't tell who did it.

Remember - with this facility any penetration of of a server suddenly becomes a
penetration of every user with such a directory.

> > > > 2. Consider what happens if a user creates a file in such a
> > > > directory and   it is executable. - since the file is fully owned by
> > > > a different user, it   appears to have been created by that user.
> > > > What protection mask is on   the file? Can the creator (not owner)
> > > > make it setuid?(nasty worm   propagation method)
> > > 
> > > Again: it depends on the usage. In my case it is the other way around.
> > > A use should know what he is doing if he is setting this flag on a
> > > directory.  And making such files suid again, has to be prevented by
> > > the code - that I even mentioned in my first mail on this issue.
> > 
> > How are you going to control it?
> 
> Only the owner of the directories can set this flag. There is nothing to
> control. 

Ah - so I can put files into your directory, and suddenly they are owned
by you. Remember that the next time you are convicted of piracy with criminal
data in your directory.... (DMCA remember - and saying "Those files are not
mine" just doesn't cut it, when obviously they have your uid on them; the
best you would work them down to is "contributing to piracy").

Also remember what happens when a hard link is created in the directory...
The file changes ownership. That will then change the owner of ANY file
on the filesystem. I believe this can happen with sgid directories too
(which would be another reason that mail spool directories were supposed
to be on their own file system).

> UNIX users are able to give rights to everybody to their files, right? How
> do you control that?

MLS/compartmentalization. See SELinux. See mandatory access controls.

Also put users in filesystems where the parent directory only permits
group access: mode 0550. No user outside the group will be able to access
the files, even if the user does grant access. Details:

	sample		- mode 0550
          |
         users          - mode 0555

Only members of the group, or owners will be able to see files in the
directory "users", even though the owner of that directory has granted
world rx access.
 
> You don't! You just let it to the users to give access to there files to
> whomever you want. My case is similar.

NOT the same situation. The OWNER of the file gives ACCESS to files. Not
a user making their files owned by someone else (unless that user
is root). Even giving someone else the ability to create files in your
directory is dangerous, though possible. At least it is still possible to
determine WHO put them there.

This was explicitly removed to prevent quota corruption - the history
of chown originally allowed changing the ownership of a file to anyone in
the system (when done, it did remove setuid from the file). This was
removed under the "prevention of a denial of service" attack.

> > > > > Actually, the suid bit on directories works at least under
> > > > > FreeBSD. Is there any reason, why it does not work under Linux?
> > > > 
> > > > I don't believe it is in the POSIX definition.
> > > 
> > > I only said, it works under FreeBSD, it is an option there.
> > 
> > Then use FreeBSD.
> 
> No comment.
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
