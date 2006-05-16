Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWEPRqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWEPRqq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWEPRqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:46:13 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:30000 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932397AbWEPRof
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:44:35 -0400
Message-ID: <446A0F77.70202@de.ibm.com>
Date: Tue, 16 May 2006 19:44:23 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, ak@suse.de, hch@infradead.org, arjan@infradead.org,
       James.Smart@Emulex.Com, James.Bottomley@SteelEye.com
Subject: [RFC] [Patch 0/8] statistics infrastructure
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This is a sequel. What happened in the last season:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113458576022747&w=2)

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


