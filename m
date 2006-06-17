Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbWFQDqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWFQDqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 23:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWFQDqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 23:46:35 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:57472 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751587AbWFQDqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 23:46:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Z8faerkJMpR+DsaXByTS+3lmbRNgXYzS4EWpWiygMKtmQXY/L01pkCkGZqWVhqtpaMR5dQID0xFA3uQON73snuOrkc9iWXVoQGBfjUaXJZikjdzqXVjduXRCeT8WCQf/gHBt+DScS4nNNozBND5FoSaq1R5KdBVEErmZrNSg4Xo=  ;
Message-ID: <44937B16.3050204@yahoo.com.au>
Date: Sat, 17 Jun 2006 13:46:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, ashok.raj@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special
 RT tasks.
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com> <p7364j1qx66.fsf@verdi.suse.de> <20060616192654.50f4f6b7.kamezawa.hiroyu@jp.fujitsu.com> <200606161236.50302.ak@suse.de>
In-Reply-To: <200606161236.50302.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Friday 16 June 2006 12:26, KAMEZAWA Hiroyuki wrote:
> 
>>On 16 Jun 2006 11:14:57 +0200
>>Andi Kleen <ak@suse.de> wrote:
>>
>>
>>>KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:
>>>
>>>>This is a bit pessimistic. But forecd migration of RT task which is bounded
>>>>to the special cpu will cause unpredictable trouble, I think.
>>>
>>>More trouble than running it on a CPU that is about to fail?
>>>Doubtful.
>>>
>>
>>With my patch, RT tasks will continute to run.
> 
> 
> That's the problem - if the CPU is failing and you have to remove
> it the task will likely corrupt its data or fail in other ways
> if it doesn't allow it.
> 
> Better to let RT tasks run a little slower on another CPU.
> 
>  
> 
>>Assume there are some multi-threaded tasks with SCHED_FIFO.
>>If they uses some kind of synchronization in user land and task is migrated to
>>other cpus, it will cause dead-lock.
> 
> 
> If its CPU fails much worse things than that will happen.
> 
> One way might be to break affinity of all processes in the system on hot unplug
> - then your deadlock would be avoided - but it might be a bit radical.

Agreed. The kernel is just doing some basic fallback behaviour. If you
actually have a critical RT system, you probably need to have much more
sophisticated handling of CPU unplug anyway. So it doesn't make much
sense to complicate the kernel for this.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
