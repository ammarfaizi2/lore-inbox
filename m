Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264157AbTDKEOM (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 00:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264161AbTDKEOM (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 00:14:12 -0400
Received: from cs.columbia.edu ([128.59.16.20]:5053 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S264157AbTDKEOK (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 00:14:10 -0400
Subject: Re: kernel support for non-english user messages
From: Shaya Potter <spotter@cs.columbia.edu>
To: Valdis.Kletnieks@vt.edu
Cc: John Bradford <john@grabjohn.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       root@chaos.analogic.com, Frank Davis <fdavis@si.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304110419.h3B4JeBm004315@turing-police.cc.vt.edu>
References: <200304102036.h3AKa837025670@81-2-122-30.bradfords.org.uk>
	 <1050013215.23204.8.camel@zaphod>
	 <200304110419.h3B4JeBm004315@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1050034996.23950.21.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Apr 2003 00:23:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, yes.  I of course agree, just saying that if someone really wanted
to do it, banging out a skeleton solution that can be filled in
shouldn't be "that" hard.  Getting it "right"(tm) would be tougher, but
I think doable.  The reason I think no one has done it, is because no
one is really that interested.

On Fri, 2003-04-11 at 00:19, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 10 Apr 2003 18:20:15 EDT, Shaya Potter said:
> > On Thu, 2003-04-10 at 16:36, John Bradford wrote:
> > > > There is a lot of anti-VMS stuff in the Unix world mostly coming
> > > > from the _horrible_ command line and other bad early memories. There
> > > > is also a hell of a lot of really cool stuff under that command line
> > > > we could and should learn from.
> > > 
> > > When are we going to see versioned filesystems in Linux?  That was a
> > > standard feature in VMS.
> > 
> > it shouldn't be that hard, it was one of the 6 OS projects for the
> > regular 4000 level (senior/grad) level OS class here at columbia last
> > semster.  
> > 
> > The assignment was to modify ext2 to support versioning, basically means
> > making a copy of it within ext2's open, if it's opened O_RDWR.  The
> > assignment was a little bit more complicated in that we took an ext2
> > flag bit to mean "version", so that a file would only be versioned if
> > the bit was set, as well as only allowing a single level of versioning,
> > though extending it w/ more wouldn't be that hard.
> > 
> > The student solutions (as well as our sample solution) weren't that
> > "pretty", but then again, each project was only for 2-2.5 weeks.
> 
> The problem is, as usual, in the details that almost never get handled in 2-week
> student projects.  Some off the top of my head:
> 
> 1) What happens when *multiple* programs have a file open at the same time?
> If you only handle one level of versioning, somebody is going to lose.  Handling
> multiple levels is of course more "fun".  And you get to worry about race
> conditions - does your code DTRT if multiple processes do an open() on alternate
> CPUs at the same time.  Does it DTRT if a process open()s a file, and then fork()s,
> and both parent and child start scribbling on the file descriptor?
> 
> 2) For that matter, should new versions be created at open() or at the first write()?
> Doing it at write() allows not creating a new version if no changes have
> actually happened - but this has its own issues.  
> 
> 3) Version a 500 megabyte file.  Change one block.  Do it a few more times.
> Are you better off copying the whole file (which bloats your disk usage and
> kills your I/O bandwidth), or keeping deltas (the list of allocated blocks could be
> almost identical except for the replaced/rewritten blocks).  However, this DOES
> make doing an fsck() a *lot* more interesting - is a block allocated to multiple
> files in error or not?
> 
> 4) What happens if you rename() a file?  Can you open() a previous version for
> writing?  If so, does it get versioned?  How does a backup program restore a
> previous version?
> 
> 5) Let's say we use VMS-style filenames to version.  foo, foo;2, foo;3, etc.
> Now, is open("foo;2",...) a reference to the previous version of foo or to a new
> file that happens to be called foo;2?  What happens if some other file happens
> to be called foo;2 and you create a version  of foo?
> 
> 6) OK, since anything besides \0 and / is legal in a filename, we can't use ;N to
> version.  Let's steal another field in the inode to do the counting.  Now how does
> userspace reference a previous version easily?  Can you get into a situation where
> different versions of a file have different owners/permissions?
> 
> 7) Userspace support.  Anybody want to open that can and take up worm farming? ;)
> 
> 8) User support issues.  See (7). ;)
> 
> That's just the first 10 minutes or so of thinking about things that could be problems
> that a student project won't address.
> 
> Yes, VMS had to worry about a lot of these issues too - but VMS had the advantage that
> versioning was designed into the environment from very early on, and wasn't a retrofit
> as it would be for Linux.  So they could make arbitrary rules like "If there's a
> ;nnn on the end of a filename, it's a version" without having to worry about breaking
> anything.

