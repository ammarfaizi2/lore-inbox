Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161236AbWHDOrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161236AbWHDOrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161246AbWHDOrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:47:55 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:53453 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161244AbWHDOry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:47:54 -0400
Date: Fri, 4 Aug 2006 20:21:58 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Balbir Singh <balbir@in.ibm.com>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [ RFC, PATCH 1/5 ] CPU controller - base changes
Message-ID: <20060804145158.GA29850@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060804050753.GD27194@in.ibm.com> <20060804050932.GE27194@in.ibm.com> <44D35AD8.2090506@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D35AD8.2090506@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 06:34:00PM +0400, Kirill Korotaev wrote:
> Srivatsa,
> 
> AFAICS, you wanted to go the way we used in OpenVZ - 2-level scheduling.
> However, you don't do any process balancing between runqueues taking into 
> account
> other groups.
> In many cases you will simply endup with tasks collected on the same 
> physical
> CPU and poor performance. I'm not talking about fairness (proportinal CPU 
> scheduling).

> I don't think it is possible to make any estimations for QoS of such a 
> scheduler.

Yes, the patch (as mentioned earlier) does not address SMP correctness
_yet_. That will need to be addressed definitely for an acceptable
controller. My thought was we could try the smpnice approach (which
attempts to deal with the same problem albeit for niced tasks) and
see how far we can go. I am planning to work on it next.

> What do you think about a full runqueue virtualization, so that
> first level CPU scheduler could select task-group on any basis and then
> arbitrary runqueue was selected for running?

That may solve the load balance problem nicely. But isnt there some cost
to be paid for it (like lock contention on the virtual runqueues)?

> P.S. BTW, this patch doesn't allow hierarchy in CPU controler.

Do we want heriarchy?


-- 
Regards,
vatsa
