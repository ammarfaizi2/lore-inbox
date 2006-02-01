Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWBAQZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWBAQZd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWBAQZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:25:33 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:31338 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964960AbWBAQZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:25:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Ml9452ekBs4nYwXRkWdH1Mtmdr+jqbCrvxCRVo22aDIvKjAjP5VSYqUOVoODzu9bu/s4eVo9225VBVLCp/Xqpf/7lTd7cM+lEDKpC/VwLpmQSfMInqQgCWua2HRRDVfHNyoJ7zvOa4LudqVbDA2YNGgSJBmkPRrZWtxaTkS2Re8=  ;
Message-ID: <43E0E0F7.60209@yahoo.com.au>
Date: Thu, 02 Feb 2006 03:25:27 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Steven Rostedt <rostedt@goodmis.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
References: <43E0B342.6090700@yahoo.com.au> <20060201132054.GA31156@elte.hu> <43E0BBEC.3020209@yahoo.com.au> <43E0BDA3.8040003@yahoo.com.au> <20060201141248.GA6277@elte.hu> <43E0C4CF.8090501@yahoo.com.au> <20060201143727.GA9915@elte.hu> <43E0CBBC.2000002@yahoo.com.au> <20060201151137.GA14794@elte.hu> <43E0D464.2020509@yahoo.com.au> <20060201161035.GA22264@elte.hu>
In-Reply-To: <20060201161035.GA22264@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Ingo Molnar wrote:
>>

>>No, if you read what I'd been saying, I'm not dismissing the whole 
>>subject based on the workload. I'm saying that there is no point to 
>>include such a "fix" based on the numbers given by this workload (if 
>>there is a more meaningful one, then sure). Especially not while there 
>>are sources of equivalent latency.
> 
> 
> firstly, you are ignoring the fact that Steve never submitted this for 
> actual inclusion. His very first email stated:
> 

You keep saying this. I'm talking about the general concept of
"avoid moving tasks when a schedule can be made", or some way to
reduce latencies in move_tasks. Obviously we are long past the fact
that this particular patch isn't the best implementation.

>   "I'm not convinced that this bail out is in the right location, but 
>    it worked where it is.  Comments are welcome."
> 
> so i'm not sure why you are still pounding upon his patch and suggesting 
> that any solution to this problem is to be limited to the -rt kernel and 

Err, I'm not.

>>It is really simple: I can find a code path in the kernel, and work 
>>out how to exploit it by increasing resource loading until it goes 
>>bang (another example, tasklist_lock).
> 
> 
> we are busy fixing tasklist_lock latencies too. The point you are still 
> trying to make, that the scheduler should not be touched just because 
> there are other problem areas with unbound latencies, is still plain 
> illogical.
> 

Actually my main argument is that it is not a realistic workload,
and that I'd prefer not to touch the fragile scheduler until I see
one. I think that's perfectly logical, but whatever.

> 
>>But there are still places where interrupts can be held off for 
>>indefinite periods. I don't see why the scheduler lock is suddenly 
>>important [...]
> 
> 
> the scheduler lock is obviously important because it's the most central 
> lock in existence.
> 

Now I call that argument much more illogical than any of mine. How
can such a fine grained, essentially per-cpu lock be "central", let
alone "most central"? And even if it were central, why would that
make it obviously important?

> 
>>[...] I could have told you years ago what would happen if you trigger 
>>the load balancer with enough tasks.
> 
> 
> i very well know what move_tasks() can do. There used to be other ways 
> to provoke unbound latencies in the scheduler - e.g.  via pinned tasks, 
> for which we introduced the all_pinned hack. The all_pinned hack was 
> needed because the worst-case behavior was getting so bad on some larger 
> boxes under larger loads that it totally DoSed the system. So it's not 

But luckily the scheduler is basically completely non functional in
the presence of pinned tasks anyway, so this is the only time this
special case kicks in.

But sure, it is there. I don't see how that justifies more changes
in that place for no reason. As soon as I see a good reason then I'd
be more than happy to look into it myself.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
