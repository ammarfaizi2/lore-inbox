Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbUKIBYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbUKIBYf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbUKIBWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:22:42 -0500
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:37353 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261352AbUKIBIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:08:36 -0500
References: <DBFABB80F7FD3143A911F9E6CFD477B002A7F0CE@hqemmail02.nvidia.com>
Message-ID: <cone.1099962506.38730.13436.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Stephen Warren <SWarren@nvidia.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: SCHED_RR and kernel threads
Date: Tue, 09 Nov 2004 12:08:26 +1100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Warren writes:

>> From: Con Kolivas [mailto:kernel@kolivas.org] 
>> Stephen Warren wrote:
>> > It appears that during times of high application CPU usage, some
>> > *kernel* threads don't get to run.
>> > ...
>> > This appears to be due to the fact that the kernel threads are all
>> > SCHED_OTHER, so our SCHED_RR user-space application trumps them!
>> 
>> Don't run your userspace at SCHED_RR? The kernel threads are 
>> SCHED_NORMAL precisely for the reason that you wont get real time 
>> performance if the kernel threads rear their ugly heads, 
>> albeit rarely.
> 
> We have actually set the kernel threads to priority SCHED_RR 50, and
> most user-space threads to SCHED_RR priority 50. Some critical
> user-space threads are above priority 50.
> 
> Won't this allow the kernel and user space threads to co-operate nicely
> all the time?
> 
> What is it specifically that will make kernel SCHED_RR threads cause
> non-real-time operation? If it's just a bunch of corner cases or odd
> conditions, we may be in an environment we can control so that doesn't
> happen...
> 
> I guess we could have most threads stay at SCHED_NORMAL, and just make
> the few critical threads SCHED_RR, but I'm getting a lot of push-back on
> this, since it makes our thread API a lot more complex.

Your workaround is not suitable for the kernel at large. Preventing 
starvation of the system if you are using SCHED_RR threads is up to your 
userspace apps to provide. SCHED_RR is _not_ designed to use 100% of the cpu 
all the time, but to provide minimum latency preempting everything lower 
priority than itself when scheduled. The kernel threads do not need that 
sort of control and can potentially starve critical userspace threads during 
heavy system stress.

Cheers,
Con

