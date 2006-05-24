Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbWEXM2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbWEXM2B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 08:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWEXM2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 08:28:01 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:17587 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932685AbWEXM2A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 08:28:00 -0400
Subject: [Patch 0/6] statistics infrastructure
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 24 May 2006 14:27:52 +0200
Message-Id: <1148473672.2934.7.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Patches are against 2.6.17-rc4-git12. Only change since last time
is a beautification of the timestamp code (now using NSEC_PER_SEC etc.)

	Martin



My patch series is a proposal for a generic implementation of statistics.
Envisioned exploiters include device drivers, and any other component.
It provides both a unified programming interface for exploiters as well
as a unified user interface. It comes with a set of disciplines that
implement various ways of data processing, like counters and histograms.

The recent rework addresses performance issues and memory footprint,
straightens some concepts out, streamlines the programming interface,
removes some weiredness from the user interface, and reduces the
amount of code.

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


