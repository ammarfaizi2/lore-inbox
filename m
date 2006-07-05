Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWGES0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWGES0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWGES0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:26:11 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:57428 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964967AbWGES0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:26:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=K2KE9IHgFSxMN96FnIDELeLWAPiEtwZV1PwZ15CiiArfJW9NGLYZa0GxwrQeepgJ1uZv6Zb7+9fUO2sKsT4HNG54AjMZz6hyQdDCy9/yi9wpXTlRVa/cmK4P5h7UYkn+1LMbR3yEIAIlNqM9BEPsKD9HuuHdoeW8Iyiga0munq0=  ;
Message-ID: <44AC043C.70809@yahoo.com.au>
Date: Thu, 06 Jul 2006 04:26:04 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, Keith Owens <kaos@sgi.com>,
       torvalds@osdl.org, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net>	<21169.1151991139@kao2.melbourne.sgi.com> <20060703234134.786944f1.akpm@osdl.org> <44AAA64D.8030907@yahoo.com.au> <44AB6AB3.5070407@sgi.com>
In-Reply-To: <44AB6AB3.5070407@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> Nick Piggin wrote:
> 
>>Andrew Morton wrote:
>>
>>>I expect raw_smp_processor_id() is used here as a a microoptimisation -
>>>avoid a might_sleep() which obviously will never trigger.
>>
>>A microoptimisation because they've turned on DEBUG_PREEMPT and found
>>that smp_processor_id slows down? ;) Wouldn't it be better to just stick
>>to the normal rules (ie. what Keith said)?
>>
>>It may be obvious in this case (though that doesn't help people who make
>>obvious mistakes, or mismerge patches) but this just seems like a nasty
>>precedent to set (or has it already been?).
> 
> 
> I suspect the real reason here is that there's now so many ways to get
> the processor ID that I cannot keep track of which one to use. Paul's
> mention of __raw_get_cpu_var() just confuses me even more.
> 
> So if anyone can give me a conclusive answer of which one to use, I'm
> happy to go there.
> 
> Granted I have a bias to avoid anything involving the preempt crap, but
> thats just me :)

Use smp_processor_id() unless you explicitly want a lazy CPU number,
and in that case use the raw_ version. Turning off preempt or preempt
debug options does the rest for you.

If you're just using the number to feed into per_cpu, then use the
appropriate get_cpu variant.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
