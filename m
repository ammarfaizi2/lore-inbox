Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWESQIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWESQIB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 12:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWESQIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 12:08:00 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:58580 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932363AbWESQIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 12:08:00 -0400
Subject: [Patch 0/6] statistics infrastructure
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 19 May 2006 18:07:56 +0200
Message-Id: <1148054876.2974.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.

Changes since I have posted these patches last time:

- improvements as suggested on lkml
  (documentation, comments, coding style, etc.)

- fixed race in statistic_add()/statistic_inc()
  with regard to releasing statistics



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

Martin



