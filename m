Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282483AbRL0VYk>; Thu, 27 Dec 2001 16:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282707AbRL0VYb>; Thu, 27 Dec 2001 16:24:31 -0500
Received: from [198.17.35.35] ([198.17.35.35]:45034 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S282655AbRL0VYV>;
	Thu, 27 Dec 2001 16:24:21 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2A3B@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'Larry McVoy'" <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: The direction linux is taking
Date: Thu, 27 Dec 2001 13:24:27 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly playing devil's advocate here :)

> Merging is much easier.

how exactly?  the actual merge is done
from a patch which if it isn't cleanly
applied then it's probably not wanted
anyways :)

(on the other hand SCM makes it MUCH easier
to deal with the 'cleanly applied' part :)

> Tracking of patches is much easier.

not really : how do you make sure that all the
correct patches have been applied?  All SCM
lets you gain is knowing what patches have
been applied, not what patches were NOT applied.

> Access control is much easier.

but if it's only Linus, then this is a moot point :)

> > (If, on the other hand, we allowed multiple committers
> > and access-controlled maintainer lists, then SCM would
> > be beautiful!  but this isn't FreeBSD :) :) :) :) :)

> Actually, BK can definitely do that.

I HOPE SO!  it's kinda the whole basic essential component for
any multi-user SCM system!  The problem isn't that BK can't,
but that Linus won't :) :) :)

> In fact, that's basically exactly what
> we have on the hosting service for the PPC tree.  There are a 
> list of people
> who are administrators, a list of committers, as well as read 
> only access.
> The admins are also committers if they want to be, the admins 
> also get to
> control who is and is not a committer.

which is pretty much what FreeBSD (for example) does.
of course they're using CVS (and we won't go there :)

> And you dream up as complicated an access control model as 
> you want.  We
> can do pretty much any model you can describe.  Try me, 
> describe a work
> flow that you think would be useful, I'll write up how to do 
> it and stick
> it on a web page and you can throw stones at it and see if it breaks.

ok, i have to go learn bitkeeper now so i can answer this
intelligently, but i'll give some examples from perforce
(which is what i'm using now :) 

Common task 1 : usability
perforce tracks what everyone has.  this means that if you want
to do a sync to current, it only gives you what's changed since
your last sync, because it knows, and you didn't do anything
without telling it, right?

well, what if i'm working on 2.5 stuff for my magical danaDriver?
It's really intense, has a lot of files all over the place, and I
don't want to hurt anything.  Then someone asks me about the
interaction between danaDriver and reiserFS in 2.4.17 and I want
to make sure I can see exactly what they're talking about.

so what i want to do (and i can't do in perforce, well, not easily)
is to make a clean checkout of the last 'official release' of the
whole project from SCM _without_ affecting my workspace.

i.e. i do NOT want to create a new workspace, i do not want to create
a special directory, i just want to do :
	mkdir linux
	cvs checkout linux -tag 2.4.17
and get the whole linux-2.4.17 source code, without affecting my working
directory 'linux-2.5' which also has the linux/* (main)branch checked out.

In perforce, for example, I have to :
(yes, with branches this can be done MUCH easier, but i'm trying to
prove a point here :)
1 - make a new client spec.  although this is effectively a plaintext file
    and can be automated with scripts, it's really dumb that i have to do
    this.
2 - set my environment variables to use this new client spec.
3 - run a p4 sync -tag 2.4.17 (the server says "hey, there's no files
there!"
    and checks out the whole thing for me)
4 - change my environment variables back and go on working in 2.5
danaDriver.
    essentially having 2 workspaces, with the environment variable the diff
    between them.

of course there's no .CVS directories here, as perforce doesn't use them,
so the checkout is 'clean' :)

Common Task 2 : Accountability

This is something perforce does REALLY well.
I can do this :
- set it up so anyone can submit a change request [patch] but it has
  to be approved by the directory/file's owner first.  if it's not
  approved, it can't be submitted.
  this means that ANYONE can submit a patch, and everyone gets to
  participate, and accountability is maintained.
- set it up so that interested parties get notified of every change
  that is submitted, including a web link to the full diffs of that
  change.  notification is file/directory based, and can have 'excludes'
  so rik can get notified every time 'virtualmemory.c' is changed so
  that way he can start flaming andrea right away :) :) :) :) :)

Can you do these things with bitkeeper?  (yeah, i'll go read the website
info :)

Dana Lacoste
Ottawa, Canada
