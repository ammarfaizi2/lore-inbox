Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVDCXIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVDCXIv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 19:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVDCXIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 19:08:51 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:41350 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261952AbVDCXIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 19:08:43 -0400
Subject: Re: sched /HT processor
From: Steven Rostedt <rostedt@goodmis.org>
To: Arun Srinivas <getarunsri@hotmail.com>
Cc: juhl-lkml@dif.dk, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <BAY10-F21A89B2521BD98E6C239C2D93A0@phx.gbl>
References: <BAY10-F21A89B2521BD98E6C239C2D93A0@phx.gbl>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sun, 03 Apr 2005 19:08:06 -0400
Message-Id: <1112569686.27149.138.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 04:22 +0530, Arun Srinivas wrote:
> Thanks. yes, a reschedule may not take place after a ms, if the currently 
> running task cannot be preempted by another task.
> 
> (1) But, can a reschedule happen within a millisec (or once a process is 
> scheduled can schedule() be called before the next millisec.) ?
> 

Yes.  For example: a high priority task may be waiting for some IO to
come in. Right after the normal timer interrupt scheduled another task,
the IO may come in and wake the high priority process up. This process
will preempt the other task right away. (ie. less than 1 ms).

> 2) Also in case argument (1) is not true, and I want rescheduling to be done 
> (i.e., schedule() called) in less than 1 ms , can I directly change the HZ 
> value in <asm-i386/param.h> and recompile my kernel so that my timer 
> interrupt will occur frequently?
> 

Well, 1) is true, but you can also increase HZ over 1000 if you like,
but that will usually cause more overhead, since, although a schedule
may not take place every HZ, a timer interrupt will.

-- Steve


