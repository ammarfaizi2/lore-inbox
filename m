Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUCMAsl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 19:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbUCMAsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 19:48:41 -0500
Received: from thunk.org ([140.239.227.29]:5007 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262909AbUCMAsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 19:48:39 -0500
Date: Fri, 12 Mar 2004 19:47:56 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>, torvalds@transmeta.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Dealing with swsusp vs. pmdisk
Message-ID: <20040313004756.GB5115@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
	torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
References: <20040312224645.GA326@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312224645.GA326@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 11:46:45PM +0100, Pavel Machek wrote:
> I don't really like having two implementations of same code in
> kernel. There are two ways to deal with it:
> 
> * remove pmdisk from kernel
>   + its easy
> 
> * remove swsusp from kernel, rename pmdisk to swsusp, fix all bugs
>   that were fixed in swsusp but not in pmdisk 
>   + people seem to like pmdisk code more
>   - will need some testing in -mm series
> 
> Which one do you prefer? I can do both...

2.6 is allegedly the stable kernel series, so if swsusp is the more
stable code base at this point, my vote would be to keep swsusp and
remove pmdisk from the kernel.  If someone wants to maintain a
separate BK-tree that contains pmdisk renamed to swsusp and fix all
the bugs, that's great.  On the other hand, there are a group of
people of are busy doing something very similar with swsusp2, and that
effort seems to have a fair number of people working on the patch and
testing it.  

So if we can somehow go from *three* idependent software suspend
implementations implementations to something less than three, and
increase the testing and effort devoting to remaining software suspend
code bases, this would be a good thing.

Pavel, what do you think of the swsusp2 patch, BTW?  My biggest
complaint about it is that since it's maintained outside of the
kernel, it's constantly behind about 0.75 revisions behind the latest
2.6 release.  The feature set of swsusp2, if they can ever get it
completely bugfree(tm) is certainly impressive.

						- Ted
