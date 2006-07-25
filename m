Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWGYEtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWGYEtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 00:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWGYEtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 00:49:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:30593 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932444AbWGYEtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 00:49:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pNqFpwVrllg8Jg+haY4ytm5WoX8IFsHBe2ZcXpn9q8anR8wmnwaMrm7xXigV6PGNEHdD3CQa/pWg30RiGMNjGUzmW6E/eBX75tE3MXPnEzBfDRdzkyIkD1CbFVJNPcxNagVezrD5I1xuSa7Y4t333uR38DColWOLVoSfHkNZ2lI=
Message-ID: <bda6d13a0607242149j4f1492ag47bd8e3e1f0607da@mail.gmail.com>
Date: Mon, 24 Jul 2006 21:49:01 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: what is necessary for directory hard links
In-Reply-To: <200607241822.k6OIMJcY014229@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6ARGK-19L-5@gated-at.bofh.it> <6B8og-1iB-17@gated-at.bofh.it>
	 <E1G4Kpi-0001Os-AK@be1.lrz>
	 <bda6d13a0607221113s7e583492x783651eb9613b87f@mail.gmail.com>
	 <17604.27801.796726.164279@gargle.gargle.HOWL>
	 <200607240725.k6O7PTp1012347@turing-police.cc.vt.edu>
	 <bda6d13a0607240921x78049eefraae775e4c6c0ba5c@mail.gmail.com>
	 <200607241822.k6OIMJcY014229@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Mon, 24 Jul 2006 09:21:04 PDT, Joshua Hudson said:
> > On 7/24/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
>
> > Actually, I walk from the source inode down to try to find the
> > target inode. If not found, this is not attempting to create a loop.
>
> The problem is that the "target inode" may not be the one obviously causing the
> loop - you may be trying to link a directory into a/b/c, while the loop
> is caused by a link from a/b/c/d/e/f/g back up to someplace.
>
> Consider:
[case of 3^4 directories ]
> Yes, you have to search *every* directory under x, y, and z.
With a mesh graph like that one, you are right.  Rather like my
test cases to see if the  loop-detection algorithm is working.

> And this is an artificially small
> directory tree.  Think about a /usr/src/ that has 4 or 5 linux-kernel
> trees in it, with some 1,650 directories per tree...
Interesting case.

>
> > Should be obvious that the average case is much less than the
> > whole tree.
>
> "The average case" is the one where the feature isn't used.  When you
> actually *use* it, you get "not average case" behavior - not a good sign.
>
My use cases were generally about creating links at the twig level.
In my consideration, there would be two or more topical trees arranged
by different criteria, and they would bottom out at the
topics, which are directories that hold a number of documents.

A document might be a single file, a few files together, or a
directory that contains a few files that should alwas be together. I
suppose that an entire source tree could be considered one document,
and there lies the flaw.

This system is an attempt to replace a system of hard links to files
that didn't work because certain MS applications use rename and create
when saving files. The filesystem is intended to be
exported over smbfs. It is still very-much a single-user scheme,
which is why the bad worst case didn't really concern me.

> >
> > mv /a/b/c/d ../../w/z/b is implemented as this in the filesystem:
> > ln /a/b/c/d ../../w/z/b && rm /a/b/c/d
> >
> > So what it's going to do is try to find z under /a/b/c/d.
>
> Even if that's sufficient (which it isn't), it's going to be painful to lock
> the filesystem for 20 or 30 seconds while you walk everything to make sure
> there's no problem.

Maybe someday I'll work out a system by which much less is locked.
Conceptually, all that is requred to lock for the algorithm
to work is creating hard-links to directories and renaming directories
cross-directory.

> (which it isn't)
Counterexample? I should swear that any cycle created by rename must
pass through the new parent into the victim and back to the new
parent.
