Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTKIP6m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 10:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbTKIP6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 10:58:42 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:31387 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262601AbTKIP6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 10:58:40 -0500
Date: Sun, 09 Nov 2003 07:58:19 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Fix find busiest queue 2.6.0-test9
Message-ID: <122840000.1068393498@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0311090747110.12198-100000@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.44.0311090747110.12198-100000@bigblue.dev.mdolabs.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I ran it on the 16-way - no difference in performance. If the code is 
>> correct as was before (and I agree, it seems it was), perhaps it's just
>> in need of a big fat comment to explain the confusion? ;-)
> 
> Ingo already dropped a fat comment ;) This is the relevant part:
> 
>  * We fend off statistical fluctuations in runqueue lengths by
>  * saving the runqueue length during the previous load-balancing
>  * operation and using the smaller one the current and saved lengths.

I think the confusing bit is this:

this_rq->prev_cpu_load[i] = rq_src->nr_running;

where "this_rq->prev_cpu_load[i]" doesn't intuitively look like what it
means ;-) Even just 's/i/cpu/' would help a bit, or something (like 
wrapping it in macros). Seems it is correct as was though - thanks for 
explaining it.

M.

