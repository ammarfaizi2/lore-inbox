Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263046AbTCLFeB>; Wed, 12 Mar 2003 00:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263047AbTCLFeB>; Wed, 12 Mar 2003 00:34:01 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:51402 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S263046AbTCLFeA>;
	Wed, 12 Mar 2003 00:34:00 -0500
Message-Id: <200303120544.h2C5ibMY008372@eeyore.valparaiso.cl>
To: Zack Brown <zbrown@tumblerings.org>
cc: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone 
In-Reply-To: Your message of "Tue, 11 Mar 2003 21:22:25 PST."
             <20030312052225.GO4716@renegade> 
Date: Wed, 12 Mar 2003 01:44:37 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zack Brown <zbrown@tumblerings.org> said:
> On Tue, Mar 11, 2003 at 11:47:50PM -0400, Horst von Brand wrote:
> > Zack Brown <zbrown@tumblerings.org> said:
> > > --------------------------------- cut here --------------------------------
> -
> > > 
> > >            Linux Kernel Requirements For A Version Control System    
> > > 
> > > Document version 0.0.1
> > 
> > [...]
> > 
> > > In the context of sharing changesets between repositories, a changeset
> > > consists of a diff between the set of files in the local and remote
> > > repositories.
> > 
> > I don't think it is a good idea to handle differences _between_
> > repositories, as they could be arbitrary and change in time. A change
> > _within_ a repository is well defined.

> But isn't it necessary to excange changesets between repositories? How
> else would a developer choose exactly what changes get merged with a
> remote repository?

_From_ a remote repository. I pull stuff, I can't push it. Once I got the
"patch" here, I start integrating it into my repository. The granularity
should be a changeset (i.e., changes between two well defined points in the
remote repository). If it patches in cleanly, great! If not, do merging (==
resolve problems, by hand if need be).

> > >   2. Behavior
> > > 
> > >     2.1 Tagging
> > > 
> > > It must be trivial for a developer to tag a file as part of a given
> > > changeset.
> > 
> > An individual change, not a file. You need to focus on changes to files,
> > not files. I.e., file appeared/dissapeared/changed name/was edited by
> > altering lines so and so. 
> > 
> > The bk method of accepting individual changes, and then bundling them up
> > should be enough, people tend to work at one problem at a time.
> 
> I'm not so familiar with how BitKeeper operates. What do you mean by
> "accepting individual changes, and then bundling them up"?

In bk you edit a bunch of files, and commit the changes (individually or as
a set), and then you say "Now make all pending changes into a changeset".

> > > The implementation must not depend on time being accurately reported
> > > by any of the repositories.

> > It is more complicated than that. On a distributed system without some form
> > of shared clock it might be impossible (== nonsense, like in relativity
> > theory) to talk of a global "before" and "after"

> Maybe the system should simply ignore the whole concept of time as occurring
> in discrete ticks, and just measure time as the relative history of
> changesets.

Exactly. But this timeline makes sense for one repository only, and (in a
limited way, via merge points) it makes timelines (somewhat) comparable
between repositories. But note that A might take 13 and much later 5 from
B, as long as there is no conflict they will go in cleanly. But this is
time going backwards. Now factor in unrelated exchanging of changesets with
other actors...

>             That might give it enough of a basis to make estimates on which
> changes came 'before' and 'after' other changes in most cases. I imagine a
> lot of subtle intelligence could be implemented. And for situations defying
> that intelligence, the system could query the user.

There is no universal "before" and "after", even within one repository;
there might be changes that can't be ordered. I.e., changes to files foo
and bar are independent, and might have happened in any order for the same
result. Same for all non-overlapping changes.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
