Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289822AbSA2Ssm>; Tue, 29 Jan 2002 13:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289823AbSA2Ssg>; Tue, 29 Jan 2002 13:48:36 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:34448
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289822AbSA2Sr6>; Tue, 29 Jan 2002 13:47:58 -0500
Message-Id: <200201291845.g0TIjSU16741@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: <mingo@elte.hu>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 13:46:33 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201291324560.3610-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201291324560.3610-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 January 2002 08:54 am, Ingo Molnar wrote:
> On Mon, 28 Jan 2002, Rob Landley wrote:

>   - cleanliness
>   - concept
>   - timing
>   - testing
>
> a violation of any of these items can cause patch to be dropped *without
> notice*. Face it, it's not Linus' task to teach people how to code or how
> to write correct patches. Sure, he still does teach people most of the
> time, but you cannot *expect* him to be able to do it 100% of the time.

I'm trying to identify stuff that isn't necessarily Linus's job, and doesn't 
seem to be being done, and seeing if somebody ELSE can do it.  My proposal 
was my take on improving things.  If now is not the time for it, maybe 
smaller steps can be taken first.

Possibly Linus needs a "bounce this message to kernelnewbies.org's 'please 
teach this guy how to program' list?" key, as an alternative to the delete 
key?  For patches that try to do something useful and simply don't manage to?

This is one of the things I thought a patch penguin (and troupe of volunteer 
patch secretaries operating under a patch penguin) might be able to do.  
Right now, there's no troupe of patch secretaries because the patch 
submission queue is linus's mailbox.  (The real irreplaceable job of the 
patch penguin is queueing stuff for linus split out of the tree, so the patch 
penguin doesn't have to scale that much better than Linus does.  Other people 
working with the patch penguin could theoretically help 
massage/test/integrate/update patches.  And of course linus could still take 
patches directly from maintainers if he had the bandwidth to do so.  He can 
obviously even write his own code when he has time...)

Linux-kernel used to serve all these functions (it was the patch queue and 
the patch cleanup and sorting discussion list, and some people on it were a 
bit like patch secretaries), but the volume has gotten too high for it to 
function as such anymore.  Posting a patch here less than a dozen times 
doesn't really count as submitting it to Linus anymore.

One demarcation that COULD be made is 2.4 vs 2.5.  There could probably be 
seperate "stable" vs "development" lists.  Probably been suggested before and 
shot down, but does work aimed at Marcelo and work aimed at Linus really need 
to be on the same list?

> 2) concept
>
> many of the patches which were rejected for a long time are *difficult*
> issues. And one thing many patch submitters miss: even if the concept of
> the patch is correct, you first have to start by cleaning up *old* code,
> see issue 1). Your patch is not worth a dime if you leave in old cruft, or
> if the combination of old cruft and your new code is confusing. Also, make
> sure the patch is discussed and developed openly, not on some obscure
> list. linux-kernel@vger.kernel.org will do most of the time. I do not want
> to name specific patches that violate this point (doing that in public
> just offends people needlessly - and i could just as well list some of my
> older patches), but i could list 5 popular patches immediately.
>
> impact: a patch penguin just wont solve this concept issue, because, by
> definition, he doesnt deal with design issues. And most of the big patch
> rejections happen due to exactly these concept issues.

Definitely Linus's job.  But of those top 5 patches, how many of the patch 
pushers have had their ideas actually critiqued so they know why they're not 
going in?  (If it's just a question of "this work needs to be done 
first/also", that's a manageable problem.)

> 3) timing
>
> kernel source code just cannot go through arbitrary transitions. Eg. right
> now the scheduler is being cleaned up (so far it was more than 50
> sub-patches and they are still coming) - and work is going on to maximize
> the quality of the preemption patch, but until the base scheduler has
> stabilized there is just no point in applying the preemption patch - no
> matter how good the preemption patch is. Robert understands this very
> much. Many other people do not.
>
> impact: a patch penguin just wont solve this issue, because a patch
> penguin cannot let his tree transition arbitrarily either. Only separately
> maintained and tested patches/trees can handle this issue.

A patch penguin's tree could apply more "speculative" patches than Linus, 
because the nature of the tree is that some of the patches in it get backed 
out, or at the very least don't go on to Linus yet.

It's also a nice buffer of patches for Linus.  Even a relatively small buffer 
is a good thing to prevent data loss (16550a anyone?  Better than nothing...) 
 As long as the patches in the queue are maintained and kept up to date 
(which is work that is not being coordinated right now: person A's change 
breaks person B's patch, how does person A know if he doesn't apply person 
B's patch to his tree?).

And there's also the possibility that "judgement call" patches the patch 
penguin didn't want to include could be listed as "known to apply cleanly 
against this tree, but not included".  Just a page listing URLs to patches 
that are being tracked.  This has not previously been done by Alan, Dave, or 
Andrea, and maybe there's a reason why...

> 4) testing
>
> there are code areas and methods which need more rigorous testing and
> third-party feedback - no matter how good the patch. Most notably, if a
> patch exports some new user-space visible interface, then this item
> applies. An example is the aio patch, which had all 3 items right but was
> rejected due to this item. [things are improving very well on the aio
> front so i think this will change in the near future.]
>
> impact: a patch penguin just wont solve this issue, because his job, by
> definition, is not to keep patches around indefinitely, but to filter them
> to Linus.

Yes and no. Alan did more than that.  His tree contained stuff (like User 
Mode Linux) that he didn't immediately mean to forward to Linus.  Stuff HAS 
historically gone into patch penguin trees because the patch penguin likes 
the idea but believes it needs wider testing.

This stuff is usually a compile option.  XFS and JFS come to mind here, 
although that just points out we need a unified journaling layer, which is an 
ongoing discussion.  (Will a unified journaling layer come about until a tree 
exists that contains XFS, JFS, EXT3, and ReiserFS, and then people start 
scrutinizing the mess and combining common code?  I dunno...)

> Only separately maintained patches/trees help here. More people
> are willing to maintain separate trees is good (-dj, -ac, -aa, etc.), one
> tree can do a nontrivial transition at a time,

That's a seperately maintained patch that has not been integrated into a 
tree.  All patches apply to a Linux tree in order to get compiled into a 
system, and all patches could be downloaded as a tree (as the XFS guys do).

When I say tree I'm talking about a tree that's integrating patches from more 
than one source.  This is a step that comes after the patch has gone about as 
far as it's likely to as a seperate patch, seems to work pretty well, and 
needs testing by a wider audience in order to squeeze out more bugs or get 
more code review and comments on its design.

> and by having more of them
> we can eg. get one of them testing aio, the other one testing some other
> big change.

Sure.  This happens now.  The question is, what happens after the JFS people 
say "okay, we've reached version 1.0 now, please try this" and the patch 
still doesn't get integrated into a "beat me, whip me, make me break" tree 
for wider testing for months and months and months?

> A single patch penguin will be able to do only one nontrivial
> transition - and it's not his task to do nontrivial transitions to begin
> with.

I don't know what you mean here.

> Many people who dont actually maintain any Linux code are quoting Rik's
> complains as an example. I'll now have to go on record disagreeing with
> Rik humbly, i believe he has done a number of patch-management mistakes
> during his earlier VM development, and i strongly believe the reason why
> Linus ignored some of his patches were due to these issues. Rik's flames
> against Linus are understandable but are just that: flames. Fortunately
> Rik has learned meanwhile (we all do) and his rmap patches are IMHO
> top-notch. Joining the Andrea improvements and Rik's tree could provide a
> truly fantastic VM. [i'm not going to say anything about the IDE patches
> situation because while i believe Rik understands public criticism, i
> failed to have an impact on Andre before :-) ]

I understand that a lot of the problems aren't purely on Linus's end.  You 
didn't add Richard Gooch to that list with Rik and Andre (although Al seems 
to have decided it's one of his missions in life to keep Richard adhering to 
the coding style.... :)

But right now the individual maintainers need to be really good at patch 
management or the system breaks down.  This isn't exactly a scalability 
question, this is a reliability question.  There's no failure recovery 
mechanism here: if one part of the distributed system breaks the results are 
visible at the end.  You can't scale to more components if all of them most 
work perfectly every time and expect to have a more reliable system.

> also, many people just start off with a single big patch. That just doesnt
> work and you'll likely violate one of the 4 items without even noticing
> it. Start small, because for small patches people will have the few
> minutes needed to teach you.

The kernel is currently FULL of warnings when it used to have none, and 
outright compile errors that go unfixed for several versions if they occur in 
less-often used subsystems.

Small patches seem more likely to get dropped than big ones.  This could be 
an artifact of perception, I dunno...

> The bigger a patch, the harder it is to
> review it, and the less likely it happens. Also, if a few or your patches
> have gone into the Linux tree that does not mean you are senior kernel
> hacker and can start off writing the one big, multi-megabyte super-feature
> you dreamt about for years. Start small and increase the complexity of
> your patches slowly - and perhaps later on you'll notice that that
> super-feature isnt all that super anymore. People also underestimate the
> kind of complexity explosion that occurs if a large patch is created.
> Instead of 1-2 places, you can create 100-200 problems.
>
> face it, most of the patches rejected by Linus are not due to overload. He
> doesnt guarantee to say why he rejects patches - *and he must not*. Just
> knowing that your patch got rejected and thinking it all over again often
> helps finding problems that Linus missed first time around. If you submit
> to Linus then you better know exactly what you do.

There seems to be a perception that on at least some of the occasions Linus 
said "it didn't get applied because nobody ever sent me that patch", people 
were under the impression that the patch HAD been sent to him.

Sending a patch and hearing no reply, resending the same patch and then 
having it applied...  That sends mixed signals.  Resending the same patch a 
dozen times before it gets applied, how do you know if it's being rejected 
for a reason or if it's just a bad time?

> it's so much easier to blame Linus, or maintainers.

It's not a question of "blame".  Why does everybody keep thinking it's a 
question of blame?

It's "There seems to be a problem.  How do we fix it?"

The replies I've gotten range from denying there is any problem, assurances 
that the situation is functioning as maximum possible efficiency and cannot 
be improved, assurances that the problem is purely perceptual on my part, and 
a couple variations on "just live with it".

If this is the consensus...

> It's so much easier to
> fire off an email flaming Linus and getting off the steam than to actually
> accept the possibility of mistake and *fix* the patch. I'll go on record
> saying that good patches are not ignored, even these days when the number
> of active kernel hackers has multipled.

So patches that fix simple build breakage in things like the radeon or ymfpci 
drivers do not need to be resubmitted for multiple point releases?

> People might have to go through
> several layers first, and finding some kernel hacker who is not as loaded
> as Linus to review your patch might be necessery as well (especially if
> the patch is complex), but if you go through the right layers then you can
> be sure that nothing worthwile gets rejected arbitrarily.

Uh-huh.  Find people to review your patch, go through the right layers...

And a paralell tree to Linus's, dedicated to patch processing and tracking 
patches, with a patch submission system dedicated to routing patches to the 
proper maintainers, reviewing and cross-checking patches from maintainers, 
resolving conflicts, subjecting the lot to public scrutiny and being a 
one-stop-shopping place for people who want to find bugs in something...  
Like Alan Cox did for years, and like Dave Jones is doing now...  This is a 
totally different subject then?

Are people saying this is a bad thing?  Saying that this is useless?

Oh well, it was just a suggestion.  Seemed kind of a safe one since we were 
already mostly DOING it...

> 	Ingo

Rob
