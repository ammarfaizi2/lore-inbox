Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTKHScM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 13:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTKHScM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 13:32:12 -0500
Received: from thunk.org ([140.239.227.29]:49056 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261959AbTKHScL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 13:32:11 -0500
Date: Sat, 8 Nov 2003 11:44:10 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Weird ext2 problem in 2.4.18 (redhat)
Message-ID: <20031108164410.GB2955@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
References: <20031108063341.GA8349@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031108063341.GA8349@work.bitmover.com>
User-Agent: Mutt/1.5.4i
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

On Fri, Nov 07, 2003 at 10:33:41PM -0800, Larry McVoy wrote:
> The BitKeeper source tree looks like
> 
> 	BitKeeper/  SCCS/  doc/  man/  src/
> 
> I have a repository where it looks like
> 
> 	 src/  BitKeeper/  PENDING/  RELEASE-NOTES  SCCS/  doc/  man/  src/
> 
> That first src/ is actually " src/" and it has some rather strange behaviour.
> It's a different directory inode than "src/" but if I create a file in " src/"
> it shows up in "src/" and vice versa.
> 
> Hey, neato, it gets weirder.  I went to go run an example and now most of
> the files in " src/" are gone, most but not all.

Sounds like there is a two directory entries with the same name in the
same directory.  This can cuase severe confusion since the kernel
assumes that this will never happen.  Depending on which one gets
found first, and what is cached in the dentry cache, you'll get one
inode or the other.

E2fsck doesn't normally notice these sorts of inconsistencies, since
it takes too much time and memory to look for duplicate entries.  If
you optimize directories using "e2fsck -fD", it will find and offer to
rename directory entires with a duplicated name.

If you notice the problem, you can also go in directly with debugfs
and rename the errant directory entry directly.

						- Ted
