Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319510AbSIGTyn>; Sat, 7 Sep 2002 15:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319511AbSIGTyn>; Sat, 7 Sep 2002 15:54:43 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:63749 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S319510AbSIGTyl>;
	Sat, 7 Sep 2002 15:54:41 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209071959.g87JxKN17732@oboe.it.uc3m.es>
Subject: Re: [lmb@suse.de: Re: [RFC] mount flag "direct" (fwd)]
In-Reply-To: <20020907164631.GA17696@marowsky-bree.de> from Lars Marowsky-Bree
 at "Sep 7, 2002 06:46:31 pm"
To: Lars Marowsky-Bree <lmb@suse.de>
Date: Sat, 7 Sep 2002 21:59:20 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Lars Marowsky-Bree wrote:"
> as per your request, I am forwarding this mail to you again. The main point

Thanks.

> you'll find is that yes, I believe that your idea _can_ be made to work. Quite
> frankly, there are very few ideas which _cannot_ be made to work. The
> interesting question is whether it is worth it to a particular route or not.
> 
> And let me say that I find it at least slightly rude to "miss" mail in a
> discussion; if you are so important that you get so much mail every day, maybe
> a public discussion on a mailing list isn't the proper way how to go about
> something...

Well, I'm sorry. I did explain that I am travelling, I think! And
it is even very hard to connevct occasionally (it requires me finding 
an airport kiosk or an internet cafe), and then I have to _pay_ for the
time to compose a reply, and so on! Well, if I don't read your mail for
one day, then it will be filed somewhere for me by procmail, and I
haven't been able to check any filings ..

> > > *ouch* Sure. Right. You just have to read it from scratch every time. How
> > > would you make readdir work?
> > Well, one has to read it from scratch. I'll set about seeing how to do.
> > CLues welcome.
> 
> Yes, use a distributed filesystem. There are _many_ out there; GFS, OCFS,
> OpenGFS, Compaq has one as part of their SSI, Inter-Mezzo (sort of), Lustre,
> PvFS etc.

Eh, I thought I saw this - didn't I reply?

> Any of them will appreciate the good work of a bright fellow.

Well, I know of some of these. Intermezzo I've tried lately and found
near impossible to set up and work with (still, a great improvement
over coda, which was absolutely impossible, to within an atom's
breadth). And it's nowhere near got the right orientation. Lustre
people have been pointing me at. What happened to petal?

> Noone appreciates reinventing the wheel another time, especially if - for
> simplification - it starts out as a square.

But what I suggest is finding a simple way to turn an existing FS into a 
distributed one. I.e. NOT reinventing the wheel. All those other people
are reinventing a wheel, for some reason :-).

> You tell me why Distributed Filesystems are important. I fully agree.
> 
> You fail to give a convincing reason why that must be made to work with
> "all" conventional filesystems, especially given the constraints this implies.

Because that's the simplest thing to do.

> Conventional wisdom seems to be that this can much better be handled specially
> by special filesystems, who can do finer grained locking etc because they
> understand the on disk structures, can do distributed journal recovery etc.

Well, how about allowing get_block to return an extra argument, which
is the ondisk placement of the inode(s) concerned, so that the vfs can
issue a lock request for them before the i/o starts. Let the FS return
the list of metadata things to lock, and maybe a semaphore to start the
i/o with.

There you are: instant distribution. It works for thsoe fs's which
cooperate. Make sure the FS can indicate whether it replied or not.

> What you are starting would need at least 3-5 years to catch up with what
> people currently already can do, and they'll improve in this time too. 

Maybe 3-4 weeks more like. The discussion is helping me get a picture,
and when I'm back next week I'll try something. Then, unfortunately I
am away again from the 18th ...

> I've seen your academic track record and it is surely impressive. I am not

I didn't even know it was available anywhere! (or that it was
impressive - thank you).

> saying that your approach won't work within the constraints. Given enough
> thrust, pigs fly. I'm just saying that it would be nice to learn what reasons
> you have for this, because I believe that "within the constraints" makes your
> proposal essentially useless (see the other mails).
> 
> In particular, they make them useless for the requirements you seem to have. A
> petabyte filesystem without journaling? A petabyte filesystem with a single
> write lock? Gimme a break.

Journalling? Well, now you mention it, that would seem to be nice. But
my experience with journalling FS's so far tells me that they break
more horribly than normal.  Also, 1PB or so is the aggregate, not the
size of each FS on the local nodes. I don't think you can diagnose
"journalling" from the numbers. I am even rather loath to journal,
given what I have seen.


> Please, do the research and tell us what features you desire to have which are
> currently missing, and why implementing them essentially from scratch is

No features. Just take any FS that corrently works, and see if you can
distribute it.  Get rid of all fancy features along the way.  You mean
"what's wrong with X"?  Well, it won't be mainstream, for a start, and
that's surely enough.  The projects involved are huge, and they need to
minimize risk, and maximize flexibility. This is CERN, by the way.


> preferrable to extending existing solutions.
> 
> You are dancing around all the hard parts. "Don't have a distributed lock
> manager, have one central lock." Yeah, right, has scaled _really_ well in the
> past. Then you figure this one out, and come up with a lock-bitmap on the
> device itself for locking subtrees of the fs. Next you are going to realize
> that a single block is not scalable either because one needs exclusive write

I made suggestions, hoping that the suggestions would elicit a response
of some kind. I need to explore as much as I can and get as much as I
can back without "doing it first", because I need the insight you can
offer.  I don't have the experience in this area, and I have the
experience to know that I need years of experience with that code to be
able to generate the semantics from scracth.  I'm happy with what I'm
getting.  I hope I'll be able to return soon with a trial patch.


> lock to it, 'cause you can't just rewrite a single bit. You might then begin
> to explore that a single bit won't cut it, because for recovery you'll need to
> be able to pinpoint all locks a node had and recover them. Then you might
> begin to think about the difficulties in distributed lock management and

There is no difficulty with that - there are no distributed locks. All
locks are held on the server of the disk (I decided not to be
complicated to begine with as a matter of principle early in life ;-).

> recovery. ("Transaction processing" is an exceptionally good book on that I
> believe)

Thanks but I don't feel like rolling it out and rolling it back!

> I bet you a dinner that what you are going to come up with will look
> frighteningly like one of the solutions which already exist; so why not

Maybe.

> research them first in depth and start working on the one you like most,
> instead of wasting time on an academic exercise?

Because I don't agree with your assessment of what I should waste my
time on. Though I'm happy to take it into account!

Maybe twenty years ago now I wrote my first disk based file system (for
functional databases) and I didn't like debugging it then! I positively
hate the thought of flattening trees and relating indices and pointers
now :-).

> > So, start thinking about general mechanisms to do distributed storage.
> > Not particular FS solutions.
> 
> Distributed storage needs a way to access it; in the Unix paradigm,
> "everything is a file", that implies a distributed filesystem. Other
> approaches would include accessing raw blocks and doing the locking in the
> application / via a DLM (ie, what Oracle RAC does).

Yep, but we want "normality", just normality writ a bit larger than
normal.

>     Lars Marowsky-Br_e <lmb@suse.de>

Thanks for the input. I don't know what I was supposed to take away
from it though!

Peter
