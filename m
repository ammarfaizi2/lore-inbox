Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289989AbSBFEIA>; Tue, 5 Feb 2002 23:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290009AbSBFEHv>; Tue, 5 Feb 2002 23:07:51 -0500
Received: from dsl-213-023-043-188.arcor-ip.net ([213.23.43.188]:58277 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289989AbSBFEHn>;
	Tue, 5 Feb 2002 23:07:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Nathan Scott <nathans@sgi.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: VFS EA interface patch (was: A modest proposal...)
Date: Wed, 6 Feb 2002 05:08:06 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <ag@bestbits.at>
In-Reply-To: <p73d6zshidj.fsf@oldwotan.suse.de> <Pine.LNX.4.33.0201291502460.1747-100000@penguin.transmeta.com> <20020130104004.C81308@wobbly.melbourne.sgi.com>
In-Reply-To: <20020130104004.C81308@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16YJNO-0000rY-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2002 12:40 am, Nathan Scott wrote:
> hi Linus,
> 
> On Tue, Jan 29, 2002 at 03:13:14PM -0800, Linus Torvalds wrote:
> > 
> > On 30 Jan 2002, Andi Kleen wrote:
> > > Does that answer your questions?
> > > Would you look at a patch again?
> > 
> > That answers the specific questions about Al and Stephen.
> 
> Al had several (additional) issues with the original patch, but I
> think we progressively worked through them - Al stopped suggesting
> changes at one point anyway, and the level of abuse died away ;),
> so I guess he became more satisfied with them.
> 
> > It does NOT address whether consensus has been reached in general, and
> > whether people are happy. Is that the case?
> 
> I believe so - I know that the ext2/ext3 EA/ACL maintainer 
> (AndreasG, CCd) is satisfied with the current patches, from
> an XFS point of view they satisfy all our needs, and Anton
> has chimed in saying this interface will work well for NTFS
> EA support (Anton sent me patches and several suggestions as
> well, which were included in the patch at the time).
> 
> > Also, obviously nobody actually took over maintainership of the patch,
> > because equally obviously nobody has been pinging me about it. For some
> > reason you seem to want _me_ to go out of my way to search for patches
> > that are over a month old that I don't know whether they are valid or not,
> > used or not, or even agreed upon or not.
> > 
> > But yes, it's so much easier to blame me.
> > 
> 
> Not much point apportioning blame - its as much my fault - I
> hadn't heard back from you at all since day 1, so figured you
> were just not interested in this stuff, so I stopped sending.
> 
> The two patches which seemed to satisfy the most people are
> below - they are unchanged from 2.5.0 but should apply to any
> 2.5.x tree (they are fairly non-intrusive and the system call
> table hasn't changed since last time).  A complete userspace
> implementation for both EAs and POSIX ACLs exists above these
> interfaces.

It was a little odd to see this patch get submitted and accepted in the 
middle of the 'patch penguin' thread.  IMHO, this illustrates perfectly why
we need a standard place to submit patches.  There is a patchbot under
construction, which I hope will address this kind of problem without
introducing new ones.  We shall see if it really does when it's opened up for 
testing, EA about one month.

The idea is that we'll create a patch submission address for the patchbot 
itself, and see what it feels like submitting patchbot patches that way.  For 
anyone interest, the project page is here:

  http://killeri.net/patchbot.html

with links there already somewhat out of date, please see the mailing list 
archive.

My main problem with the EA interface patch itself is that there is no
way to specify the class of the EA, currenly 'system' or 'user'.
Instead, individual filesystems are expected to parse the attribute
name to determine the class.  I think this is inadequate, and has not
been discussed sufficiently.

What will happen is, user space utilities will start making assumptions
about the syntax of ea names (because the kernel interface provides no
other alternative) and the current, arbitrary, EA name syntax will become 
cast in stone for ever more.  Then attribute classes will start to multiply, 
we'll get attribute namespaces, and we'll get more arbitrary hacks added to 
the attribute name syntax to accomodate them.  Support for 'new, improved' 
attribute name syntax will be variable across filesystems.  This isn't going 
to be pretty.

-- 
Daniel
