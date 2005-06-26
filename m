Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVFZOvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVFZOvj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 10:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVFZOvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 10:51:36 -0400
Received: from imap.gmx.net ([213.165.64.20]:51376 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261294AbVFZOtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 10:49:32 -0400
X-Authenticated: #9500999
From: Daniel Arnold <arnomane@gmx.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: reiser4 plugins
Date: Sun, 26 Jun 2005 16:49:21 +0200
User-Agent: KMail/1.8
References: <200506250040.j5P0eXDQ005342@laptop11.inf.utfsm.cl>
In-Reply-To: <200506250040.j5P0eXDQ005342@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506261649.22172.arnomane@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 25. Juni 2005 02:40 schrieb Horst von Brand:
> Daniel Arnold <arnomane@gmx.de> wrote:
>
> [...]
>
> > Although I'm currently using ReiserFS v3 at my (Suse) Linux box (and am
> > happy that it uses my small hard disk space better than other file
> > systems and that I could always repair the data on the file system in
> > some minutes at least in large parts
>
> Not enough in my book.

Well I'm no expert in data rescue after a severe hardware crash and with ext2 
or ext3 it wouldn't have been any better (even worse with ext2). So I'm just 
wondering why you have such high expectations towards any Reiser-FS-version 
but not at the same time to other file systems.

And beside that the good usage of my harddisk space (20 Gigabytes) is for me a 
_very_ strong point in using ReiserFS as the computer I'm talking about is 
not able to use hard disks larger than 32GB and I don't want to buy a new 
computer because of that.

And have you ever heared of the problem of Wikipedia storage? Their old SCSI 
storage system had no additional slot left, so there was need to buy an 
entire new storage array and this wasn't/isn't cheap. And of course the 
database grows exponentially. So there was need for a solution that is orders 
of magnitudes larger. The first solution was reducing the data storage 
problem at the root: compression (gzip compressed chunks of 20 following 
versions of an article; reduced the database by 85%). The second step is the 
new storage hardware. So a filesystem with intelligent disk usage is very 
much appreciated there too, regardless how big the storage array is...

> > One big thing are all the nice applications that want databases like
> > MySQL.
>
> Shoving the RDBMS into the kernel doesn't solve this, quite to the
> contrary. It makes the whole system less flexible (if you don't want MySQL
> but something else, you can't get it easily). The whole is /more/ complex
> (kernel space programming is /a huge lot harder/ than userspace
> programming). It will be /much more/ unstable, as any idiotic bug in the
> RDBMS will bring the /whole system/ down, or screw up completely unrelated
> innocent bystanders.

Ok. You're afraid that this would be again some kind of kernel-httpd. But it 
won't be for the following reasons:

The storage part of a database only one part of a database application. Many 
programming lines of a database package are about creating nice tools and 
interfaces for easy access and manipulation of the stored data, like a 
SQL-interpreter and such.

Filesystems _are_ storage backends, so existing database applications are 
duplicating this storage part today as their programmers and users are anoyed 
by the poor and less flexible possibilities the filesystems provide.

Reiser4 won't provide anything but the storage part. All the tools accessing 
this thing are userland applications.

You can access this "reiser4-database" with standard tools like cp, rm, mv, ls 
and such but you could also create an userland SQL-interface for this - and 
this will be done for sure as this would be a very easy possibility to 
enhance existing applications based on SQL-databases using the new features 
of Reiser4 beside existing databases too.

What userland tools you use to acess this filesystem is upon your decission 
(of course also which tools do exist). Why not acess a filesystem 
additionally with SQL?

E.g. Wikipedia has a constant problem with CPU usage of their servers, so 
people are flaming that PostgreSQL is faster than MySQL and Wikipedia should 
not use MySQL. But what about a solution based on Reiser4 (revision storage 
and on the fly compression needed) with a userland SQL-interface? Reiser4 
_is_ fast and is data loss safe.

> > the same software using an intelligent file system without need for a
> > special database would be a big step in end user usability especially but
> > not only at the desktop. And of course you can easily manipulate your
> > database with easy standard tools like a file manager or from command
> > line like cp, mv, rm which would be again a big step back to simplicity.
>
> If what you want to do can be expressed in terms of ln(1), mv(1), rm(1) et
> al, do use them and be happy: No need for any fancy database stuff. If it
> can't, I'm sorry, but it /will/ be complex anyway.

Well of course ln, mv, rm are indeed simple and you won't base complex actions 
on these tools as they are simply not the right tools for complex jobs but in 
principle you can do it and you will do it if the action you want to do is 
simple enough. In case you want a more powerfull solution you choose a 
different tool to acess the same data, see above.

> And why don't you use a version management system for this? You could use
> RCS (simple, easy to use; but doesn't handle sideways relations at all), or
> something more complex. Userland solutions /do/ exist, and work fine. They
> even handle saving stuff over the network, etc.

Well yes I could do it for myself. But the majority of users (Im talking of 
"innocent stupid" computer users here) will never get those benefits as it is 
simply to complex and so distributions as Suse, RedHat and others will not 
base a key feature of their systems on an additional complexity caused by a 
daemon like CVS and of course those revision systems aren't really nice to 
look at via a file manager (ok there exists Cervisia-KIO-slave in KDE - again 
a filesystem plugin in a high level application).

And here again: The storage part of revision systems is not that big it only 
needs to be flexible enough. Most important are the userland tools that 
enable you manipulating the data. And why did Subversion not choose plain 
file storage as CVS? They simply disliked the limitations caused by todays 
standard file systems and so they went away from the file system to a 
database. 

Quote of their FAQ:

"The repository is built on a database (currently Berkeley DB) and exports a C 
API that simulates a filesystem -- a versioned filesystem."

So with Reiser4 Subversion wouldn't need to base the storage on a database and 
do unnecessary double work and could base their storage on a prooven stable 
file system as Reiser4.

> > Another possibility would be e.g. replacing the RPM-database by a
> > structure in the Reiser4 file system. [...]
> And shove RPM into the kernel...

No I never said that the RPM-tool should get into the kernel as this wouldn't 
make any sense. The userland RPM-tool will be still the right tool in complex 
cases but you can also manipulate the database with other userland tools if 
you like.

> Yes, there are operating systems around that
> don't have "files", everything is in a database. PHBs love them, the
> people who develop for them or have to manage them hate them.

I would also dislike an operating system where I can't acess my data in 
standard ways with a hierarchical filesystem but how could Reiser4 be a 
problem regarding that? Reiser4 does not touch the file system view it only 
enhances it and makes it even more transparent as internal structures (that 
are until now only accessible via special tools) are now also a file.

> Again, operating systems with funny "just as applications require"
> structured files were common until Unix came along with the simple "a file
> is a sequence of bytes, do as you wish with it but in userland" and the lot
> went away like a bad dream. Unix is about simple, generic infrastructure on
> which you can build what /you/ want, not just what /the system/ allows.
> Don't kill that.

This won't kill simplicity. It would bring back simplicity where it has sadly 
gone. And of course Unix was the OS with the radical "everything is a file 
vision". What are devices? What is below /proc? These are all systems that 
enable you access to completly different things via the well known file 
system.

So Reiser4 is a consequent way in the "everything is a file roadmap".

> Chicken and egg: Applications using strange filesystem semantics won't show
> up until said semantics are commonplace, which won't be until there is
> extensive use...

Well one could simply create a userland SQL-interface for Reiser4 and many 
server applications could use its benefits in no time (for sure in the 
beginnings "real SQL databases" would have more features).

> No. It has to be done right (or nearly right) from the start. Also,
> screwing around with filesystems /is/ risky, as it could affect innocent
> bystanding filesystems.

How can Reiser4 affect other parts of the kernel or harm other file systems if 
it dos not touch them (And Reiser4 in itself seems to be very stable 
according to all reports I could find)? Honestly I don't know how this can be 
possible but maybe I can't see it as I'm to much a user with to less 
knowledge...

Daniel Arnold
