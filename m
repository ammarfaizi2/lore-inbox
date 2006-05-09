Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWEIBHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWEIBHa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 21:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWEIBHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 21:07:30 -0400
Received: from dvhart.com ([64.146.134.43]:21986 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751271AbWEIBHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 21:07:30 -0400
Message-ID: <445FEB51.2040607@mbligh.org>
Date: Mon, 08 May 2006 18:07:29 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: Regression seen for patch "sched:dont         decrease idle sleep
 avg"
References: <1147130298.30649.33.camel@localhost.localdomain> <cone.1147135389.188411.32203.501@kolivas.org>
In-Reply-To: <cone.1147135389.188411.32203.501@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Tim Chen writes:
> 
>> Con,
>>
>> As a result of the patch "sched:dont decrease idle sleep avg" 
>> introduced after 2.6.15, there is a 4% drop in Volanomark throughput 
>> on our Itanium test machine.  Probably the following happened:
>> Compared to previous code, this patch slightly increases the the 
>> priority boost when a job is woken up.
>> This adds priority spread and variations to the wait time of jobs
>> on run queue if we have a lot of similar jobs in the system.
>>
>> See patch:
>> http://www.kernel.org/git/?
>> p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e72ff0bb2c163eb13014ba113701bd42dab382fe 
> 
> 
> 
> Lovely
> 
> This patch corrects a bug in the original code which unintentionally 
> dropped the priority of tasks that were idle but were already high 
> priority on other merits. It doesn't further increase the priority. The 
> 4% almost certainly is due to the lack of any locking in the threading 
> model used by the java virtual machine on volanomark and it being pure 
> luck that penalising particularly idle tasks previously improved the 
> wakeup timing of basically yielding dependant threads. This patch did 
> fix bugs related to interactive yet idle tasks like consoles 
> misbehaving. The fact that the presence of that particular bug improved 
> a multithreaded benchmark that uses such a threading model is pure 
> chance and (obviously) not design. I wouldn't like to see this bug 
> reintroduced on the basis of this benchmark result.

Volanomark (and most Java benchmarks) are random number generators
anyway, especially when it comes to scheduler patches. They're doing
such utterly stupid things anyway that I don't think we should care
if we break them ...

M.
