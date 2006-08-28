Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWH1MxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWH1MxO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 08:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWH1MxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 08:53:14 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:18324 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750766AbWH1MxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 08:53:13 -0400
Date: Mon, 28 Aug 2006 18:22:41 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Kirill Korotaev <dev@sw.ru>, Ingo Molnar <mingo@elte.hu>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Balbir Singh <balbir@in.ibm.com>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: Re: [PATCH 1/7] CPU controller V1 - split runqueue
Message-ID: <20060828125241.GA30644@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com> <20060820174147.GB13917@in.ibm.com> <44EEEF28.4080707@sw.ru> <20060828033331.GA25119@in.ibm.com> <44F2A62C.9090609@sw.ru> <20060828110330.GA30090@in.ibm.com> <44F2E216.7090300@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F2E216.7090300@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 10:31:18PM +1000, Nick Piggin wrote:
> I still haven't had much time to look at the implementation, but this
> design seems cleanest I've considered, IMO.
> 
> Of course I would really hope we don't need any special casing in the
> SMP balancing (which may be the tricky part). However hopefully if
> things don't work well in that department, they can be made to by
> improving the core code to be more general rather than special casing.
> 
> Do you have a better (/another) idea for the design?

I dont' know if it is a better idea - but I have been trying to
experiment with some token-based system where task-groups run until
exhausted out of their tokens. Of course, this will be work-conserving
in the sense that expired task-groups continue running if there arent
others who want to use their share. Token are renewed at periodic
intervals. I believe that is how vserver scheduler works (though havent
looked at their code).

And I was thinking of using something similar to smpnice for
load-balance purposes.

The main point here is that scheduling next-task-group decision is local
to each CPU (very similar to how next-task is picked up currently), with
some load-balance code expected to balance tasks/task-groups across all
CPUs.

In what Kirill is proposing, this "scheduling next-task-group decision"
on each CPU perhaps takes a global view and because of the
physical/virtual CPU separation, any CPU can be running any other CPU's
tasks (smp_processor_id/get_cpu etc now returning virtual CPU number rather than
the actual CPU on which they are running). Kirill is that description correct?


-- 
Regards,
vatsa
