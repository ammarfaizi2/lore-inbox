Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUHSTXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUHSTXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267306AbUHSTXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:23:38 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:29850 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267304AbUHSTW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:22:27 -0400
From: jmerkey@comcast.net
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: kallsyms 2.6.8 address ordering
Date: Thu, 19 Aug 2004 19:22:22 +0000
Message-Id: <081920041922.5533.4124FDED0003FA0C0000159D2200762302970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> On Thu, Aug 19, 2004 at 06:26:31PM +0000, jmerkey@comcast.net wrote:
> > Yes.
> > 
> > What would be required?   Source code disclosure to a reviewer.  MDB is 
> platform independent.  and patches in an alternate debugger interface in 
> kdb_main.  In includes **NONE** of SGI's source code or Linux kernel source in 
> the MDB core.  There is an open source section of the debugger with **ALL** 
> modifications to kdb core files disclosed with the debugger modules.  The fact 
> is, I don't even need kdb, but inlcuded it in a mode where folks who wanted to 
> switch between the two debuggers could do so, since a lot of folks wanted to.  I 
> do use the serial interface in kdb, which is the only portion.  I wrote MANOS 
> with this debugger, and all the low level GDT, IDT, etc. hardware stuff is my 
> own, is vastly superior to what's in kdb.   
> > 
> > DRDOS owns the MDB debugger for Linux now and I maintain it for them -- that's 
> it.  I am certain DRDOS would provide any counter-claims with **FACTS** to 
> assertions we are using any of the kdb code improperly.
> 
> So it works with unpatched kernels?

Hmmm.  Linux has no trap interface to register hooks into the IDT table.  No screen output 
manager to allow screen drivers to be debugged (which is why kdb has to call all the 
console drivers in a chain and output text on all of them at the same time). No interface 
to restore keyboard hardware state after being taken over in a polling loop by a debugger 
keyboard handler.    

Sounds like it's not possible to support a commercial debugger without patching the kernel.  
If the patches to the kernel are open sourced (which they are) and use a call layer to a binary 
module, it does not appear this violates the GPL.  Will Linux ever support a true alternate 
debugger interface?  Let's see what Linus had to say about this.

On Wed, 6 Sep 2000, Tigran Aivazian wrote:
>
> very nice monologue, thanks. It would be great to know Linus' opinion. I
> mean, I knew Linus' opinion of some years' ago but perhaps it changed? He
> is a living being and not some set of rules written in stone so perhaps
> current stability/highquality of kdb suggests to Linus that it may be
> (just maybe) acceptable into official tree?

I don't like debuggers. Never have, probably never will. I use gdb all the
time, but I tend to use it not as a debugger, but as a disassembler on
steroids that you can program.

None of the arguments for a kernel debugger has touched me in the least.
And trust me, over the years I've heard quite a lot of them. In the end,
they tend to boil down to basically:

 - it would be so much easier to do development, and we'd be able to add
   new things faster.

And quite frankly, I don't care. I don't think kernel development should
be "easy". I do not condone single-stepping through code to find the bug.
I do not think that extra visibility into the system is necessarily a good
thing.

Apparently, if you follow the arguments, not having a kernel debugger
leads to various maladies:
 - you crash when something goes wrong, and you fsck and it takes forever
   and you get frustrated.
 - people have given up on Linux kernel programming because it's too hard
   and too time-consuming
 - it takes longer to create new features.

And nobody has explained to me why these are _bad_ things.

To me, it's not a bug, it's a feature. Not only is it documented, but it's
_good_, so it obviously cannot be a bug.

"Takes longer to create new features" - this one in particular is not a
very strong argument for having a debugger. It's not as if lack of
features or new code would be a problem for Linux, or, in fact, for the
software industry as a whole. Quite the reverse. My biggest job is to say
"no" to new features, not trying to find them.

Oh. And sure, when things crash and you fsck and you didn't even get a
clue about what went wrong, you get frustrated. Tough. There are two kinds
of reactions to that: you start being careful, or you start whining about
a kernel debugger.

Quite frankly, I'd rather weed out the people who don't start being
careful early rather than late. That sounds callous, and by God, it _is_
callous. But it's not the kind of "if you can't stand the heat, get out
the the kitchen" kind of remark that some people take it for. No, it's
something much more deeper: I'd rather not work with people who aren't
careful. It's darwinism in software development.

It's a cold, callous argument that says that there are two kinds of
people, and I'd rather not work with the second kind. Live with it.

I'm a bastard. I have absolutely no clue why people can ever think
otherwise. Yet they do. People think I'm a nice guy, and the fact is that
I'm a scheming, conniving bastard who doesn't care for any hurt feelings
or lost hours of work if it just results in what I consider to be a better
system.

And I'm not just saying that. I'm really not a very nice person. I can say
"I don't care" with a straight face, and really mean it.

I happen to believe that not having a kernel debugger forces people to
think about their problem on a different level than with a debugger. I
think that without a debugger, you don't get into that mindset where you
know how it behaves, and then you fix it from there. Without a debugger,
you tend to think about problems another way. You want to understand
things on a different _level_.

It's partly "source vs binary", but it's more than that. It's not that you
have to look at the sources (of course you have to - and any good debugger
will make that _easy_). It's that you have to look at the level _above_
sources. At the meaning of things. Without a debugger, you basically have
to go the next step: understand what the program does. Not just that
particular line.

And quite frankly, for most of the real problems (as opposed to the stupid
bugs - of which there are many, as the latest crap with "truncate()" has
shown us) a debugger doesn't much help. And the real problems are what I
worry about. The rest is just details. It will get fixed eventually.

I do realize that others disagree. And I'm not your Mom. You can use a
kernel debugger if you want to, and I won't give you the cold shoulder
because you have "sullied" yourself. But I'm not going to help you use
one, and I wuld frankly prefer people not to use kernel debuggers that
much. So I don't make it part of the standard distribution, and if the
existing debuggers aren't very well known I won't shed a tear over it.

Because I'm a bastard, and proud of it!

                        Linus

Based upon the comments above, they leave little doubt there will **EVER** be an interface 
into Linux to support a commercial debugger.   Perhaps Linus would change his mind and 
include an open debugger interface.  It would require very little for KDebug and kdb to work. 

Jeff


- 


> 
