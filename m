Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWFAX5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWFAX5Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWFAX5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:57:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:57408 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750997AbWFAX5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:57:16 -0400
X-IronPort-AV: i="4.05,199,1146466800"; 
   d="scan'208"; a="45733228:sNHT45878798"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Chris Mason'" <mason@suse.com>, "Con Kolivas" <kernel@kolivas.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Thu, 1 Jun 2006 16:57:15 -0700
Message-ID: <000101c685d7$1bc84390$d234030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaFztNZBnptriJrRJaMD+CxOww00QABwu9Q
In-Reply-To: <200606011855.38110.mason@suse.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote on Thursday, June 01, 2006 3:56 PM
> Hello everyone,
> 
> Recent benchmarks showed some performance regressions between 2.6.16 and 
> 2.6.5.  We tracked down one of the regressions to lock contention in schedule 
> heavy workloads (~70,000 context switches per second)
> 
> kernel/sched.c:dependent_sleeper() was responsible for most of the lock 
> contention, hammering on the run queue locks.  The patch below is more of 
> a discussion point than a suggested fix (although it does reduce lock 
> contention significantly).  The dependent_sleeper code looks very expensive 
> to me, especially for using a spinlock to bounce control between two different 
> siblings in the same cpu.


Yeah, this also sort of echo a recent discovery on one of our benchmarks
that schedule() is red hot in the kernel.  I was just scratching my head
not sure what's going on.  This dependent_sleeper could be the culprit
considering it is called almost at every context switch.  I don't think
we are hitting on lock contention, but by the large amount of code it
executes.  It really needs to be cut down ....

- Ken

