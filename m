Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbTFBHXY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 03:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbTFBHXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 03:23:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55990 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261989AbTFBHXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 03:23:23 -0400
Date: Mon, 2 Jun 2003 09:36:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@digeo.com>
Cc: Tom Sightler <ttsig@tuxyturvy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
In-Reply-To: <20030531214520.5b7facf4.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0306020927420.2970-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 31 May 2003, Andrew Morton wrote:

> >                               [...] Upon looking a little further it
> >  seemed that the kernel was dynamically boosting the priority of the
> >  process much higher than it probably should be, in the end, not leaving
> >  enough CPU for playing the sounds without skipping.
> 
> Yes, it seems that too many real-world applications are accidentally
> triggering this problem.

no, the problem is exactly the opposite. Here's the key observation:

> the problem seemed to be caused by the fact that the pluginserver (wine)  
> was using 100% of the CPU. I simply reniced this process to -10 and
> everything started working fine.

the kernel has detected this process to be a CPU-hog - and indeed the
traces and the above description all say that it really is a CPU hog.

by renicing it to -10 it gets super-attention from the scheduler, so it
can be a CPU hog _and_ create sound.

this is analogous to the 'game problem'. Games too tend to be CPU hogs,
and if anything else is running on the system, they might be hurt and see
longer latencies in getting scheduled. By renicing them the user
(sysadmin) signals towards the kernel that despite these application's CPU
usage pattern, they should get extra attention.

	Ingo

