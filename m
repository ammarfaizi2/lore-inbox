Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131625AbRCSWZ2>; Mon, 19 Mar 2001 17:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131631AbRCSWZS>; Mon, 19 Mar 2001 17:25:18 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:35832 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131625AbRCSWZP>; Mon, 19 Mar 2001 17:25:15 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103192223.f2JMNt717802@webber.adilger.int>
Subject: Re: [CHECKER] question about functions that can fail
In-Reply-To: <200103192149.NAA29973@csl.Stanford.EDU> from Dawson Engler at "Mar
 19, 2001 01:49:01 pm"
To: Dawson Engler <engler@csl.stanford.edu>
Date: Mon, 19 Mar 2001 15:23:54 -0700 (MST)
CC: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson writes:
> right now we are trying to derive which functions can "reasonably" fail
> by examining all call sites and recording the number of times functions
> are checked vs not checked.

First of all, thanks for this interesting work you are doing.  Pre-emptive
bug squashing is great.  Probably saved many man-years of grief for people
who are having intermittent problems, or have uncommon hardware/configuration.

> I've included the most egregious cases of check/not checked:
> 
>                            parse_options	:	14	:	1:

It appears you are not making a distinction between static functions and
global functions.  The parse_options function is local to ext2, but since
many filesystem writers look at ext2 for guidance, they often have functions
with similar names.  It looks like parse_options is one of the common ones.

That said, I'm guessing the 1 time the return value isn't checked is a bug.
It appears to be in fs/proc/inode.c, and the parse_options() there _does_
return 1 on error (unknown mount option), so we _should_ probably fail
mounting /proc in that case.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
