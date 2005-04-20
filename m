Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVDTJK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVDTJK4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 05:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVDTJKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 05:10:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:24786 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261484AbVDTJKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 05:10:39 -0400
Date: Wed, 20 Apr 2005 14:41:25 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: george@mvista.com, nickpiggin@yahoo.com.au, mingo@elte.hu,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: VST and Sched Load Balance
Message-ID: <20050420091125.GB20793@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050407124629.GA17268@in.ibm.com> <29495f1d0504190907234a0d1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d0504190907234a0d1d@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 09:07:49AM -0700, Nish Aravamudan wrote:
> > +                       if (jiffies - sd1->last_balance >= interval) {


> Sorry for the late reply, but shouldn't this jiffies comparison be
> done with time_after() or time_before()?

I think it is not needed. The check should be able to handle overflow case also.

This probably assumes that you don't sleep longer than (2e32 - 1) jiffies
(which is ~1193 hrs). Current VST implementation let us sleep way less than that
limit (~896 ms) since it uses 32-bit number for sampling TSC. When it is
upgraded to use 64-bit number, we may have to ensure that this limit (1193 hrs)
is not exceeded.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
