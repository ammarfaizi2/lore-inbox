Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290747AbSBGXZF>; Thu, 7 Feb 2002 18:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290825AbSBGXY4>; Thu, 7 Feb 2002 18:24:56 -0500
Received: from 1Cust15.tnt15.sfo3.da.uu.net ([67.218.75.15]:6925 "EHLO
	morrowfield.home") by vger.kernel.org with ESMTP id <S290747AbSBGXYr>;
	Thu, 7 Feb 2002 18:24:47 -0500
Date: Thu, 7 Feb 2002 18:32:07 -0800 (PST)
Message-Id: <200202080232.SAA09372@morrowfield.home>
From: Tom Lord <lord@regexps.com>
To: linux-kernel@vger.kernel.org
CC: lm@bitmover.com, jaharkes@cs.cmu.edu
In-Reply-To: <20020207132558.D27932@work.bitmover.com> (message from Larry
	McVoy on Thu, 7 Feb 2002 13:25:58 -0800)
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207165035.GA28384@ravel.coda.cs.cmu.edu> <200202072306.PAA08272@morrowfield.home> <20020207132558.D27932@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




	lm@bitmover.com writes:

	An interesting experiment would be to take every kernel revision,
	including all the pre-patches, and import it into arch and report the
	resulting size of the repository and the time to generate each version
	of the tree from that repository.  

I agree.  This would also be an opportunity for tuning and debugging
and a giant leap towards deployment.


	I suspect that this will demonstrate the most serious issue
	that I have with the arch design.

>From what you go on to describe, I think your perceptions of the arch
design are slightly, but critically out-of-date.


       In essence arch isn't that different from RCS in that arch is
       fundamentally a diff&patch based system with all of the
       limitations that implies.  There are very good reasons that BK,
       ClearCase, Aide De Camp, and other high end systems, are *not*
       diff&patch based revision histories, they are weave based.

Arch is in two layers: The lower layer is a repository management
layer that is, as you say, diff&patch based.  The upper layer is a
work-space management layer that is based on keeping a library of
complete source trees for many revisions, with unmodified files shared
between those trees via hard links.  

The lower layer provides very compact archival of revisions,
repository transactions, the global name-space of revisions, and
distributed repositories.  The upper layer provides convenience and
speed.  By far, the second layer is not the most space efficient
approach: I'm sure that arch will lose if compared by that metric.
However, it is extremely convenient and well within the capacity of
cheap, modern storage.

Weave-based systems are a single layer approach with intermediate
characteristics.  They make a different set of space/time trade-offs
-- one that, as I see it, comes from a time (not very long ago) when
storage was much more expensive.  A weave-based system can provide
most of the speed of arch's second layer, but unless it is presented
as a file system, it lacks the convenience of being able to run
ordinary tools like `find', `grep', and `diff' on your past revisions.
With arch, you can use all of those standard tools and you can get a
copy of a past revision just as fast as your system can recursively
copy a tree.


	But most importantly, BK at least, has great merge tools.  At
	the end of the day, what most people spend their time on is
	merging.  Everything else is just accounting and how the
	system does that is interesting to the designers and noone
	else.  What users care about is how much time they spend
	merging.  It's technically impossible to get arch or CVS or
	RCS or any diff&patch based system to give you the same level
	of merge support.

I think this is just wrong.  Aside from the fancy merge operators
built-in to arch, arch's second layer makes the choice of merging
technologies largely orthogonal to the revision control system.

	Are _you_ going to send Tom $500?

If only it were that easy.  It isn't, is it? :-)

-t
