Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUF3QQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUF3QQH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 12:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266754AbUF3QQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 12:16:02 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:50904 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S266763AbUF3QMq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 12:12:46 -0400
Message-Id: <200406301612.i5UGCdiw010913@localhost.localdomain>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK 
In-reply-to: Your message of "Wed, 30 Jun 2004 17:05:48 +0200."
             <20040630150548.GB28506@elte.hu> 
Date: Wed, 30 Jun 2004 12:12:39 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [141.152.253.159] at Wed, 30 Jun 2004 11:12:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>another question: do all JACK threads run at SCHED_FIFO, and do they all 
>have the same rt_priority value?

They don't all run SCHED_FIFO. Just two threads in the server (one is
a watchdog designed to prevent system lockups) and at least one in
each client (there may be more depending on what the client does, but
its not created by JACK and JACK doesn't know about it). The client
threads run at 1 level lower priority than the servers main thread,
and that runs 1 level lower than the watchdog.

but ...

>it seems part of the problem is that the setscheduler() calls 'succeed',
>but the policy is not changed to SCHED_FIFO. The question here is,
>are the correct PIDs used?

this has me thinking. one of the major changes with NPTL is that all
threads share the same PID. so how in the world do we ever set the
scheduling policy of a single thread (as opposed to something
identified by a pid_t) to SCHED_FIFO?

--p
