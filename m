Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269077AbUJERZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269077AbUJERZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269100AbUJERZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:25:56 -0400
Received: from fmr04.intel.com ([143.183.121.6]:10419 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S269077AbUJERZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:25:35 -0400
Message-Id: <200410051724.i95HOs627803@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@redhat.com>, "Con Kolivas" <kernel@kolivas.org>
Cc: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
Subject: RE: bug in sched.c:activate_task()
Date: Tue, 5 Oct 2004 10:25:01 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSqqEli6RExtJ3bQte0JntDx1ykoQAVrRww
In-Reply-To: <Pine.LNX.4.58.0410050250580.4941@devserv.devel.redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Monday, October 04, 2004 11:55 PM
> On Tue, 5 Oct 2004, Con Kolivas wrote:
>
> > 	unsigned long long delta = now - next->timestamp;
> >
> > 	if (next->activated == 1)
> > 		delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
> >
> > is in schedule() before we update the timestamp, no?
>
> indeed ... so the patch is just random incorrect damage that happened to
> distrub the scheduler fixing some balancing problem. Kenneth, what
> precisely is the balancing problem you are seeing?

We are seeing truck load of move_task() which was originated from newly
idle load balance.  The problem is load balancing going nuts moving tons
of tasks around and what we are seeing is cache misses for the application
shots up to the roof and suffering from cache threshing.

- Ken


