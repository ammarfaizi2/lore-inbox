Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWHHBuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWHHBuV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 21:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWHHBuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 21:50:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12934 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751203AbWHHBuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 21:50:20 -0400
Message-ID: <44D7EDC6.6040502@sgi.com>
Date: Mon, 07 Aug 2006 18:49:58 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Jay Lan <jlan@engr.sgi.com>, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com, jes@sgi.com, csturtiv@sgi.com,
       tee@sgi.com, guillaume.thouvenin@bull.net
Subject: Re: [patch 3/3] convert CONFIG tag for extended accounting routines
References: <44D17A47.4010302@engr.sgi.com> <20060803000331.22fcb4c0.akpm@osdl.org> <44D26769.4070505@sgi.com>
In-Reply-To: <44D26769.4070505@sgi.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:
> Andrew Morton wrote:
> 

[snip]

>>
>>> +        if (delta == 0)
>>> +            return;
>>> +        tsk->acct_stimexpd = tsk->stime;
>>> +        tsk->acct_rss_mem1 += delta * get_mm_rss(tsk->mm);
>>> +        tsk->acct_vm_mem1 += delta * tsk->mm->total_vm;
>>
>>
>>
>> It's a bit weird to be multiplying RSS by time.  What unit is a "byte
>> second"?
>>
>> If this is not a bug then I guess this is an intermediate term for
>> additional downstream processing.  There is information loss here and I'd
>> have thought that it would be better to simply send `delta' and the rss
>> straight to userspace, let userspace work out what math it wants to 
>> perform
>> on it.  If that makes sense?
>>
>> I see that the code has been like this for a long time, so treat this 
>> as a
>> "please educate me about BSD accounting" email ;)
> 
> 
> This is not a BSD accounting thing. It came from UNICOS and IRIX.
> I am pinging the person who knows how the real world users use these
> two fields...

Andrew,

Here is the explanation i owe you.

We accumulated the RSS/VM value at each timer interrupt update in terms
of pages-tick. At userland, the value is divided by tsk->stime (in usec)
to gain average usage of RSS/VM.

I need to do a little bit more processing in the kernel to convert
the pages-tick values to Mbytes-usec unit before delivery to userland
since the calculation are platform dependent. I will include the
change in the upcoming update patch.

Regards,
  - jay


> 
> Regards,
>  - jay
> 
>>
> 
> 

