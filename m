Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261871AbTCPBfR>; Sat, 15 Mar 2003 20:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbTCPBfR>; Sat, 15 Mar 2003 20:35:17 -0500
Received: from emf.emf.net ([205.149.0.20]:26898 "EHLO emf.net")
	by vger.kernel.org with ESMTP id <S261871AbTCPBfN>;
	Sat, 15 Mar 2003 20:35:13 -0500
Date: Sat, 15 Mar 2003 17:44:58 -0800 (PST)
From: Tom Lord <lord@emf.net>
Message-Id: <200303160144.RAA04331@emf.net>
To: arch-users@lists.fifthvision.net
CC: linux-kernel@vger.kernel.org
In-reply-to: <20030316001840.GB11761@pasky.ji.cz> (message from Petr Baudis on
	Sun, 16 Mar 2003 01:18:40 +0100)
Subject: Re: [arch-users] Re: BitBucket: GPL-ed KitBeeper clone
References: <200303151621.h2FGLgaD003246@eeyore.valparaiso.cl> <20030315212205.CDE923D979@mx01.nexgo.de> <1047765218.9619.124.camel@lan1> <20030316001840.GB11761@pasky.ji.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



       I'm not sure if arch is the right thing to base on. Its
       concepts are surely interesting, however there are several
       problems (some of them may be subjective):

Let's see.

I'll say at the outset: you've named a bunch of things that do give a
bad first-impression to many users.  None of these issues go "deep"
into arch -- there's lots of room, and even some actual work, towards
changing some of what you're complaining about.  If the question is
"is arch a good starting point" -- the fact that all of these are
fairly minor issues reinforces the answer "yes", even if people insist
that there be changes related to these issues.




      * Terrible interface. Work with arch involves much more typing
        out of long commands (and sequences of these), subcommands and
        parameters to get functionality equivalent to the one provided
        much simpler by other SCMs. I see it is in sake of genericity
        and sometimes more sophisticated usage scheme, but I fear it
        can be PITA in practice for daily work.

Perhaps so.  But the question is "Is arch the right starting point
from which to build a system for Linux kernel developers."  If we
agree that what you describe is a problem, it seems to me that the
solution (at least to long command names and options) is _trivial_:
write some front-end scripts.  That would be easy to do, wouldn't take
much code, and if a winning convenience layer emerged from that, I'm
sure we'd be happy to add it to arch (possibly via a a more general
"alias" mechanism for creating short-names for commands with default
option values).

But then there's revision names:

    * Awful revision names (just unique ids format). Again, it
      involves much more typing and after some hours of work, the
      dashes will start to dance around and regroup at random places
      in front of your eyes.

In practice, that hasn't been a problem.  Instead, what people
who use arch to do real work complain about is:

1) two-component version numbers, major.minor

   Several people want three-component.  Everyone agrees that
   n-component (user's choice) is best.   We have good practical 
   reasons for making the change to n-component versions slowly and
   carefully, but it is not a major change.   Again, I'm assuming that
   the question is "is arch the best starting point".



2) ordering of components

   Arch unique ids say:

		<category>--<branch>--<version>

   and some users would rather have:

		<category>--<version>--<branch>

   which better matches the naming scheme currently used for the Linux
   kernel.

   So far, there really aren't sufficiently vociferous+convincing 
   requests to make any changes in this area -- but again, in the big
   picture, no matter what happens in this area -- it's a minor point.


      > The concepts behind (like seamless division to multiple
      > archives; I can't say I see sense in categories) are
      > intriguing, but the result again doesn't seem very practical.

   Don't have much to say about that.   It's been quite practical 
   for me, at least, in practice.



	* Evil directory naming. {arch} seems much more visible than
	CVS/ and SCCS/, particularly as it gets sorted as last in a
	directory, thus you see it at the bottom of ls output. Also
	it's a PITA with bash, as the stuff starting by '=' (arch
	likes to spawn that as well) is. The files starting by '+' are
	problem for vi, which is kind of flaw when they are probably
	the only arch files dedicated for editting by user (they are
	supposed to contain
        log messages).

  Yet again: these are minor complaints.

  `+'-named log message files _are_ going to change to something more
  vi-friendly.  My bad.  I'm both an emacs user and a
  unix-traditionalist.  I didn't initially notice the problem and my
  reaction on hearing about it was "Well, vi is broken" -- but as a
  practical matter, arch does need to change in that area.

  arch itself does not generate `=' files in source trees -- I use
  them in the arch source code; they do appear in archives and under
  {arch} where you'll nearly never need to interact with them via
  bash.  Incidently, `bash' has recently been patched (not sure if
  it's released yet) to make it deal properly, or at least better,
  with `=' files.  ("Well, bash is broken." :-)

  I'm not sure why you think that "{arch}" is bad.  There's _one_ of
  those per controlled _tree_, while there's one CVS/ per _directory_.
  I'm not sure why you think the sort-order of {arch} is bad -- I
  think it's a feature because it puts that directory "out of sight;
  out of mind" when I use my outline-style directory editor (if you
  are an Emacs user, would you like a copy of my tree editor,
  "monkey"?).  I'm not sure why you think it's a PITA wrt bash -- I
  use bash interactively and have never had any problem with {arch}.
  But you know, again, this is a shallow issue.  Practically speaking,
  changing that name to something else is relatively low impact
  (though, to be sure, a tedious change that would take several entire
  _hours_ to make + a few days to figure out how to deal with existing
  archives).


	* Cloud of shell scripts. It poses a lot of limitations which
	are pain to work around (including speed, two-fields version
	numbers [eek] and I can imagine several others; I'm not sure
	about these though, so I won't name further; you can possibly
	imagine something by yourself).

You'll be happier with n-component versions when we have a variation
on sort(1) that handles them with ease -- and that's where we're
going.

Robert Anderson has posted on the wiki a tasty defense of the choice
of `sh' for the first implementation.   He also pointed out some great
URLs from the SCSH site in the discussion on kerneltrap.org.  (Sorry
for the meta-URLs here....)

Some people complain about `sh' as an implementation language.  Beyond
defending that choice, let me say this: arch is a design and a set of
file and directory formats to go with that design.  It _invites_
reimplementation.  The other day, I played around with some of those
horrible shell tools and figured out that the meat of the sh scripts
in arch are just a bit over 20K LOC -- think you can rewrite that in
another language without too much cost?  There's another 10-15K LOC
which is nothing but printf(1) statements for `--help' options,
copyright comments, and boilerplate loops that read command line
options and assign their values to variables.

In other words, look beyond just any one implementation -- arch is a
set of concepts;  a set of interop standards just ripe to be written;
and a revision control system design that is simultaneously extremely
powerful, yet utterly trivial to implement or reimplement.   Forget
about the problem of tying Linux kernel development to a proprietary
tool -- arch can can help you avoid tying to a single implementation
of a free revision control system.

	* Absence of sufficient merging ability, at least impression I
	got from the documentation. Merging on the *.rej files level I
	cannot call sufficient ;-).  Also, history is not preserved
	during merging, which is quite fatal.  And it looks to me at
	least from the documentation that arch is still in the
	update-before-commit stage.

You are partially misinformed.

Merge history in arch is preserved in excurciating detail.  That
history is used smartly in some very common cases (like a tree of
trusted lieutenants) to eliminate some of the most common sources of
merge conflicts.

Yes, when conflicts occur, arch currently represents these via the
".rej" mechanism.  Yes, that's low-level and, at least arguably, icky.
Yet, again, that's not a "deep" issue in the sense that changing that
behavior leaves unaffected "99%" of arch.   So, again, is arch the
right _starting point_ for displacing BK?


      * Absence of checkin/commit distinction. File revisions and
        changesets seem to be tied together, losing some of the cute
        flexibility BK has.

Yes, I've noted that from the lkml discussion.  My impression so far
is that layering that functionality over the existing core of arch is
straightforward. 

	I must have missed terribly something in the documentation
	given how arch is being recommended,

Larry, and, increasingly, some of the arch-users members, are revision
control experts.  Your complaints about arch express, no offense, a
fairly superficial (yet valid, yet easy to deal with) end-user
perspective.   I think that the recommendations come from the
perspective of "Hey, this is a decent foundation and if you don't
appreciate that, you're probably not qualified to do revision control
design",  while the complaints come from a perspective of "Ick,
there's about 2-dozen tweaks to the UI on this thing that I can't
possibly live without and I won't use your system unless you start to
accomodate those."

The two perspectives are compatible and complementary.  Thank you for
your feedback

	But as I see it, most of the juicy stuff is missing (altough I
	really like the concept of configurations and especially the
	concept of caching --- mainly that you do not _have_ to pull
	all the stuff from the clonee repository, which can be a pain
	with more poor internet connection; 

That's a deep point -- thank you for noticing.

	then also if you aren't doing any that big changes and you're
	confident that the remote repository is going to stay there,
	it is less expensive to talk with the repository over network)

which arch does perfectly well.

	and the existing stuff is mostly in the form of shell scripts,
	which it has to leave and be rewritten sooner or later anyway.

Parts of it, sure.  All of it?  Well, I hope there are multiple
reimplementations of this tiny-yet-powerful system -- but I think the
sh-based version is more viable than some people do.

	The backend history format doesn't appear to be particularily
	great as well.

I can't respond to such a vague statement.   Details, if you please.


	Dunno. What's so special about arch then?

Superp design.  Tiny yet powerful implementation.  Unprecedented
features.   Based, deeply, on "what changesets mean" -- thus handilly
adapts to a very wide range of usage scenarios.   Software tools.

Also, mostly outside of the scope of Linux kernel foo -- the design
considers "programming in the large".  In other words, it takes into
account the problem of managing a complete system, not just the
kernel, in a commercial context with competing but related
distributions.   It's "scope of concern" is much larger than just the
lkml crowd.


-t

