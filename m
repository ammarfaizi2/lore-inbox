Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVESL4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVESL4W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 07:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVESL4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 07:56:22 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:58054 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262445AbVESL4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 07:56:13 -0400
Subject: Re: Resent: BUG in RT 45-01 when RT program dumps core
From: Steven Rostedt <rostedt@goodmis.org>
To: kus Kusche Klaus <kus@keba.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323212@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F367323212@MAILIT.keba.co.at>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 19 May 2005 07:56:03 -0400
Message-Id: <1116503763.15866.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 08:36 +0200, kus Kusche Klaus wrote:
> Quoting my mail from Apr 11th (received no response up to now):

Sorry, I must have missed it, I try to keep up on all mail associated to
Ingo's RT kernel. Including Ingo on the list is the right thing to do.

> > When a process running with RT priority dumps core,
> > I get the following BUG:
> > 
> > Apr 11 13:44:23 OF455 kern.err kernel: BUG: rtc2:833 RT task 
> > yield()-ing!

This is a check that we have to flag when a RT task calls yield.  This
in itself may not really be a bug, but it can be. There's places in the
kernel that call yield to wait for a bit to clear or a lock to become
unlock (doesn't grab it directly to prevent deadlocking).  This may be
OK with non RT tasks, since other tasks will get a chance to run. But
with RT tasks, a yield won't yield to any task with less priority than
the RT task. So if the RT task is yielding to let a lower priority task
do something it needs, it will in effect deadlock the system for all
tasks lower in priority than itself.

> This is still absolutely reproducable, in RT 7.47-01,
> with slight variations in the stack trace.
> 
> Is this something to worry about?

I'll take a look into it.


Ingo,

Did you get my patch to fix the kstop_machine yielding problem?

-- Steve


