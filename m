Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbTF1Hij (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 03:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265101AbTF1Hij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 03:38:39 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4480 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265091AbTF1Hi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 03:38:27 -0400
Date: Sat, 28 Jun 2003 09:00:39 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306280800.h5S80dab000476@81-2-122-30.bradfords.org.uk>
To: lm@bitmover.com, mbligh@aracnet.com
Subject: Re: networking bugs and bugme.osdl.org
Cc: davem@redhat.com, greearb@candelatech.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >    It would also keep bugs from falling through the cracks:
> > > 
> > > People DON'T understand.  I _WANT_ them to be able to
> > > fall through the cracks.
> > 
> > I fail to see your point here. 
>
> This might help.  Or not.
>
> Brain dump on the bug tracking problem from the Kernel Summit discussions

I implemented the vast majority of this months ago, in my bug database:

http://www.grabjohn.com/kernelbugdatabase/

> 		[SCCS/s.BUGS vers 1.3 2001/04/05 13:10:10]
>
> Outline
> 	Problems
> 	Problem details
> 	Past experiences
> 	Requirements
>
> Problems
>     - getting quality bug reports
>     - not losing any bugs
>     - sorting low signal vs high signal into a smaller high signal pile
>     - simplified, preferably NNTP, access to the bug database (Linus
>       would use this; he's unlikely to use anything else)
>
> Problem details
>     Bug report quality
>     	There was lots of discussion on this.  The main agreement was that we
> 	wanted the bug reporting system to dig out as much info as possible
> 	and prefill that.  There was a lot of discussion about possible tools
> 	that would dig out the /proc/pci info; there was discussion about
> 	Andre's tools which can tell you if you can write your disk; someone
> 	else had something similar.

This is controversial, due to the potential for unwanted information
disclosure.  I purposely didn't implement it.  If a large proportion
of users want it implemented, just let me know.

> 	But the main thing was to extract all the info we could
> 	automatically.	One thing was the machine config (hardware and
> 	at least kernel version).  The other thing was extract any oops
> 	messages and get a stack traceback.

The (fairly complex) way kernel tree version numbers are implemented
is very well handled.  Different trees can be added to the database,
using an admin utility, (which is not currently publically
accessible), and they are categorised.  Currently we have 2.4 and 2.5
mainline, 2.4 and 2.5 -ac, and 2.5 -dj trees in the database.  All
version numbers are sorted properly with -pre and -rc coming before
the release.

> 	The other main thing was to define some sort of structure to the
> 	bug report and try and get the use to categorize if they could.
> 	In an ideal world, we would use the maintainers file

Did that since version 1.0.

>       and the
> 	stack traceback to cc the bug to the maintainer.  I think we want
> 	to explore this a bit.	I'm not sure that the maintainer file is
> 	the way to go, what if we divided it up into much broader chunks
> 	like "fs", "vm", "network drivers", and had a mail forwarder
> 	for each area.	That could fan out to the maintainers.

No problem.  The admin utility can scan any file which is in the same
format as the current maintainers file.  Just prepare and upload one.

>     Not losing bugs
> 	While there was much discussion about how to get rid of bad,
> 	incorrect, and/or duplicate bug reports, several people - Alan
> 	in particular - made the point that having a complete collection
> 	of all bug reports was important.  You can do data mining across
> 	all/part of them and look for patterns.  The point was that there
> 	is some useful signal amongst all the noise so we do not want to
> 	lose that signal.

Done since version 2.0.  We have bug reports, and confirmed bugs.  Bug
reports are archived after 2 weeks of inactivity, (or should be, I
introduced a bug recently which stopped that working, but I'll fix
that at the earliest opportunity).  Anybody can add a bug report, and
they are all archived.  Confirmed bugs can only be added by admins,
and collect together bug reports.

>     Signal/noise
> 	We had a lot of discussion about how to deal with signal/noise.
> 	The bugzilla proponents thought we could do this with some additional
> 	hacking to bugzilla.  I, given the BitKeeper background, thought 
> 	that we could do this by having two databases, one with all the 
> 	crud in it and another with just the screened bugs in it.

See above - done since version 2.0.

>       No matter
> 	how it is done, there needs to be some way to both keep a full list,
> 	which will likely be used only for data mining, and another, much
> 	smaller list of screened bugs.

Confirmed bugs VS bug reports.

>       Jens wants there to be a queue of 
> 	new bugs and a mechanism where people can come in the morning, pull
> 	a pile of bugs off of the queue, sort them, sending some to the real
> 	database.

No problem - just deselect 'include bug reports', and 'include
archived entries', and click 'All entries'.  Then, (you need to have
an admin account for this), select 'open a new confirmed bug'.  Add
the bug reports to this confirmed bug.

>       This idea has a lot of merit, it needs some pondering as
> 	DaveM would say, to get to the point that we have a workable mechanism
> 	which works in a distributed fashion.
>
> 	The other key point seemed to be that if nobody picked up a bug and
> 	nobody said that this bug should be picked up, then the bug expires
> 	out of the pending queue.  It gets stashed in the bug archive for
> 	mining purposes and it can be resurrected if it later becomes a real
> 	bug, but the key point seems to be that it _automatically_ disappears
> 	out of the pending queue.  I personally am very supportive of this
> 	model.  We need some way to just let junk stay junk.  If junk has to
> 	be pruned out of the system by humans, the system sucks.  The system,
> 	not humans, needs to autoprune.

It does autoprune.  (OK, there is currently a bug which is preventing
it from working, but as I said above, I'll fix that as soon as I get
chance to work on it).  Bug reports over two weeks old become archived.

>       Simplified access: browsing and updating
> 	Linus made the point that mailing lists suck.  He isn't on any and
> 	refuses to join any.  He reads lists with a news reader.  I think
> 	people should sit up and listen to that - it's a key point.  If your
> 	mailing list isn't gatewayed to a newsgroup, he isn't reading it and
> 	a lot of other people aren't either.
>
> 	There was a fair bit of discussion about how to get the bug database
> 	connected to news.  There doesn't seem to be any reason that the
> 	bug system couldn't be a news server/gateway.  You should be able to
> 	browse
> 	    bitbucket.kernel.bugs - all the unscreened crud
> 	    screened.kernel.bugs - all bugs which have been screened
> 	    fs.kernel.bugs - screened bugs in the "fs" category
> 	    ext2.kernel.bugs - screened bugs in the "ext2" category
> 	    eepro.kernel.bugs - screened bugs in the "eepro" category
> 	    etc.

Not yet implemented.  Let me know more specifically what you want, and
I'll implement it.

Note - there _was_ a prefectly good command line/E-Mail interface, but
hardly anybody used it, so I removed it.

> 	Furthermore, the bugs should be structured once they are screened,
> 	i.e., they have a set of fields like (this is a strawman):
>
> 	    Synopsis - one line man-page like summary of the bug

Implemented.

> 	    Severity - how critical is this bug?

> 	    Priority - how soon does it need to be fixed?

Not implemented, but trivial to implement if people care.

> 	    Category - subsystem in which the bug occurs

Implemented via Maintainers file.

> 	    Description - details on the bug, oops, stack trace, etc.

Implemented.

> 	    Hardware - hardware info
> 	    Software - kernel version, glibc version, etc.
> 	    Suggested fix - any suggestion on how to fix it
> 	    Interest list - set of email addresses and/or newsgroups for updates

Not implemented, but trivial to implement if people care.

> 	It ought to work that if someone posts a followup to the bug then if
> 	the followup changes any of the fields that gets propagated to the
> 	underlying bug database.  If this is done properly the news reader will
> 	be the only interface that most people use.

OK, my idea is a bit different - each possibly widely differing bug
report is a completely separate entity.  You can only add to a bug
report, unless you are the submitter, or an admin.  Anybody else
should add a separate bug report, and have an admin find and connect
it to the existing confirmed bug.

> Past experiences
>     This is a catch all for sound bytes that we don't want to forget...
>
>     - Sorting bugs by hand is a pain in the ass (Ted burned out on it and
>       Alan refuses to say that it is the joy of his life to do it)

Bug reports are sorted via the categories in the maintainers file.
Anybody can 'watch' any particular subsystem and get notified of all
the bug reports that are submitted as included in that subsystem.  A
bug report can go in to more than one subsystem or none at all.

>     - bug systems tend to "get in the way".  Unless they are really trivial
>       to submit, search, update then people get tired of using them and go
>       back to the old way

Isn't this exactly what we're seeing with a lot of bugs in the kernel
Bugzilla being forwarded to LKML?  We shouldn't need that if the bug
database is operating satisfactorily.

>     - one key observation: let bugs "expire" much like news expires.  If
>       nobody has been whining enough that it gets into the high signal 
>       bug db then it probably isn't real.  We really want a way where no
>       activity means let it expire.

Done.

>     - Alan pointed out that having all of the bugs someplace is useful,
>       you can search through the 200 similar bugs and notice that SMP
>       is the common feature.  

Done - just make sure 'include archived entries' is selected.

> Requirements
>     This section is mostly empty, it's here as a catch all for people's
>     bullet items.  
>
>     - it would be very nice to be able to cross reference bugs to bug fixes
>       in the source management system, as well as the other way around.

Larry, if you can provide pointers as to the best way to link to stuff
in BK, I'm happy to put that in.

>     - mail based interface

Removed, because nobody used it.  You can still see screenshots of it
at:

http://www.grabjohn.com/kernelbugdatabase/screenshots/

You can find the Kernel Bug Database at:

http://www.grabjohn.com/kernelbugdatabase/

or alternatively, the database and documentation are linked to from:

http://www.grabjohn.com/

If there are problems with it, or reasons why people hate it, please
_let me know_.

John.
