Return-Path: <linux-kernel-owner+w=401wt.eu-S1753427AbXACCG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbXACCG1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 21:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbXACCG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 21:06:27 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:49485 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427AbXACCG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 21:06:27 -0500
In-Reply-To: <000f01c72ed9$9a73cdd0$ff0da8c0@amr.corp.intel.com>
References: <000f01c72ed9$9a73cdd0$ff0da8c0@amr.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <96568BA6-9ECD-4E1D-B5B3-3AA41463A8EE@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>, "'Benjamin LaHaise'" <bcrl@kvack.org>,
       <suparna@in.ibm.com>
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [patch] aio: add per task aio wait event condition
Date: Tue, 2 Jan 2007 18:06:25 -0800
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 2, 2007, at 5:50 PM, Chen, Kenneth W wrote:

> Zach Brown wrote on Tuesday, January 02, 2007 5:24 PM
>>> That is not possible because when multiple tasks waiting for
>>> events, they
>>> enter the wait queue in FIFO order, prepare_to_wait_exclusive() does
>>> __add_wait_queue_tail().  So first io_getevents() with min_nr of 2
>>> will be woken up when 2 ops completes.
>>
>> So switch the order of the two sleepers in the example?
>
> Not sure why that would be a problem though:  whoever sleep first will
> be woken up first.

Why would the min_nr = 3 sleeper be woken up in that case?  Only 2  
ios were issued.

Maybe the app was relying on the min_nr = 2 completion to issue 3  
more ios for the min_nr = 3 sleeper, who knows.

> Before I challenge that semantics, I want to mention that in current
> implementation, dribbling AIO events will be distributed in round  
> robin
> fashion to all pending tasks waiting in io_getevents.

Yeah, don't misunderstand me -- we agree that the current situation  
is bad.

>   In the example you
> gave earlier, task with min_nr of 2 will be woken up after 4 completed
> events.

I only gave 2 ios/events in that example.

Does that clear up the confusion?

- z
