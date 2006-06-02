Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWFBJRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWFBJRd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 05:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWFBJRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 05:17:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:23371 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751351AbWFBJRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 05:17:32 -0400
X-IronPort-AV: i="4.05,202,1146466800"; 
   d="scan'208"; a="45904251:sNHT24055864"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "Con Kolivas" <kernel@kolivas.org>, <linux-kernel@vger.kernel.org>,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 02:17:32 -0700
Message-ID: <000001c68625$614f59a0$0c4ce984@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaGInBptJF7xR+mTtS/Qg4G8lEwOAAAVNsw
In-Reply-To: <447FFD35.9020909@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Friday, June 02, 2006 1:56 AM
> Chen, Kenneth W wrote:
> 
> > Ha, you beat me by one minute. It did cross my mind to use try lock there as
> > well, take a look at my version, I think I have a better inner loop.
> 
> Actually you *have* to use trylocks I think, because the current runqueue
> is already locked.

You are absolutely correct.  I forgot about the lock ordering.


> And why do we lock all siblings in the other case, for that matter? (not
> that it makes much difference except on niagara today).
> 
> Rolled up patch with everyone's changes attached.

What about the part in dependent_sleeper() being so bully and actively
resched other low priority sibling tasks?  I think it would be better
to just let the tasks running on sibling CPU to finish its current time
slice and then let the backoff logic to kick in.

- Ken
