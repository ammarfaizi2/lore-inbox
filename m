Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270068AbUJHRX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270068AbUJHRX0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270069AbUJHRX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:23:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:36022 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270068AbUJHRVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:21:36 -0400
Date: Fri, 8 Oct 2004 10:19:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: shobhit@calsoftinc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Performance of del_single_shot_timer_sync
Message-Id: <20041008101949.49cda1a8.akpm@osdl.org>
In-Reply-To: <1097242659.11717.483.camel@kuber>
References: <1097242659.11717.483.camel@kuber>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shobhit dayal <shobhit@calsoftinc.com> wrote:
>
> Andrew Morton wrote:
> > By how much?  (CPU load, overall runtime, etc)
> > 
> > It's a bit odd to have an expired-timer-intensive workload.  Presumably
> > postgres has some short-lived nanosleep or select-based polling loop in
> > there which isn't doing much.
> 
> I am running this load on a numa hardware so I profile the kernel by logging
> functions that cause remote node memory access. I generate a final log
> that shows functions that cause remote memory accesses greater that 0.5%
> of all remote memory access on the system.
> 
> del_timer_sync was responsible for about 2% of all remote memory
> accesses on the system and came up as part of the top 10 functions who
> were doing this. On top was schedule(7.52%) followed by
> default_wake_function(2.79%). Rest every one in the top 10 were
> around the range of 2%.
> 
> After the patch it never came up in the logs again( so less than 0.5% of
> all faulting eip's).
> 

And what is the overall improvement from the del_timer_sync speedup patch? 
I mean: overall runtime and CPU time improvements for a
relatively-real-world benchmark?
