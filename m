Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVBSQm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVBSQm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 11:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVBSQm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 11:42:26 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:5433
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261722AbVBSQmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 11:42:15 -0500
Date: Sat, 19 Feb 2005 17:42:13 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Patrick McFarland <pmcfarland@downeast.net>
Cc: linux-kernel@veger.kernel.org,
       Erik =?iso-8859-1?Q?B=E5gfors?= <zindar@gmail.com>,
       Tupshin Harper <tupshin@tupshin.com>, darcs-users@darcs.net,
       lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
Message-ID: <20050219164213.GB7247@opteron.random>
References: <20050214020802.GA3047@bitmover.com> <845b6e8705021803533ba8cc34@mail.gmail.com> <20050218125057.GE2071@opteron.random> <200502190410.31960.pmcfarland@downeast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502190410.31960.pmcfarland@downeast.net>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 04:10:18AM -0500, Patrick McFarland wrote:
> In the case of darcs, RCS/SCCS works exactly opposite of how darcs does. By 
> using it's super magical method, it represents how code is written and how it 
> changes (patch theory at its best). You can clearly see the direction code is 
> going, where it came from, and how it relates to other patches.

I don't know anything about darcs, I was only talking about arch. I
failed to compile darcs after trying for a while, so I give it up, I'll
try again eventually.

But anyway the only thing I care about is that you import all dozen
thousands changesets of the 2.5 kernel into it, and you show it's
manageable with <1G of ram and that the backup size is not very far from
the 75M of CVS.

I read in the webpage of the darcs kernel repository that they had to
add RAM serveral times to avoid running out of memory. They needed more
than 1G IIRC, and that was enough for me to lose interest into it.
You're right I blamed the functional approach and so I felt it was going
to be a mess to fix the ram utilization, but as someone else pointed
out, perhaps it's darcs to blame and not haskell. I don't know.

To me backup size matters too and for example I'm quite happy the fsfs
backend of SVN generates very small backups compared to bsddb.

> Sure, you can do this with RCS/SCCS style versioning, but whats the point? It 
> is inefficient, and backwards.

It is saved in a compact format, and I don't think it'll run slower
since if it's in cache it'll be fast and if it's I/O dominaed the more
compact it is, the faster it will be, having a compact size both for the
repository and for the backup, is more important to me.

In theory one could write a backup tool that extracts the thing and
rewrite a special backup-backend that is as space efficient as CVS and
that can compress as well as CVS, but this won't help the working copy.

> Thats all up to how the versioning system is written. Darcs developers are 
> working in a checkpoint system to allow you to just grab the newest stuff, 

This is already available with arch. Infact I suggested myself how to
improve it with hardlinks so that a checkout will take a few seconds no
matter the size of the tree.

> and automatically grab anything else you need, instead of just grabbing 
> everything. In the case of the darcs linux repo, no one wants to download 600 
> megs or so of changes.

If you use arch/darcs as a patch-download tool, then that's fine as you
say and you can already do that with arch (that in this part seems
already a lot more advanced and it's written in C btw).  Most people
just checking out the kernel with arch (or darcs) would never need to
download 600Megs of changes, but I need to download them all.

The major reason a versioning system is useful to me is to track all
changesets that touched a single file since the start of 2.5 to the
head. So I can't get away by downloading the last dozen patches and
caching the previous tree (which is perfectly doable with arch for ages
and with hardlinks as well).

> It may not even be space efficient. Code ultimately is just code, and changes 
> ultimately are changes. RCS isn't magical, and its far from it. Infact, the 

The way RCS stores the stuff compresses great. In that is "magical". I
guess SCCS is the same. fsfs isn't bad either though, and infact I'd
never use bsddb and I'd only use fsfs with SVN.

> The darcs repo which has the entire history since at least the start of 2.4 
> (iirc anyways) to *now* is around 600 to 700. 
> My suggestion is to convert _all_ dozen thousand changesets to darcs, and then 
> compare the size with CVS. And no, darcs doesn't eat that much memory for the 

What is the above 600/700 number then? I thought that was the conversion
of all dozen thousand changesets of linux-2.5 CVS to darcs.

> amount of work its doing. (And yes, they are working on that).

I'll stay tuned.

To me the only argument for not using a "magic" format like CVS or SCCS
that is space efficient and compresses efficiently, is if you claim it's
going to be a lot slower at checkouts (but infact applying some dozen
thousand patchsets to run a checkout is going to be slower than
CVS/SCCS). I know it's so much simpler to keep each patchset in a
different file like arch is already doing, but that's not the best
on-disk format IMHO.

Note that some year ago I had the opposite idea, i.e. at some point I
got convinced it was so much better to keep each patch separated from
each other like you're advocating above, until I figured out how big the
thing grows and how little space efficient it is, and how much I/O it
forces me to do, how much disk it wastes in the backup and how slow it
is as well to checkout dozen thousand patchsets.

For smaller projects without dozen thousand changesets, the patch per
file looks fine instead. For big projects IMHO being space efficient is
much more important.
