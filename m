Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbUJYQgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbUJYQgM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUJYQFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:05:39 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:33164 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262038AbUJYQEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:04:06 -0400
Message-ID: <001c01c4baac$056ae7d0$6700a8c0@comcast.net>
From: "John Hawkes" <hawkes@sgi.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: "John Hawkes" <hawkes@google.engr.sgi.com>,
       "John Hawkes" <hawkes@oss.sgi.com>, "Ingo Molnar" <mingo@elte.hu>,
       <jbarnes@sgi.com>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
References: <200410201936.i9KJa4FF026174@oss.sgi.com> <200410221938.MAA52152@google.engr.sgi.com> <00ee01c4b870$030b80f0$6700a8c0@comcast.net> <4179DDA3.1020405@yahoo.com.au>
Subject: Re: [PATCH, 2.6.9] improved load_balance() tolerance for pinned tasks
Date: Mon, 25 Oct 2004 09:02:21 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Nick Piggin" <nickpiggin@yahoo.com.au>
> > From: "John Hawkes" <hawkes@google.engr.sgi.com>
> > Actually, there is another related problem that arises in
> > active_load_balance() with a runqueue that holds hundreds of pinned
processes.
> > I'm seeing a migration_thread perpetually consuming 70% of its CPU.
>
> That's what I was worried about, but in your most recent
> patch you just sent, the all_pinned path should skip over
> the active load balance completely... basically it shouldn't
> be running at all, and if it is then it is a bug I think?

To reiterate:  this is probably reproducible on smaller SMP systems, too.
Just do a 'runon' (using sys_sched_setaffinity) of ~200 (or more) small
computebound processes on a single CPU.

My patch -- that has load_balance() skip over (busiest->active_balance = 1)
trigger that starts up active_load_balance() -- does seem to reduce the
frequency of bursts of long-running activity of the migration thread, but
those burst of activity are still there, with migration_thread consuming
75-95% of its CPU for several seconds (as observed by 'top').  I have not yet
determined what's happening.  It might be an artifact of how long it takes to
do those 'runon' startups of the computebound processes.

John Hawkes

