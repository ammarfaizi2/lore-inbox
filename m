Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbTLWBMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 20:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264901AbTLWBMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 20:12:24 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:51643 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264899AbTLWBMW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 20:12:22 -0500
Message-ID: <3FE79626.1060105@cyberone.com.au>
Date: Tue, 23 Dec 2003 12:11:02 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Nakajima, Jun" <jun.nakajima@intel.com>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
References: <200312231138.21734.kernel@kolivas.org>
In-Reply-To: <200312231138.21734.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>I've done a resync and update of my batch scheduling that is also hyper-thread 
>aware.
>
>What is batch scheduling? Specifying a task as batch allows it to only use cpu 
>time if there is idle time available, rather than having a proportion of the 
>cpu time based on niceness.
>
>Why do I need hyper-thread aware batch scheduling?
>
>If you have a hyperthread (P4HT) processor and run it as two logical cpus you 
>can have a very low priority task running that can consume 50% of your 
>physical cpu's capacity no matter how high priority tasks you are running. 
>For example if you use the distributed computing client setiathome you will 
>be effectively be running at half your cpu's speed even if you run setiathome 
>at nice 20. Batch scheduling for normal cpus allows only idle time to be used 
>for batch tasks, and for HT cpus only allows idle time when both logical cpus 
>are idle.
>
>This is not being pushed for mainline kernel inclusion, but the issue of how 
>to prevent low priority tasks slowing down HT cpus needs to be considered for 
>the mainline HT scheduler if it ever gets included. This patch provides a 
>temporising measure for those with HT processors, and a demonstrative way to 
>handle them in mainline.
>

I wonder how does Intel suggest we handle this problem? Batch scheduling
aside, I wonder how to do any sort of priorities at all? I think POWER5
can do priorities in hardware, that is the only sane way I can think of
doing it.

I think this patch is much too ugly to get into such an elegant scheduler.
No fault to you Con because its an ugly problem.

How about this: if a task is "delta" priority points below a task running
on another sibling, move it to that sibling (so priorities via timeslice
start working). I call it active unbalancing! I might be able to make it
fit if there is interest. Other suggestions?


