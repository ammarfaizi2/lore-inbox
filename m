Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263020AbRFDXJB>; Mon, 4 Jun 2001 19:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbRFDXIv>; Mon, 4 Jun 2001 19:08:51 -0400
Received: from gateway.sequent.com ([192.148.1.10]:721 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S262804AbRFDXIr>; Mon, 4 Jun 2001 19:08:47 -0400
Date: Mon, 4 Jun 2001 16:08:37 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: linux-kernel@vger.kernel.org
Subject: reschedule_idle changes in ac kernels
Message-ID: <20010604160837.B15640@w-mikek2.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed the changes to reschedule_idle() in the 2.4.5-ac
kernel.  I suspect these are the changes made for:

o       Fix off by one on real time pre-emption in scheduler

I'm curious if anyone has ran any benchmarks before and after
applying this fix.

The reason I ask is that during the development of my multi-queue
scheduler, I 'accidently' changed reschedule_idle code to trigger
a preemption if preemption_goodness() was greater than 0, as
opposed to greater than 1.  I believe this is the same change made
to the ac kernel.  After this change, we saw a noticeable drop in
performance for some benchmarks.

The drop in performance I saw could have been the result of a
combination of the change, and my multi-queue scheduler.  However,
in any case aren't we now going to trigger more preemptions?

I understand that we need to make the fig to get the realtime
semantics correct,  but we also need to be aware of performance in
the non-realtime case.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
