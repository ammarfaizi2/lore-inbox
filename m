Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWFBJbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWFBJbM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 05:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWFBJbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 05:31:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:53385 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751359AbWFBJbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 05:31:12 -0400
X-IronPort-AV: i="4.05,203,1146466800"; 
   d="scan'208"; a="45908350:sNHT15395079"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, <linux-kernel@vger.kernel.org>,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 02:31:09 -0700
Message-ID: <000101c68627$4866eff0$0c4ce984@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaGJnbWPvqE0O4vQaC+qH1a0W6JgQAACKrA
In-Reply-To: <200606021925.06089.kernel@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Friday, June 02, 2006 2:25 AM
> On Friday 02 June 2006 19:17, Chen, Kenneth W wrote:
> > What about the part in dependent_sleeper() being so bully and actively
> > resched other low priority sibling tasks?  I think it would be better
> > to just let the tasks running on sibling CPU to finish its current time
> > slice and then let the backoff logic to kick in.
> 
> That would defeat the purpose of smt nice if the higher priority task starts 
> after the lower priority task is running on its sibling cpu.

But only for the duration of lower priority tasks' time slice.  When lower
priority tasks time slice is used up, a resched is force from scheduler_tick(),
isn't it?  And at that time, it is delayed to run because of smt_nice.  You are
saying user can't tolerate that short period of time that CPU resource is
shared?  It's hard to believe.

- Ken
