Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292149AbSBBALV>; Fri, 1 Feb 2002 19:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292151AbSBBALM>; Fri, 1 Feb 2002 19:11:12 -0500
Received: from femail14.sdc1.sfba.home.com ([24.0.95.141]:24061 "EHLO
	femail14.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S292150AbSBBAK7>; Fri, 1 Feb 2002 19:10:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Larry McVoy <lm@bitmover.com>,
        Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Subject: Bitkeeper change granularity (was Re: A modest proposal -- We need a patch penguin)
Date: Fri, 1 Feb 2002 18:45:59 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Keith Owens <kaos@ocs.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <lm@bitmover.com> <200202011111.g11BBVf0009257@tigger.cs.uni-dortmund.de> <20020201083855.C8664@work.bitmover.com>
In-Reply-To: <20020201083855.C8664@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020202001058.UXDU10685.femail14.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 February 2002 11:38 am, Larry McVoy wrote:

> You are presupposing that all the developers are checking in many bad
> changes and only one good change.  And that all the bad changes are
> obscuring the good ones.  That a correct statement of your beliefs?
>
> If so, what you are describing is called "hacking" in the negative
> sense of the word, and what my customers do is called "programming".

Designing while coding is not a bad thing.  It's often considerably more 
efficient than spending a bunch of time up front coming up with an ivory 
tower design that doesn't work in practice.  Very few battle plans survive 
the first engagement with the enemy.  (It's nice to HAVE one.  But if you 
can't adapt when you're in the thick of things, you're in trouble.)

> It's quite rare to see the sort of mess that you described, it happens,
> but it is rare.

In your user base, sure.  Because your tool can't handle it.

Please don't confuse effect with cause...

> I don'tknow how else to explain it, but it is not the
> norm in the professional world to try a zillion different approaches
> and revision control each and every one.

The distinction here is "should bitkeeper be of use to the company", or 
"should bitkeeper be of use to the individual developer".  Bitkeeper is aimed 
at only serving ONE of those two niches right now (as I'll explain in a 
moment), and one thing to realise is that the development teams at companies 
are made up of individual developers who might find bitkeeper significantly 
more useful if it met more of their needs.

> The norm is:
> 	clone a repository
> 	edit the files
> 	modify/compile/debug until it works
> 	check in
> 	push the patch up the shared repository
> I'm really at a loss as to why that shouldn't be the norm here as well.

You'll notice that bitkeeper is totally useless between the clone and the 
check in, in your model.  It can't really be used DURING development, only 
before and after.

You may not notice this so much in the Fortune 500.  I've worked for some 
really big companies.  Your commercial developers are often implementing to a 
spec that was argued over in meetings, with donuts, for weeks before an 
"implementor" was allowed near a keyboard.  This IS a different development 
model from the way open source generally works. :)  (And the bigger the 
company, the more likely they are to ensure their design is perfected before 
they ever actually try to implement a prototype and find out the whole theory 
doesn't really work in practice.  And you wonder how anybody could ever 
manage to spend a billion dollars a year writing software and still ship 
crap.  But that's a seperate argument.  Neither method is inherently 
superior, and most real world development is a blance between up-front design 
and implementation evolution.  Go too far in either direction and you get 
chaos or stagnation.)

As for a simple example of when your model above breaks down, a lot of 
developers who use things like emacs have their source control system as part 
of their integrated development environment.  When they "save and compile", 
it's checked into the RCS (often with a terse three or four word comment 
that's intended as a label to jog the developer's memory).  For one thing, 
this is a nice backup against stupid things like fat-fingering "gcc blah.c -o 
blah.c", which I personally did first thing in the morning (before the 
caffiene could kick in) a few days ago and set myself back just about a whole 
day because my laptop does NOT have any variant of source control on it.  
(Screaming is certainly a quick and aerobic way to wake up, I will admit 
that.  I wouldn't recommend it though.)

The real reason people go with full-blown source control for their backups 
is so that when they ARE doing modify/compile/debug, they can easily back up 
to what they had an hour ago if they find out they went down a culdesac (as 
happens a lot: not always "I couldn't make this work if I kept going" but 
"wait, there's an easier way to do this").  Of course not all changes in 
direction are clean reverts.  Sometimes you want to save part of your work 
and change the other parts yourself, and it's easier to fix up manually and 
check the fixup in than reimplement just to look like you knew what you were 
doing all along.  And sometimes if it's a bug fix inserting a bunch of 
printfs and test code while actually fixing a multi-stage bug, they don't 
bother rolling back to remove the printfs.  Once they've fixed the bug, it's 
easier to delete the instrumentation and false tries rather than roll back to 
a clean version and recreate the entire (possibly long and complicated) fix 
against the fresh tree.)

The problem is, if they use bitkeeper (with a temporary respository), all 
these temporary commits (debugging tries saved in case they want to roll back 
during development) get propagated into the main repository when they do a 
merge.  They can't tell it "done, okay, squash this into one atomic change to 
check in somewhere else, with the whole change history as maybe one comment".

What you're saying is that people who use the source control tools in a way 
you do not expect them to are bad programmers.  A stylistic difference does 
not equal stupidity.

People sometimes really do want to be able to squash between checkpoints, 
which might just be a case of squashing a scratch repository used to create 
the checkpoint.  (If the scratch repository is deleted in the process, then 
the "merge granular and squashed versions" thing doesn't really arise, so 
possibly people just want to be able to do their development in a temporary 
repository which they squash and delete when they issue a release.  Not a 
100% solution, it means the original developer can't keep the original highly 
granular version around without potentially confusing bitkeeper, but it's 
probably an acceptable solution in 80-90% of cases, and is probably doable 
with a script rather than any real change to bitkeeper.)

You do not seem to be used to implementors doing any real designing, and you 
do not seem to be used to your source control system being used during the 
throes of minute-by-minute development.  (Once again, you seem to be arguing 
against  feedback from the community, by saying "you don't really want to do 
that,  your process is bad and should be adapted to my tools".  I hope this 
is just another miscommunication.  We're trying to say "your tools aren't any 
good at what we're trying to use them for, but they could be."  If you don't 
want your tool to serve a certain group of users, fine.  Your tools may serve 
an existing niche fairly well, but if you'd like to expand to a broader 
audience listening to feedback would be helpful.)

Perhaps some of this is just a documentation issue.  If we can explain what 
we want but can't easily figure out how to get bitkeeper to do it, some kind 
of tutorial or prepackaged scripts might be a good idea...

Rob

