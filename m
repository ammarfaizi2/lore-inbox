Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129355AbRBCCWg>; Fri, 2 Feb 2001 21:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129468AbRBCCW1>; Fri, 2 Feb 2001 21:22:27 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:46517 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129355AbRBCCWK>; Fri, 2 Feb 2001 21:22:10 -0500
Date: Sat, 3 Feb 2001 02:22:02 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Hans Reiser <reiser@namesys.com>
cc: Alan Cox <alan@redhat.com>, John Morrison <john@vmlinux.net>,
        Chris Mason <mason@suse.com>, Jan Kasprzak <kas@informatics.muni.cz>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
In-Reply-To: <3A7B2E94.F52C4342@namesys.com>
Message-ID: <Pine.SOL.4.21.0102030216140.12570-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Feb 2001, Hans Reiser wrote:
> Alan Cox wrote:
> > 
> > > It makes sense to refuse to build a piece of the kernel if it break's
> > > a machine - anything else is a timebomb waiting to explode.
> > 
> > The logical conclusion of that is to replace the entire kernel tree with
> > 
> > #error "compiler or program might have a bug. Aborting"
> 
> No, this is a compiler that DOES have a bug.  ReiserFS is, as best as
> I can make it, for mission critical servers where some sysadmin
> doesn't want to explain it to the CEO.  There are plenty of ways that
> I fail at this, but not intentionally.

Yep. For once, I agree with Hans here: if you *KNOW* the current compiler
is fatally broken, the best thing to do is blow up. As hard as possible,
as soon as possible. Anything else is just hiding the problem.

(snip)
> My design objective in ReiserFS is not to say that it wasn't my fault
> they had that bug because they are so ignorant about a filesystem that
> really isn't very important to them unless it screws up.  My design
> objective is to ensure they don't have that bug.  They are more
> important than me.

Hrm... better idiot-proofing just tends to produce better idiots.

> > The kernel is NOT some US home appliance festooned with 'do not eat this
> > furniture' and 'do not expose your laserwrite to naked flame' messages.
> > The readme says its been tested with egcs-1.1.2 and gcc 2.95.

Hrm. Ever wonder which country Alan lives in? :-)

(Alan: Visit the next McDonalds you pass, and buy a coffee. Look at the
warning on the side about the coffee being hot... then complain it isn't, 
after a suitable delay...)

> > Large numbers of people routinely build the kernel with 'unsupported' compilers
> > notably the pgcc project people and another group you will cause problems for
> > - the GCC maintainers. They use the kernel tree as part of the test set for
> > their kernel, something putting #ifdefs all over it will mean they have to
> > mess around to fix too.

If it's specific enough to that particular gcc, it won't trip the gcc
people up - unless they're really using that specific version, in which
case it SHOULD blow up anyway!

> A moment of precision here.  We won't test to see if the right
> compiler is used, we will just test for the wrong one.

Which is fine, IMO. "Warning: your compiler MIGHT be broken - please look
at README" is OK, as is "Error: this compiler *IS* broken - it's gcc X.XX,
which we know is broken because (foo)". "Error: this compiler looks like
version foo, which we think might be broken" isn't, as Alan says...


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
