Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbWHADAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWHADAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 23:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWHADAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 23:00:43 -0400
Received: from thunk.org ([69.25.196.29]:26538 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030410AbWHADAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 23:00:42 -0400
Date: Mon, 31 Jul 2006 23:00:05 -0400
From: Theodore Tso <tytso@mit.edu>
To: David Masover <ninja@slaphack.com>
Cc: Nate Diller <nate.diller@gmail.com>, David Lang <dlang@digitalinsight.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Message-ID: <20060801030005.GA1987@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	David Masover <ninja@slaphack.com>,
	Nate Diller <nate.diller@gmail.com>,
	David Lang <dlang@digitalinsight.com>,
	Adrian Ulrich <reiser4@blinkenlights.ch>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
	reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
References: <200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl> <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch> <44CE7C31.5090402@gmx.de> <5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com> <Pine.LNX.4.63.0607311621360.14674@qynat.qvtvafvgr.pbz> <5c49b0ed0607311650j4b86d0c3h853578f58db16140@mail.gmail.com> <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz> <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com> <20060801010215.GA24946@merlin.emma.line.org> <44CEAEF4.9070100@slaphack.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CEAEF4.9070100@slaphack.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 08:31:32PM -0500, David Masover wrote:
> So you use a repacker.  Nice thing about a repacker is, everyone has 
> downtime.  Better to plan to be a little sluggish when you'll have 
> 1/10th or 1/50th of the users than be MUCH slower all the time.

Actually, that's a problem with log-structured filesystems in general.
There are quite a few real-life workloads where you *don't* have
downtime.  The thing is, in a global economy, you move from the
London/European stock exchanges, to the New York/US exchanges, to the
Asian exchanges, with little to no downtime available.  In addition,
people have been getting more sophisticated with workload
consolidation tricks so that you use your "downtime" for other
applications (either to service other parts of the world, or to do
daily summaries, 3-d frame rendering at animation companies, etc.)  So
the assumption that there will always be time to run the repacker is a
dangerous one.

The problem is that many benchmarks (such as taring and untaring the
kernel sources in reiser4 sort order) are overly simplistic, in that
they don't really reflect how people use the filesystem in real life.
(How many times can you guarantee that files will be written in the
precise hash/tree order so that the filesystem gets the best possible
time?)  A more subtle version of this problem happens for filesystems
where their performance degrades dramatically over-time without a
repacker.  If the benchmark doesn't take into account the need for
repacker, or if the repacker is disabled or fails to run during the
benchmark, the filesystem are in effect "cheating" on the benchmark
because there is critical work which is necessary for the long-term
health of the filesystem which is getting deferred until after the
benchmark has finished measuring the performance of the system under
test.

This sort of marketing benchmarks ("lies, d*mn lies, and benchmarks")
may be useful for trying to scam mainline acceptance of the filesystem
code, or to make pretty graphs that make log-structured filesystems
look good on Usenix papers, but despite the fact that huge numbers of
papers were written about the lfs filesystem two decades ago, it never
was used in real-life by any of the commercial Unix systems.  This
wasn't an accident, and it wasn't due to a secret conspiracy of BSD
fast filesystem hackers keeping people from using lfs.  No, the BSD
lfs died on its own merits....

						- Ted
