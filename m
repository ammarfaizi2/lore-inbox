Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268414AbTCFV47>; Thu, 6 Mar 2003 16:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268435AbTCFV47>; Thu, 6 Mar 2003 16:56:59 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:42768
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S268414AbTCFV45>; Thu, 6 Mar 2003 16:56:57 -0500
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
From: Robert Love <rml@tech9.net>
To: Martin Waitz <tali@admingilde.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20030306220307.GA1326@admingilde.org>
References: <20030228202555.4391bf87.akpm@digeo.com>
	 <Pine.LNX.4.44.0303051910380.1429-100000@home.transmeta.com>
	 <20030306220307.GA1326@admingilde.org>
Content-Type: text/plain
Organization: 
Message-Id: <1046988457.715.37.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 06 Mar 2003 17:07:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 17:03, Martin Waitz wrote:

> RE: the patch, i think using sleep_avg is a wrong metric from the
> beginning.

Eh?  It is as close to a heuristic of interactivity as I can think of.

> in addition, timeslices should be shortest for high priority processes
> (depending on dynamic prio, not static)

No, they should be longer.  In some cases they should be nearly
infinitely long (which is sort of what we do with the reinsertion into
the active array for highly interactive tasks).  We want interactive
tasks to always be able to run.

You may think they need shorter timeslice because they are I/O-bound. 
Keep in mind they need not _use_ all their timeslice in one go, and
having a large timeslice ensures they have timeslice available when they
wake up and need to run.

	Robert Love

