Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130901AbRAFSRm>; Sat, 6 Jan 2001 13:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132226AbRAFSRc>; Sat, 6 Jan 2001 13:17:32 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2309 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130901AbRAFSRZ>; Sat, 6 Jan 2001 13:17:25 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Linux-2.4.x patch submission policy
Date: 6 Jan 2001 10:17:02 -0800
Organization: Transmeta Corporation
Message-ID: <937neu$p95$1@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought I'd mention the policy for 2.4.x patches so that nobody gets
confused about these things.  In some cases people seem to think that
"since 2.4.x is out now, we can relax, go party, and generally goof
off". 

Not so.

The linux kernel has had an interesting release pattern: usually the .0
release was actually fairly good (there's almost always _something_
stupid, but on the whole not really horrible).  And every single time so
far, .1 has been worse.  It usually takes until something like .5 until
it has caught up and surpassed the stability of .0 again. 

Why? Because there are a lot of pent-up patches waiting for inclusion,
that didn't get through the "we need to get a release out, that patch
can wait" filter.  So early on in the stable tree, some of those patches
make it.  And it turns out to be a bad idea. 

In an effort to avoid this mess this time, I have two guidelines:

 - I've basically thrown away all patches sent to me so far, and I will
   continue to do so at least over the weekend. I'm not going to bother
   thinking about patches for a few days.

 - In order for a patch to be accepted, it needs to be accompanied by
   some pretty strong arguments for the fact that not only is it really
   fixing bugs, but that those bugs are _serious_ and can cause real
   problems.

   Obviously, the size of the patch matters too: if you can make an
   obvious fix in 5 lines, do it.  Don't try to make a clean fix that
   fixes the problem the clever way in 150 lines. 

In short, releasing 2.4.0 does not open up the floor to just about
anything.  In fact, to some degree it will probably make patches _less_
likely to be accepted than before, at least for a while.  I want to be
absolutely convicned that the basic 2.4.x infrastructure is solid as a
rock before starting to accept more involved patches. 

Right now my ChangeLog looks like this:

 - Don't drop a megabyte off the old-style memory size detection
 - remember to UnlockPage() in ramfs_writepage()
 - 3c59x driver update from Andrew Morton

The first two are true one-liners that have already bitten some people
(not what I'd call a showstopper, but trivially fixable stuff that are
just thinkos).  The third one looks like a real fix for some rather
common hardware that could do bad things without it. 

Now, I'm sure that ChangeLog will grow.  There's the apparent fbcon bug
with MTRR handling that looks like a prime candidate already, and I'll
have people asking me for many many more.  But basically what I'm asking
people for is that before you send me a patch, ask yourself whether it
absolutely HAS to happen now, or whether it could wait another month.

Another way of putting it: if you have a patch, ask yourself what would
happen if it got left off the next RedHat/SuSE/Debian/Turbo/whatever
distribution CD.  Would it really be a big problem? If not, then I'd
rather spend the time _really_ beating on the patches that _would_ be a
big issue.  Things like security (_especially_ remote attacks), outright
crashes, or just totally unusable systems because it can't see the
harddisk. 

We'll all be happier if my ChangeLog is short and sweet, and if a 2.4.1
(tomorrow, in a week, in two, in a month, depending on what comes up)
actually ends up being _better_ than 2.4.0.  That would be a good new
tradition to start. 

And before you even bother asking about 2.5.x: it won't be opened until
I feel happy to pass on 2.4.x to somebody else (hopefully Alan Cox
doesn't feel burnt out and wants to continue to carry the torch and
feels ok with leaving 2.2.x behind by then).

Historically, that's been at least a few months.  In the 2.2.x series,
2.3.0 was the same as 2.2.8 with just the version changed - and it came
out in May, almost four months after 2.2.0.  In the 2.0.x series, 2.1.x
was based off 2.0.21, four and a half months after 2.0.0. 

Yes, I know this is boring, and all I'm asking is for people to not make
it any harder for me than they have to.  Think twice before sending me a
patch, and when you _do_ send me a patch, try to think like a release
manager and explain to me why the patch really makes sense to apply now. 

In short, I'm hoping for a fairly boring next few months. The more
boring, the better. 

		Thanks,

			Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
