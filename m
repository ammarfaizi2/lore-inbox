Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261565AbTCKTdL>; Tue, 11 Mar 2003 14:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261567AbTCKTdL>; Tue, 11 Mar 2003 14:33:11 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:62962 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261565AbTCKTdI>; Tue, 11 Mar 2003 14:33:08 -0500
Date: Tue, 11 Mar 2003 11:33:41 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Daniel Phillips <phillips@arcor.de>, Zack Brown <zbrown@tumblerings.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <24360000.1047411221@flay>
In-Reply-To: <20030311192639.E72163C5BE@mx01.nexgo.de>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030311184043.GA24925@renegade> <22230000.1047408397@flay> <20030311192639.E72163C5BE@mx01.nexgo.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Not sure if this was captured before (I don't see it explicitly in what
>> you sent), but one thing that I don't think current tools do well is to
>> keep changes seperated out. We need to be able to put a stack of 200
>> patches on top of 2.5.10, then be able to break those out again easily
>> come 2.5.60, once we've merged forward. Treating things as one big blob
>> will work great for Linus, but badly for others.
> 
> Coincidently, I was having a little think about that exact thing earlier 
> today. 

Good, then either I'm not insane, or at least I have company in the 
madhouse ;-) 

> Suppose we call the process of turning an exact delta into a 
> delta-with-context, "softening".  So you select a set of deltas somehow 
> (e.g., all deltas in wild-card set of files) then soften them by adding 
> context, or in the deluxe version, convert to lists of tokens with whitespace 
> markup.  The result is a first-class object in the database, called a, hmm, 
> soft changeset?  (Surely there is a better name.)

a "patch" ? ;-) A context-diff is kind of a delta with context. 
I have some similar patch tools to akpm, and he uses the patch as the
base concept of what he does.

> A soft changeset can be carried forward in the database automatically as long 
> as there are no conflicts (like patch with fuzz) and where there are 
> conflicts, the soft changeset itself can be versioned.  To implement soft 
> changeset versioning the lazy way, just merge the changeset with some version 
> and generate a new soft changeset against some other version.  A name for the 
> versioned soft changeset can be generated automatically, e.g.:
> 
>    changset.name-from.version-to.version.

Right ... what I do is basically have a script that does:
for i in *
<copy lastview to $i>
(cd $i; <apply $i>)

My patches all start with a sequence number (a bit like Andrea does), so
for i in * does really nicely. What it's *meant* to do is read $? back
from patch, and stop if patch failed to apply it properly (more than
just offsets), and barf for user intervention, but that bit's broken
at the moment ;-)
 
> You can wave your wand, and the soft changeset will turn into a universal 
> diff or a BK changeset.  But it's obviously a lot cleaner, extensible, 
> flexible and easier to process automatically than a text diff.  It's an 
> internal format, so it can be improved from time to time with little or no 
> breakage.
> 
> Did that make sense?

Yeah, the wand is called "creatediffs" in my case, and it takes all the
views in a dir, and diffs the first against the second, second against
third, etc. I always start with "000-virgin".

I might even clean up my tools, turn them into one perl script, and send
them out at the weekend. They're a fetid (but working) mess right now.

What we need is a "better context-diff", with something smarter to apply
it that understands C syntax (can fall back to cdiff for text / asm for
now). 

And whilst we're at it, would be nice to have something that tried to
produce the most human readable diffs, not the smallest ones. Renaming
the function at the top is frigging annoying.

>> At the moment, I slap the patches back on top of every new version
>> seperately, which works well, but is a PITA.
> 
> Tell me about it.

Well, it normally only takes me an hour per release. But it's still a
waste of time. And yes, I have to do some things by hand. But the screams
of others around me when BK goes wrong tell me it's not much better for
all its fancy tricks (for *my* usage at least), in terms of applying
patches happily to deleted files, etc. so it still needs manual fix up.
 
>> I hear this is something
>> of a pain to do with Bitkeeper (don't know, I've never tried it).
>> People muttered things about keeping 200 different views, which is
>> fine for hardlinked diff & patch (takes < 1s to clone normally), but
>> I'm not sure how long a merge would take in Bitkeeper this way? Perhaps
>> people who've done this in other SCM's could comment?
> 
> I've never seriously used any commercial SCM, so nobody can accuse me of 
> stealing their ideas.  On the other hand, it means I may have to take a few 
> shots way wide of the target before hitting any bullseyes.

Yeah, neither have I. CVS I tried for a day, and it was just laughable.
BK I never looked at yet (have been tempted by the fancy looking merge
tool a few times). I tend to be slow to pick up new tools ... I prefer
to let others knock out the bugs first, and most of the time they don't
stick anyway ... so it was wasted time. 

BK seems to be sticking better than most, but from the feedback I get
about it from others, I think I like my scripts well enough ... and can 
change them to do what I want, and I understand what they're doing, 
which makes me happy (they're 10 lines of sh or perl ;-)). And that's
not an open-source license thing ... it's complex enough that it wouldn't
do me any good to be open source (for any non-trivial mod). I want 
something *simple* personally.

M.
