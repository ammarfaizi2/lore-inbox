Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUGPF2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUGPF2O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 01:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUGPF2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 01:28:14 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:38229 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266459AbUGPF2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 01:28:13 -0400
Message-ID: <40F7675F.6090506@yahoo.com.au>
Date: Fri, 16 Jul 2004 15:27:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
CC: Dave Hansen <haveblue@us.ibm.com>,
       "Matthew C. Dobson [imap]" <colpatch@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sched domains bringup race?
References: <1089944026.32312.47.camel@nighthawk>	 <40F74599.7000606@yahoo.com.au> <1089948659.6886.2.camel@nighthawk> <40F74F9C.8080205@yahoo.com.au>
In-Reply-To: <40F74F9C.8080205@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Dave Hansen wrote:
> 
>> On Thu, 2004-07-15 at 20:03, Nick Piggin wrote:
>>
>>> It shouldn't because sched_init sets up dummy domains for
>>> all runqueues.
>>>
>>> Obviously something is going wrong somewhere though.
>>
>>
>>
>> Hmmm, but there still might be some concurrency problems, right?  There
>> isn't any locking while the setup is being done, so are all of the
>> intermediate initialization states valid?  Or, could one of the CPUs be
>> catching the init code in the middle of an operation?
>>
> 
> cpu_attach_domain is supposed to be able to do the switchover
> without any races.

Although the sched_domain_debug is definitely racy. It should really
be locking each runqueue before traversing its domains. Just undef
SCHED_DOMAIN_DEBUG to be sure...
