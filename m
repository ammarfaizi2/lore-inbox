Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbTF0Wjh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264906AbTF0Wjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:39:37 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:21701 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264897AbTF0WjK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:39:10 -0400
Date: Fri, 27 Jun 2003 15:53:05 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "David S. Miller" <davem@redhat.com>, greearb@candelatech.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
Message-ID: <20030627225305.GA13785@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"David S. Miller" <davem@redhat.com>, greearb@candelatech.com,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netdev@oss.sgi.com
References: <20030627.144426.71096593.davem@redhat.com> <1230000.1056754041@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1230000.1056754041@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 03:47:22PM -0700, Martin J. Bligh wrote:
> --"David S. Miller" <davem@redhat.com> wrote (on Friday, June 27, 2003 14:44:26 -0700):
> 
> >    From: Ben Greear <greearb@candelatech.com>
> >    Date: Fri, 27 Jun 2003 11:50:43 -0700
> > 
> >    It would also keep bugs from falling through the cracks:
> > 
> > People DON'T understand.  I _WANT_ them to be able to
> > fall through the cracks.
> 
> I fail to see your point here. 

This might help.  Or not.

Brain dump on the bug tracking problem from the Kernel Summit discussions

		[SCCS/s.BUGS vers 1.3 2001/04/05 13:10:10]

Outline
	Problems
	Problem details
	Past experiences
	Requirements

Problems
    - getting quality bug reports
    - not losing any bugs
    - sorting low signal vs high signal into a smaller high signal pile
    - simplified, preferably NNTP, access to the bug database (Linus
      would use this; he's unlikely to use anything else)

Problem details
    Bug report quality
    	There was lots of discussion on this.  The main agreement was that we
	wanted the bug reporting system to dig out as much info as possible
	and prefill that.  There was a lot of discussion about possible tools
	that would dig out the /proc/pci info; there was discussion about
	Andre's tools which can tell you if you can write your disk; someone
	else had something similar.

	But the main thing was to extract all the info we could
	automatically.	One thing was the machine config (hardware and
	at least kernel version).  The other thing was extract any oops
	messages and get a stack traceback.

	The other main thing was to define some sort of structure to the
	bug report and try and get the use to categorize if they could.
	In an ideal world, we would use the maintainers file and the
	stack traceback to cc the bug to the maintainer.  I think we want
	to explore this a bit.	I'm not sure that the maintainer file is
	the way to go, what if we divided it up into much broader chunks
	like "fs", "vm", "network drivers", and had a mail forwarder
	for each area.	That could fan out to the maintainers.

    Not losing bugs
	While there was much discussion about how to get rid of bad,
	incorrect, and/or duplicate bug reports, several people - Alan
	in particular - made the point that having a complete collection
	of all bug reports was important.  You can do data mining across
	all/part of them and look for patterns.  The point was that there
	is some useful signal amongst all the noise so we do not want to
	lose that signal.
    
    Signal/noise
	We had a lot of discussion about how to deal with signal/noise.
	The bugzilla proponents thought we could do this with some additional
	hacking to bugzilla.  I, given the BitKeeper background, thought 
	that we could do this by having two databases, one with all the 
	crud in it and another with just the screened bugs in it.  No matter
	how it is done, there needs to be some way to both keep a full list,
	which will likely be used only for data mining, and another, much
	smaller list of screened bugs.  Jens wants there to be a queue of 
	new bugs and a mechanism where people can come in the morning, pull
	a pile of bugs off of the queue, sort them, sending some to the real
	database.  This idea has a lot of merit, it needs some pondering as
	DaveM would say, to get to the point that we have a workable mechanism
	which works in a distributed fashion.

	The other key point seemed to be that if nobody picked up a bug and
	nobody said that this bug should be picked up, then the bug expires
	out of the pending queue.  It gets stashed in the bug archive for
	mining purposes and it can be resurrected if it later becomes a real
	bug, but the key point seems to be that it _automatically_ disappears
	out of the pending queue.  I personally am very supportive of this
	model.  We need some way to just let junk stay junk.  If junk has to
	be pruned out of the system by humans, the system sucks.  The system,
	not humans, needs to autoprune.
    
    Simplified access: browsing and updating
	Linus made the point that mailing lists suck.  He isn't on any and
	refuses to join any.  He reads lists with a news reader.  I think
	people should sit up and listen to that - it's a key point.  If your
	mailing list isn't gatewayed to a newsgroup, he isn't reading it and
	a lot of other people aren't either.

	There was a fair bit of discussion about how to get the bug database
	connected to news.  There doesn't seem to be any reason that the
	bug system couldn't be a news server/gateway.  You should be able to
	browse
	    bitbucket.kernel.bugs - all the unscreened crud
	    screened.kernel.bugs - all bugs which have been screened
	    fs.kernel.bugs - screened bugs in the "fs" category
	    ext2.kernel.bugs - screened bugs in the "ext2" category
	    eepro.kernel.bugs - screened bugs in the "eepro" category
	    etc.

	Furthermore, the bugs should be structured once they are screened,
	i.e., they have a set of fields like (this is a strawman):

	    Synopsis - one line man-page like summary of the bug
	    Severity - how critical is this bug?
	    Priority - how soon does it need to be fixed?
	    Category - subsystem in which the bug occurs
	    Description - details on the bug, oops, stack trace, etc.
	    Hardware - hardware info
	    Software - kernel version, glibc version, etc.
	    Suggested fix - any suggestion on how to fix it
	    Interest list - set of email addresses and/or newsgroups for updates
	
	It ought to work that if someone posts a followup to the bug then if
	the followup changes any of the fields that gets propagated to the
	underlying bug database.  If this is done properly the news reader will
	be the only interface that most people use.

Past experiences
    This is a catch all for sound bytes that we don't want to forget...

    - Sorting bugs by hand is a pain in the ass (Ted burned out on it and
      Alan refuses to say that it is the joy of his life to do it)
    - bug systems tend to "get in the way".  Unless they are really trivial
      to submit, search, update then people get tired of using them and go
      back to the old way
    - one key observation: let bugs "expire" much like news expires.  If
      nobody has been whining enough that it gets into the high signal 
      bug db then it probably isn't real.  We really want a way where no
      activity means let it expire.
    - Alan pointed out that having all of the bugs someplace is useful,
      you can search through the 200 similar bugs and notice that SMP
      is the common feature.  

Requirements
    This section is mostly empty, it's here as a catch all for people's
    bullet items.  

    - it would be very nice to be able to cross reference bugs to bug fixes
      in the source management system, as well as the other way around.
    
    - mail based interface
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
