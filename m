Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWBANr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWBANr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWBANr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:47:29 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:10656 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932175AbWBANr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:47:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2gW42koOqrsN96Yu6Yk4/OqCG8TPZUVCVzF2TpgQ0MQH8ML/QhdflrlgVgGKXnNHS+p5w+xm9V/KV9E2dq0rAdzw2sETYj/8r1hZ9di5tP7ywvg929Q4lgVXL9KU0rdsadVHd7x2q9kBea1lMgVEV0s9q65X6/aEZ9E1L3y4/u4=  ;
Message-ID: <43E0BBEC.3020209@yahoo.com.au>
Date: Thu, 02 Feb 2006 00:47:24 +1100
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
References: <1138736609.7088.35.camel@localhost.localdomain> <43E02CC2.3080805@bigpond.net.au> <1138797874.7088.44.camel@localhost.localdomain> <43E0B24E.8080508@yahoo.com.au> <43E0B342.6090700@yahoo.com.au> <20060201132054.GA31156@elte.hu>
In-Reply-To: <20060201132054.GA31156@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>>Oh, I forgot: Ingo once introduced some code to bail early (though for 
>>different reasons and under different conditions), and this actually 
>>was found to cause significant regressions in some database workloads.
> 
> 
> well, we both did changes with that effect - pretty much any change in 
> this area can cause a regression on _some_ workload ;) So there wont be 
> any silver bullet.
> 

Well yes. Although specifically the bail-out-early stuff which IIRC
you did... I wasn't singling you out in particular, I've broken the
scheduler at _least_ as much as you have since starting work on it ;)

> 
>>So it is not a nice thing to tinker with unless there is good reason.
> 
> 
> unbound latencies with hardirqs off are obviously a good reason - but i 
> agree that the solution is not good enough, yet.
> 

Ah, so this is an RT tree thing where the scheduler lock turns off "hard
irqs"? As opposed to something like the rwsem lock that only turns off
your "soft irqs" (sorry, I'm not with the terminlogy)?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
