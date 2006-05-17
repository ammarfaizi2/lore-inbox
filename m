Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWEQSnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWEQSnI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWEQSnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:43:07 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:14530 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750897AbWEQSnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:43:06 -0400
Subject: [RFC] [Patch 0/6] statistics infrastructure
From: Martin Peschke <mp3@de.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>,
       Chase Venters <chase.venters@clientec.com>,
       Keith Owens <kaos@ocs.com.au>, "Frank Ch. Eigler" <fche@redhat.com>,
       arjan@infradead.org, hch@infradead.org, ak@suse.de, akpm@osdl.org
Content-Type: text/plain
Date: Wed, 17 May 2006 20:42:54 +0200
Message-Id: <1147891374.3076.7.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sending again...

- patches should be fine now with regard to space-stuffing done
  by my former email client

- picked up lots of improvements (not all, though) suggested
  since yesterday

- omitting the final 2 patches of the series for the time being
  due to controversial use of sched_clock()

My patch series is a proposal for a generic implementation of statistics.
Envisioned exploiters include device drivers, and any other component.
It provides both a unified programming interface for exploiters as well
as a unified user interface. It comes with a set of disciplines that
implement various ways of data processing, like counters and histograms.

The recent rework addresses performance issues and memory footprint,
straightens some concepts out, streamlines the programming interface,
removes some weiredness from the user interface, reduces the amount of
code, and moves the exploitation according to last time's feedback.

A few more keywords for the reader's convenience:
based on per-cpu data; spinlock-free protection of data; observes
cpu-hot(un)plug for efficient memory use; tiny state machine for
switching-on, switching-off, releasing data etc.; configurable by users
at run-time; still sitting in debugfs; simple addition of other disciplines.

Good places to start reading code are:

   statistic_create(), statistic_remove()
   statistic_add(), statistic_inc()
   struct statistic_interface, struct statistic
   struct statistic_discipline, statistic_*_counter()
   statistic_transition()

I'd suggest you skip anything that looks like string manipulation, and
have a look at my humble attempt at a user interface once you are
familiar with the base function.

Looking forward to your comments.

	Martin


