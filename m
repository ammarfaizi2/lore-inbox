Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWFBWH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWFBWH2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 18:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWFBWH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 18:07:28 -0400
Received: from mail30.syd.optusnet.com.au ([211.29.133.193]:1452 "EHLO
	mail30.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751229AbWFBWH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 18:07:27 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Sat, 3 Jun 2006 08:04:07 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
References: <000201c6868f$14ddbfc0$df34030a@amr.corp.intel.com>
In-Reply-To: <000201c6868f$14ddbfc0$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606030804.08382.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 June 2006 07:54, Chen, Kenneth W wrote:
> Con Kolivas wrote on Friday, June 02, 2006 6:17 AM
> > Thinking some more on this it is also clear that the concept of
> > per_cpu_gain for smt is basically wrong once we get beyond straight
> > forward 2 thread hyperthreading. If we have more than 2 thread units per
> > physical core, the per cpu gain per logical core will decrease the more
> > threads are running on it. While it's always been obvious the gain per
> > logical core is entirely dependant on the type of workload and wont be a
> > simple 25% increase in cpu power, it is clear that even if we assume an
> > "overall" increase in cpu for each logical core added, there will be some
> > non linear function relating power increase to thread units used. :-|
>
> In the context of having more than 2 sibling CPUs in a domain, doesn't the
> current code also suffer from thunder hurd problem as well? When high
> priority task goes to sleep, it will wake up *all* sibling sleepers and
> then they will all fight for CPU resource, but potentially only one will
> win?

Yes. The smt nice code was never designed with that many threads in mind. This 
is why I'm bringing it up for discussion.

-- 
-ck
