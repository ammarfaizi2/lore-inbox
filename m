Return-Path: <linux-kernel-owner+w=401wt.eu-S932443AbWLMBcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWLMBcv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 20:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWLMBcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 20:32:51 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:50410 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932443AbWLMBcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 20:32:51 -0500
Message-ID: <457F583B.9090109@linux.vnet.ibm.com>
Date: Tue, 12 Dec 2006 17:32:43 -0800
From: "AVANTIKA R. MATHUR" <mathur@linux.vnet.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061105)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Avantika Mathur <mathur@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: cfq performance gap
References: <1165536200.25180.1.camel@dyn9047017105.beaverton.ibm.com>	<20061208120522.GN23887@kernel.dk>	<1165615793.9200.11.camel@dyn9047017105.beaverton.ibm.com> <20061211140845.GL4576@kernel.dk>
In-Reply-To: <20061211140845.GL4576@kernel.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Dec 08 2006, Avantika Mathur wrote:
>   
>> On Fri, 2006-12-08 at 13:05 +0100, Jens Axboe wrote:
>>     
>>> On Thu, Dec 07 2006, Avantika Mathur wrote:
>>>       
>>>> Hi Jens,
>>>>         
>>> (you probably noticed now, but the axboe@suse.de email is no longer
>>> valid)
>>>       
>> I saw that, thanks!
>>     
>>>> I've noticed a performance gap between the cfq scheduler and other io
>>>> schedulers when running the rawio benchmark.
>>>>
>>>> The benchmark workload is 16 processes running 4k random reads.
>>>>
>>>> Is this performance gap a known issue?
>>>>         
>>> CFQ could be a little slower at this benchmark, but your results are
>>> much worse than I would expect. What is the queueing depth of sda? How
>>> are you invoking rawio?
>>>       
>> I am running rawio with the following options:
>> rawread -p 16 -m 1 -d 1 -x -z -t 0 -s 4096
>>
>> The queue depth on sda is 4.
>>     
>>> Your runtime is very low, how does it look if you allow the test to run
>>> for much longer? 30MiB/sec random read bandwidth seems very high, I'm
>>> wondering what exactly is being tested here.
>>>       
>> rawio is actually performing sequential reads, but I don't believe it is
>> purely sequential with the multiple processes.
>> I am currently running the test with longer runtimes and will post
>> results once it is complete.
>> I've also attached the rawio source.
>>     
>
> It's certainly the slice and idling hurting here. But at the same time,
> I don't really think your test case is very interesting. The test area
> is very small and you have 16 threads trying to read the same thing,
> optimizing for that would be silly as I don't think it has much real
> world relevance.
>
>   
Could a database have similar workload to this test?
> That said, I might add some logic to detect when we can cheaply switch
> queues instead of waiting for a new request from the same queue.
> Averaging slice times over a period of time instead of 1:1 with that
> logic, should help cases like this while still being fair.
>   
Thank you for looking at this issue.
I've found an IBM/SUSE bugzilla bug for the same performance gap on 
rawio. There was a fix for this bug included in SLES10-RC1, do you know 
why it was not added in mainline?

Thanks again,
Avantika Mathur
