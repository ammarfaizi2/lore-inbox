Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbTBTTKN>; Thu, 20 Feb 2003 14:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266840AbTBTTKN>; Thu, 20 Feb 2003 14:10:13 -0500
Received: from [24.77.48.240] ([24.77.48.240]:65125 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S266839AbTBTTKM>;
	Thu, 20 Feb 2003 14:10:12 -0500
Date: Thu, 20 Feb 2003 11:20:18 -0800 (PST)
From: Michael Hayes <mike@aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: Strange comment in sched.c
Message-ID: <Pine.LNX.4.44.0302201116260.16095-100000@aiinc.aiinc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This comment at sched.c:843 is a bit confusing:

 * We fend off statistical fluctuations in runqueue lengths by
 * saving the runqueue length during the previous load-balancing
 * operation and using the smaller one the current and saved lengths.

First, it's ungrammatical ("...the smaller one the...").  Second,
the code immediately following it seems to be choosing the _larger_
of the two values, not the smaller:

if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
	nr_running = this_rq->nr_running;
else
	nr_running = this_rq->prev_nr_running[this_cpu];

