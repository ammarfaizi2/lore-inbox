Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268854AbUJEHA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268854AbUJEHA3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 03:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268860AbUJEHA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 03:00:28 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:24261 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268854AbUJEG7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 02:59:49 -0400
References: <200410050216.i952Gb620657@unix-os.sc.intel.com> <Pine.LNX.4.58.0410050229380.31508@devserv.devel.redhat.com> <cone.1096958170.135056.10082.502@pc.kolivas.org> <Pine.LNX.4.58.0410050250580.4941@devserv.devel.redhat.com>
Message-ID: <cone.1096959567.406629.10082.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Con Kolivas <kernel@kolivas.org>,
       =?ISO-8859-1?B?Q2hlbiw=?= Kenneth W <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: bug in sched.c:activate_task()
Date: Tue, 05 Oct 2004 16:59:27 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:

> 
> On Tue, 5 Oct 2004, Con Kolivas wrote:
> 
>> 	unsigned long long delta = now - next->timestamp;
>> 
>> 	if (next->activated == 1)
>> 		delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
>> 
>> is in schedule() before we update the timestamp, no?
> 
> indeed ... so the patch is just random incorrect damage that happened to
> distrub the scheduler fixing some balancing problem. Kenneth, what
> precisely is the balancing problem you are seeing?

We used to compare jiffy difference in can_migrate_task by comparing it to
cache_decay_ticks. Somewhere in the merging of sched_domains it was changed 
to task_hot which uses timestamp.

Con

