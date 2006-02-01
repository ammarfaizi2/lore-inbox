Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWBANys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWBANys (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWBANys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:54:48 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:33398 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932422AbWBANyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:54:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=iil7MBUDpYXzjXkOg+cCLGv2YInxpD5BHg7cka989zOvyvZiHq5uXufbWEcSBYIvGkMaJvVTxbAF+lOzah64bl9RlfolHGhr2P+orJGccJyYA5NCm9E4Z/MARwlfslC9j/HcG2OqB9uGbwZYvXzDQinwr5LawtYFqO8G4vgPWso=  ;
Message-ID: <43E0BDA3.8040003@yahoo.com.au>
Date: Thu, 02 Feb 2006 00:54:43 +1100
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
References: <1138736609.7088.35.camel@localhost.localdomain> <43E02CC2.3080805@bigpond.net.au> <1138797874.7088.44.camel@localhost.localdomain> <43E0B24E.8080508@yahoo.com.au> <43E0B342.6090700@yahoo.com.au> <20060201132054.GA31156@elte.hu> <43E0BBEC.3020209@yahoo.com.au>
In-Reply-To: <43E0BBEC.3020209@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Ingo Molnar wrote:
> 
>> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>> Oh, I forgot: Ingo once introduced some code to bail early (though 
>>> for different reasons and under different conditions), and this 
>>> actually was found to cause significant regressions in some database 
>>> workloads.
>>
>>
>>
>> well, we both did changes with that effect - pretty much any change in 
>> this area can cause a regression on _some_ workload ;) So there wont 
>> be any silver bullet.
>>
> 
> Well yes. Although specifically the bail-out-early stuff which IIRC
> you did... I wasn't singling you out in particular, I've broken the
> scheduler at _least_ as much as you have since starting work on it ;)
> 

... and my point is that there is not much reason to introduce a
possible performance regression because of such a latency in an
artificial test case, especially when there are other sources of
unbound latency when dealing with large numbers of tasks (and on
uniprocessor too, eg. rwsem).

However, as an RT-tree thing obviously I have no problems with it,
but unless your interrupt thread is preemptible, then there isn't
much point because it can cause a similar latency (that your tools
won't detect) simply by running multiple times.

You really want isolcpus on SMP machines to really ensure load
balancing doesn't harm RT behaviour, yeah?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
