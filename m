Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVFZUxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVFZUxo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 16:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVFZUxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 16:53:44 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:12716 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261584AbVFZUxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 16:53:11 -0400
Message-Id: <200506262016.j5QKFuXM028867@laptop11.inf.utfsm.cl>
To: Daniel Arnold <arnomane@gmx.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from Daniel Arnold <arnomane@gmx.de> 
   of "Sun, 26 Jun 2005 16:49:21 +0200." <200506261649.22172.arnomane@gmx.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 26 Jun 2005 16:15:56 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Arnold <arnomane@gmx.de> wrote:
> Am Samstag, 25. Juni 2005 02:40 schrieb Horst von Brand:
> > Daniel Arnold <arnomane@gmx.de> wrote:
> >
> > [...]
> >
> > > Although I'm currently using ReiserFS v3 at my (Suse) Linux box (and am
> > > happy that it uses my small hard disk space better than other file
> > > systems and that I could always repair the data on the file system in
> > > some minutes at least in large parts
> >
> > Not enough in my book.

> Well I'm no expert in data rescue after a severe hardware crash and with
> ext2 or ext3 it wouldn't have been any better (even worse with ext2). So
> I'm just wondering why you have such high expectations towards any
> Reiser-FS-version but not at the same time to other file systems.

Experimental data point is that on loss of single disk sectors the /whole
filesystem/ got irretrievably lost. Haven't seen that on ext2...

> And beside that the good usage of my harddisk space (20 Gigabytes) is for
> me a _very_ strong point in using ReiserFS as the computer I'm talking
> about is not able to use hard disks larger than 32GB and I don't want to
> buy a new computer because of that.

And because /you/ can't afford a decent machine /we all/ have to endure
ReiserFS?!

> And have you ever heared of the problem of Wikipedia storage? Their old
> SCSI storage system had no additional slot left, so there was need to buy
> an entire new storage array and this wasn't/isn't cheap. And of course
> the database grows exponentially. So there was need for a solution that
> is orders of magnitudes larger. The first solution was reducing the data
> storage problem at the root: compression (gzip compressed chunks of 20
> following versions of an article; reduced the database by 85%). The
> second step is the new storage hardware. So a filesystem with intelligent
> disk usage is very much appreciated there too, regardless how big the
> storage array is...

And on the extreme other end people worry about the cost of the storage
they require, and that should somehow also be a burden for /all/ Linux
developers...

Don't you see that this argument makes no sense? Sure, I too would like
25GHz CPUs, and 10GigEth to the Internet at home, and filesystems that
store data in no space at all. Doesn't make it happen just like that.

> > > One big thing are all the nice applications that want databases like
> > > MySQL.

> > Shoving the RDBMS into the kernel doesn't solve this, quite to the
> > contrary. It makes the whole system less flexible (if you don't want MySQL
> > but something else, you can't get it easily). The whole is /more/ complex
> > (kernel space programming is /a huge lot harder/ than userspace
> > programming). It will be /much more/ unstable, as any idiotic bug in the
> > RDBMS will bring the /whole system/ down, or screw up completely unrelated
> > innocent bystanders.

> Ok. You're afraid that this would be again some kind of kernel-httpd. But it 
> won't be for the following reasons:

> The storage part of a database only one part of a database application. Many 
> programming lines of a database package are about creating nice tools and 
> interfaces for easy access and manipulation of the stored data, like a 
> SQL-interpreter and such.

So? Placing the rest into the kernel won't magically make it take up no RAM
(quite the contrary), or be blindingly fast, or maximally convenient to
use, or deadlock-free, or whatever.

> Filesystems _are_ storage backends, so existing database applications are
> duplicating this storage part today as their programmers and users are
> anoyed by the poor and less flexible possibilities the filesystems
> provide.

Maybe it is because their storage use patterns just /don't fit/ the regular
needs of normal applications, for which filesystems have been carefully
designed and tuned?

[...]

> E.g. Wikipedia has a constant problem with CPU usage of their servers, so 
> people are flaming that PostgreSQL is faster than MySQL and Wikipedia should 
> not use MySQL. But what about a solution based on Reiser4 (revision storage 
> and on the fly compression needed) with a userland SQL-interface? Reiser4 
> _is_ fast and is data loss safe.

It very much remains to be seen if some generic filesystem is even a
reasonable fit to their needs, forget about their requirements on data
security (Yes, backups are a must; but if you have to pull them down each
single time something goes wrong the setup is useless. And you won't know
without much more tests and experience in real settings.). Fast compared to
what? It is of no use if user time goes down while system time goes up by
the same (or larger) ammount.

[...]

> > And why don't you use a version management system for this? You could use
> > RCS (simple, easy to use; but doesn't handle sideways relations at all), or
> > something more complex. Userland solutions /do/ exist, and work fine. They
> > even handle saving stuff over the network, etc.

> Well yes I could do it for myself. But the majority of users (Im talking
> of "innocent stupid" computer users here) will never get those benefits
> as it is simply to complex and so distributions as Suse, RedHat and
> others will not base a key feature of their systems on an additional
> complexity caused by a daemon like CVS and of course those revision
> systems aren't really nice to look at via a file manager (ok there exists
> Cervisia-KIO-slave in KDE - again a filesystem plugin in a high level
> application).

Right. So you compensate for dumb users, who wouldn't distinguish an
version control system from a camel, by making the filesystem into a
version control system, which they won't understand anyway, lets alone make
productive use of it.

> And here again: The storage part of revision systems is not that big it only 
> needs to be flexible enough.

Yep. Regular files have been plenty enough for all that is out there.
Doesn't that tell you something?

>                              Most important are the userland tools that 
> enable you manipulating the data.

Exactly.

>                                   And why did Subversion not choose plain 
> file storage as CVS? They simply disliked the limitations caused by todays 
> standard file systems and so they went away from the file system to a 
> database. 

And used a database backend that (surprise!) works on files itself. That
way they can run wherever the filesystem has what is needed for DB, and
they don't have to duplicate the specialized word Sleepycat has done. Smart
move.

> So with Reiser4 Subversion wouldn't need to base the storage on a
> database

... but I'd suggest keeping wide away from it, as very few people have
ReiserFS...

>          and do unnecessary double work

What double work? There is /one/ database involved when running on, e.g.,
ext3. Any "unnecessary double work" would squarely be within ReiserFS...
just one more reason /not/ to use it, wouldn't you say?

>                                         and could base their storage on a
> prooven

Not yet, sorry.

>          stable

Very much remains to be seen. Jury deliberations up to this point indicate
it isn't for version 4. Judging from the history of ReiserFS versions, it
is dismal.

>                 file system as Reiser4.

> > > Another possibility would be e.g. replacing the RPM-database by a
> > > structure in the Reiser4 file system. [...]

> > And shove RPM into the kernel...

> No I never said that the RPM-tool should get into the kernel as this
> wouldn't make any sense. The userland RPM-tool will be still the right
> tool in complex cases but you can also manipulate the database with other
> userland tools if you like.

Look at the various RPM tools: They are mostly a thin shell around
functionality in a library. /That/ is what you'd need to push into the
kernel (or at least a large part of the library). Just like mv(1) is not
much more than a shell around rename(2).

[...]

> > No. It has to be done right (or nearly right) from the start. Also,
> > screwing around with filesystems /is/ risky, as it could affect innocent
> > bystanding filesystems.

> How can Reiser4 affect other parts of the kernel

It needs to be integrated with the rest...

>                                                  or harm other file
> systems if it dos not touch them

Not touching them because the whole design is feet in the air, head firmly
planted on the ground doesn't count.

>                                   (And Reiser4 in itself seems to be very
> stable according to all reports I could find)?

ReiserFS 3 has a very bad record, so...

>                                                Honestly I don't know how
> this can be possible but maybe I can't see it as I'm to much a user with
> to less knowledge...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

