Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318145AbSHIEjJ>; Fri, 9 Aug 2002 00:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318146AbSHIEjJ>; Fri, 9 Aug 2002 00:39:09 -0400
Received: from holomorphy.com ([66.224.33.161]:21148 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318145AbSHIEjI>;
	Fri, 9 Aug 2002 00:39:08 -0400
Date: Thu, 8 Aug 2002 21:42:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Paul Larson <plars@austin.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, davej@suse.de, frankeh@us.ibm.com,
       andrea@suse.de
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
Message-ID: <20020809044209.GH6256@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrew Morton <akpm@zip.com.au>, Paul Larson <plars@austin.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, davej@suse.de,
	frankeh@us.ibm.com, andrea@suse.de
References: <3D51A7DD.A4F7C5E4@zip.com.au> <Pine.LNX.4.44.0208081312330.8705-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208081312330.8705-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 01:24:35PM -0700, Linus Torvalds wrote:
> So if you really want to take this approach, you need to count the uses of
> "pid X", and free the bitmap entry only when that count goes to zero. I
> see no such logic in Bill Irwin's code, only a comment about last use
> (which doesn't explain how to notice that last use).
> Without that per-pid-count thing clarified, I don't think the (otherwise
> fairly straightforward) approach of Bills really flies.

One big thing to bear in mind is that it is actually part of a much
larger work, one which is not centered around get_pid(), and which is
not yet ready for inclusion, or even widespread review. So please give
me time to finish it, and defer judgment until it is complete.

(1) akpm did not post the full patch, only the "after" picture of one file.
(2) The per-id accounting is properly implemented, with caveats
	unrelated to the general accounting method. Yes, I am well
	aware of the need to be notified on release at points other
	than exit(), and I have implemented that notification.
(3) The patch as it is intended to be is largely a tty and job control
	cleanup. get_pid() changes are required as the central feature
	is the removal of the list of all tasks, upon which the current
	get_pid() relies.
(4) pid hashing actually creates idtag objects for something guaranteed
	to be unique. This is so stupid I consider it a bug.
(5) The patch is not yet finished.

Please defer judgment until I am ready to present as a finished work what
is now a work in progress and barely if even out of the "debug" phase.

The last fully-ported version of the patch, which was originally put
on-line only to facilitate communication with reviewers and
contributors, prior to the initial release (and by a very large margin)
is available from the following URL:

ftp://ftp.kernel.org/pub/linux/kernel/people/wli/task_mgmt/for_each_task-2.5.23-1

This patch does not contain a complete implementation of what I would
like to present when I feel ready to submit it.

While I thought I came up with something "nifty" in the way of a
get_pid() as a result of this work, its primary focus is really to
clean up tty and job control code. As it stands now, it does very
little in the way of cleaning it up, only converting it to use the new
infrastructure as a replacement for for_each_task() in the most
straightforward and braindead ways imaginable. Several bugs are known
to exist, but the full patch with all fixes has not yet been ported to
current mainline, and I won't have time to devote to it for some time.
This patch needs much further work, and that work is not yet finished.
Please defer judgment until I can actually finish it. This will
probably have to wait until 2.7 or even later.


Thanks,
Bill
