Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966684AbWKOGBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966684AbWKOGBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 01:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966685AbWKOGBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 01:01:48 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:56896 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S966684AbWKOGBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 01:01:48 -0500
Message-ID: <455AAD19.8060605@oracle.com>
Date: Tue, 14 Nov 2006 22:00:57 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: ego@in.ibm.com
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       vatsa@in.ibm.com, dipankar@in.ibm.com, davej@redhat.com, mingo@elte.hu,
       kiran@scalex86.org
Subject: Re: [PATCH 1/4] Extend notifier_call_chain to count nr_calls made.
References: <20061114121832.GA31787@in.ibm.com> <20061114122050.GB31787@in.ibm.com> <20061114101806.a14ef7b7.randy.dunlap@oracle.com> <20061115045933.GA7207@in.ibm.com>
In-Reply-To: <20061115045933.GA7207@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R Shenoy wrote:
> On Tue, Nov 14, 2006 at 10:18:06AM -0800, Randy Dunlap wrote:
>> On Tue, 14 Nov 2006 17:50:51 +0530 Gautham R Shenoy wrote:
>>
>>>  include/linux/notifier.h |    8 +++
>>>  kernel/sys.c             |   97 +++++++++++++++++++++++++++++++++++++++-------- 2 files changed, 89 insertions(+), 16 deletions(-)
>>>
>>> Index: hotplug/kernel/sys.c
>>> ===================================================================
>>> --- hotplug.orig/kernel/sys.c
>>> +++ hotplug/kernel/sys.c
>>> @@ -134,19 +134,41 @@ static int notifier_chain_unregister(str
>>>  	return -ENOENT;
>>>  }
>>>  
>>> +/*
>>> + * notifier_call_chain - Informs the registered notifiers about an event.
>>> + *
>>> + *	@nl:		Pointer to head of the blocking notifier chain
>>> + *	@val:		Value passed unmodified to notifier function
>>> + *	@v:		Pointer passed unmodified to notifier function
>>> + *	@nr_to_call:	Number of notifier functions to be called. Don't care
>>> + *		     	value of this parameter is -1.
>>> + *	@nr_calls:	Records the number of notifications sent. Don't care
>>> + *		   	value of this field is NULL.
>>> + *
>>> + * 	RETURN VALUE:	notifier_call_chain returns the value returned by the
>>> + *			last notifier function called.
>>> + */
>> You can make that comment block be kernel-doc format by using
>> /**
>> as the comment introduction and removing the blank line after the
>> function name & short description.
> 
> Will do that. But out of curiousity, do the comments of even static functions
> get reflected in kernel doc ? :?

They can be, but static functions are low priority for kernel-doc
IMO, so it's not a big deal to me if you don't make that be kernel-doc.

>>>  static int __kprobes notifier_call_chain(struct notifier_block **nl,
>>> -		unsigned long val, void *v)
>>> +					unsigned long val, void *v,
>>> +					int nr_to_call,	unsigned int *nr_calls)
>>>  {
>>>  	int ret = NOTIFY_DONE;
>>>  	struct notifier_block *nb, *next_nb;
>> ...
>>>  }

Thanks,
-- 
~Randy
