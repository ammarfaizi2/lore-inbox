Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRDBNc5>; Mon, 2 Apr 2001 09:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129242AbRDBNcr>; Mon, 2 Apr 2001 09:32:47 -0400
Received: from 13dyn77.delft.casema.net ([212.64.76.77]:34054 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129166AbRDBNca>; Mon, 2 Apr 2001 09:32:30 -0400
Message-Id: <200104021331.PAA08784@cave.bitwizard.nl>
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <200104011754.KAA20725@work.bitmover.com> from Larry McVoy at "Apr
 1, 2001 10:54:40 am"
To: Larry McVoy <lm@bitmover.com>
Date: Mon, 2 Apr 2001 15:31:44 +0200 (MEST)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> 	The other main thing was to define some sort of structure to the
> 	bug report and try and get the use to categorize if they could.
> 	In an ideal world, we would use the maintainers file and the
> 	stack traceback to cc the bug to the maintainer.  I think we want
> 	to explore this a bit.	I'm not sure that the maintainer file is
> 	the way to go, what if we divided it up into much broader chunks
> 	like "fs", "vm", "network drivers", and had a mail forwarder
> 	for each area.	That could fan out to the maintainers.

This depends on the bug. 

If someone finds a generic kernel problem while logging in on a serial
terminal connected through a specialix-SX card, there is no reason to
CC me as the maintainer of that driver. If however, the bug is in the
driver, then I should be CC-ed.

Asking the submitter is I think the only way to do this: 
	You have a XYZ scsi Controller.
	Do you think this bug relates to this driver?           yes/no
	Should the maintainer of the xyz controller be CCed?    yes/no

	You have a Specialix SX card.
	Do you think this bug relates to this driver?           yes/no
	Should the maintainer of the specialix SX card be CCed? yes/no

Blindly CCing people from the Maintainers list is probably not a good
idea. Better would be to allow the maintainers to specify HOW they
want to be CC-ed. I for example, would want for every driver that I
maintain, to have a bug submitted in my jitterbug database (instead
of mailed to my private email address). 

>     Not losing bugs
> 	While there was much discussion about how to get rid of bad,
> 	incorrect, and/or duplicate bug reports, several people - Alan
> 	in particular - made the point that having a complete collection
> 	of all bug reports was important.  You can do data mining across
> 	all/part of them and look for patterns.  The point was that there
> 	is some useful signal amongst all the noise so we do not want to
> 	lose that signal.

All this sorting and tagging should be done in ONE database. So,
random users can add "count me in on this one", meaning that they too
see this problem. And that someone trying to fix this can CC them too.

Also, say Jens can tag a problem as "a fluke", while Alan should still
be able to tag it as: "Hmm. Odd problem. Heard of it before, Need more
reports to figure out the common cause". 

Queries to the database can then be "All problems tagged as real by at
least one kernel hotshot".

>     Signal/noise
> 	We had a lot of discussion about how to deal with signal/noise.
> 	The bugzilla proponents thought we could do this with some additional
> 	hacking to bugzilla.  I, given the BitKeeper background, thought 
> 	that we could do this by having two databases, one with all the 
> 	crud in it and another with just the screened bugs in it.  No matter
> 	how it is done, there needs to be some way to both keep a full list,
> 	which will likely be used only for data mining, and another, much
> 	smaller list of screened bugs.  Jens wants there to be a queue of 
> 	new bugs and a mechanism where people can come in the morning, pull
> 	a pile of bugs off of the queue, sort them, sending some to the real
> 	database.  This idea has a lot of merit, it needs some pondering as
> 	DaveM would say, to get to the point that we have a workable mechanism
> 	which works in a distributed fashion.

Jitterbug already has this. However, every problem in Jitterbug is
only in one queue/classification. My suggestion for the big thingy is
that everybody could have a different view.

> 	The other key point seemed to be that if nobody picked up a bug and
> 	nobody said that this bug should be picked up, then the bug expires
> 	out of the pending queue.  It gets stashed in the bug archive for
> 	mining purposes and it can be resurrected if it later becomes a real
> 	bug, but the key point seems to be that it _automatically_ disappears
> 	out of the pending queue.  I personally am very supportive of this
> 	model.  We need some way to just let junk stay junk.  If junk has to
> 	be pruned out of the system by humans, the system sucks.  The system,
> 	not humans, needs to autoprune.

OK. But those "interested" in the bug (the Email of the submitter)
should be notified: "Your reported bug is going to expire soon. Could you
indicate that this is still bothering you"?. 

"Enhancement requests" can stay around for a long, long time if nobody
takes the time to implement the request.

Speaking of "Enhancement requests", there once was a professor in the
field of "operating systems" who wanted to give out real
Linux-ehancement projects as lab-projects for his course. Some people
might tag enhancement requests with "80-hour project", and then allow
students to do them for credit!

>     Simplified access: browsing and updating
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

This sounds good, except that when you have different views towards
the database, problems arise. We could just dump the database into a
news-server every hour to make Linus happy, but that would probably
defeat some of the advantages of the "news" interface (mark problems
as "read").

>     - one key observation: let bugs "expire" much like news expires.  If
>       nobody has been whining enough that it gets into the high signal 
>       bug db then it probably isn't real.  We really want a way where no
>       activity means let it expire.

This needs to be "forced". A submitter should get an EMail when a bug
is about to be expired, and should be able to claim an extension. The
reply should also ask for the latest kernel that the submitter tried,
and was verfied to have the bug. 

So the bug item in the DB will get tagged for example as: reported to
exist on 2.4.1, 2.4.2-ac12 and 2.4.3 by REW.

- Dynamic keyword section. 

Dynamic: You CAN enter keywords that are not already in the database. 
Those will be available to others from then on. 

Someone may want to tag "disc-problem" as equivalent to "disk-problem". 

The "limited list of possibilites" means that searches for...

>     - Alan pointed out that having all of the bugs someplace is useful,
>       you can search through the 200 similar bugs and notice that SMP
>       is the common feature.  

... similar problems become easier/possible. 


- Automatic inclusion of ".config" files. Nowadays, the .config is so
large that submitting it with a bugreport is not efficient. However,
if you would be submitting a bugreport into a database, the info could
be very useful in reliably scanning for common configuration options
in a set of reports.

- "me too" reports should be able to append a new ".config" to an
existing bugreport.

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
