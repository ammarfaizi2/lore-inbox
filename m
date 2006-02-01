Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWBANKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWBANKa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWBANKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:10:30 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:37540 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964924AbWBANKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:10:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lrQGsBTOnq0225/BAMAWOLqYZH9MIT11ycTlpGebAmKrJ5EOrZ9UoFmqddGCaxK5WZfoZicdAUu09nO7gnq7ZgqqKj13VVQkFQPMUwuZ1ohHeShzeT5U2H8BAUCRKoXaU+U8uGES5GSlJ+o7mHeeC6Qtzw+GYhtAIf/pkQHuDas=  ;
Message-ID: <43E0B342.6090700@yahoo.com.au>
Date: Thu, 02 Feb 2006 00:10:26 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Peter Williams <pwil3058@bigpond.net.au>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
References: <1138736609.7088.35.camel@localhost.localdomain>	 <43E02CC2.3080805@bigpond.net.au> <1138797874.7088.44.camel@localhost.localdomain> <43E0B24E.8080508@yahoo.com.au>
In-Reply-To: <43E0B24E.8080508@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Steven Rostedt wrote:
> 
>>
>> No real work is lost.  This is a loop that individually pulls tasks.  So
>> the bail only stops the work of looking for more tasks to pull and we
>> don't lose the tasks that have already been pulled.
>>
>>
> 
> Once we've gone to the trouble of deciding which tasks to move and how
> many (and the estimate should be very conservative), and locked the source
> and destination runqueues, it is a very good idea to follow up with our
> threat of actually moving the tasks rather than bail out early.
> 

Oh, I forgot: Ingo once introduced some code to bail early (though for
different reasons and under different conditions), and this actually
was found to cause significant regressions in some database workloads.
So it is not a nice thing to tinker with unless there is good reason.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
