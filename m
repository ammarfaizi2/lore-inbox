Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSG3I3B>; Tue, 30 Jul 2002 04:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSG3I3B>; Tue, 30 Jul 2002 04:29:01 -0400
Received: from pc132.utati.net ([216.143.22.132]:3722 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S315259AbSG3I27>; Tue, 30 Jul 2002 04:28:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Andries.Brouwer@cwi.nl, axboe@suse.de, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
Date: Mon, 29 Jul 2002 20:50:54 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, martin@dalecki.de
References: <UTC200207282359.g6SNxgW24418.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200207282359.g6SNxgW24418.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020730081554.15E96DED@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 July 2002 07:59 pm, Andries.Brouwer@cwi.nl wrote:

> You killed the idea of maintainers yourself, proclaiming
> that you did not work with maintainers but with lieutenants.

Linus didn't "kill the idea of maintainers", he just went to a four tier 
hierarchy for scalability reasons.

Here's my understanding of the current developent infrastructure.  Anybody 
who wants to disagree with this feel free, otherwise there should probably be 
some kind of FAQ entry or update to Documentation/SubmittingChanges.

Developers submit to maintainers.  Maintainers submit to lieutenants.  
Lieutenants submit to Linus.  Each level can take stuff from anyone below 
them if they want to, but only the layer IMMEDIATELY below them is owed any 
sort of explanation as to why a patch was NOT accepted.

I.E. If anybody but a lieutenant submits a patch to Linus, and he drops it, 
there's not much likelihood of an explanation why.  If a lieutenant signs off 
on a patch and forwards it to Linus, if it gets rejected he'll probably say 
why it was rejected.  (It could be his mailbox runneth over, but there 
shouldn't be the "I submitted this a dozen times and never heard anything" 
problem when Lieutenants submit to Linus.  In an ideal world, anyway. :)

This is, basically, what's special about lieutenants.  They are the ONLY 
people to whom Linus owes any kind of explanation when a patch gets rejected. 
 (The explanation may not be much more than "I don't like this, I'm not going 
to apply it, so there", but at least they aren't left hanging endlessly.  At 
the very least it's closure.)

Similarly, lieutenants should reply to the maintainers who report to them 
when they reject patches the maintainer has signed off on.  And maintainers 
should reply to individual developers who submit patches to them (by email; 
they may not see it if it's just posted on the list).  These replies are not 
only common courtesy, they help the system work.

So if a random developer wants to get a patch to Linus, and Linus doesn't 
just snatch it out of the ether, the way to proceed is find the appropriate 
maintainer, and get their opinion of the patch.  The developer needs to work 
with the maintainer until the patch is accepted by that maintainer: they need 
to fix anything the maintainer finds wrong with it, and if the maintainer 
says the whole thing is a bad idea, trying to "go over their heads" to a 
lieutenant is unlikely to work.  (They have a wonderful excuse to ignore you, 
which is the least effort solution on their part.  No you can't pester them 
into submission, you'll just wind up in an email auto-delete file.)

The maintainer may want changes, they may want peer review on a specific 
mailing list (sometimes linux-kernel, sometimes not), they may want benchmark 
results, they may want you to download and run a specific stress-testing 
suite...  Or they may be happy with it as is, or they may just say "no" to 
the whole idea and you have to go try another approach entirely.

Then, once a developer has gotten the maintainer to sign off on a patch 
("looks good to me"), the developer and/or the maintainer can submit it to 
the appropriate lieutenant, who is in charge of a larger part of the kernel 
and will most likely find a fresh batch of things wrong with the patch, so 
the process is repeated at the new level.  (Knowing which lieutenant to 
forward developers with patches to is part of a maintainer's job.)  When 
going for a lieutenant's blessing, it's still the developer's job to fix the 
patches.  The maintainer was just passing judgement, now the lieutenant is.  
Neither is under any obligation to do your work for you.  They find problems, 
but it's up to the developer to fix them.  They may be enthused enough by 
your idea to take it and run with it, but there's no guarantee of this, and 
they usually have a to-do list as long as your arm (and that's in a very 
small font) well before your patch enters the picture.

Again, the lieutenant can veto the entire idea of your patch (the 
maintainer's approval does not mean their lieutenant will approve), or raise 
any number of objections.  The lieutenant's approval is needed before 
proceeding, so the developer needs to fix anything the lieutenant finds wrong 
with the patch, regardless of what the maintainer thought.

Then once the lieutenant is appeased and signs off of it, the patch goes to 
Linus.  The lieutenant should probably be the one to forward it (cc:ing the 
developer) or else Linus probably won't even notice it (his in-box runneth 
over).

Trivial, obvious bugfixes can sometimes bypass this using the trivial patch 
manager (something like trivial@rustcorp.com, check the list archives.  Rusty 
Russel runs it).  Think of him as a "Lieutenant Jr. Grade", he accepts 
directly from developers, but only if it's a really obviously correct bug fix.

Bitkeeper helps this a bit: you can see when a patch goes in, so you get 
faster positive feedback.  And once it's in somebody's bitkeeper tree it may 
trickle upward without too much more active push from the developers (until 
something is found to be wrong with it).  But for negative feedback (that it 
was seen and rejected, and why) a developer still has to go through channels.

The advantage of all this is twofold:

1) Developers aren't left hanging endlessly with nobody responding to their 
patch submissions.  At each point, you know who to bug next to get an answer. 
 (Maybe not the answer you want, but an answer.)  This saves developers a lot 
of time and aggravation.

2) By the time a patch get to Linus, it's already been reviewed by two 
competent developers (somebody he directly trusts and somebody else they 
trust), the obvious cleanups have been done, and if they thought it needed 
wider peer review they'll have already suggested it before giving their 
approval.  (Some of them even run their own trees for testing purposes.)  
This saves Linus a lot of time and aggravation.  (He will still reject a lot 
of these patches.  Or require changes to be made, just like the first two 
levels.)

The reason some people think that maintainership is now meaningless is that 
Linus doesn't respond directly to maintainers.  Because Linus appoints 
lieutenants, and the lieutenants appoint maintainers under them, Linus may 
never even have heard of some of the maintainers, let alone trust their 
judgement.  But maintainers are needed to connect random unknown developers 
with lieutanants, so the lieutenants don't get overwhelmed.  As long as the 
lieutenants listen to their maintainers, and Linus listens to his 
lieutenants, the system works fine.

Was that a rambling and incoherent enough explanation for you?

> In the mathematical world, if someone wants to publish a paper,
> it is sent to a handful of referees. These reply "reject",
> or "accept", or "accept, but correct the following mistakes ...",
> or procrastinate so much that the editor takes some random decision
> herself.

The referres vet it, and then the editor vets it.  That's a three level 
hierarchy.  This is a four level one.

> Such a system would not be unreasonable in the Linux world.
> A SCSI patch is sent to linux-scsi and also to the five people
> active today in the area. They reply, preferably both to you
> and on linux-scsi, and if within one or two days after a positive
> reply no negative reply comes in, then apparently there are
> no objections.

Nope.  A lack of negative does not equal a positive.  That way lies madness.  
(Lots of people getting very mad, in fact...)

Rob
