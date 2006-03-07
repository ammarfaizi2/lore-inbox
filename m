Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWCGF43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWCGF43 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 00:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWCGF43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 00:56:29 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:45650 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751107AbWCGF43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 00:56:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VHmzjp02CyJb0vsTzlzc2Td+4Do+dbwD34QUfcL/06wYlHJTjxxRX54EOx1yPeFnmWiDMSppKw59HLAmMduHBJ4KhaXKw2Zd9JB0S8Jd3mJlWGrGtC6Al4EEDVKoK8Zy6eJydyr45uwYkj9FXpJamGT1CivJ0JER+WghgG7rgG0=  ;
Message-ID: <440D2087.5010201@yahoo.com.au>
Date: Tue, 07 Mar 2006 16:56:23 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>
Subject: Re: Fw: Re: oops in choose_configuration()
References: <20060304121723.19fe9b4b.akpm@osdl.org>	 <Pine.LNX.4.64.0603041235110.22647@g5.osdl.org>	 <20060304213447.GA4445@kroah.com> <20060304135138.613021bd.akpm@osdl.org>	 <20060304221810.GA20011@kroah.com> <20060305154858.0fb0006a.akpm@osdl.org>	 <Pine.LNX.4.64.0603052043170.13139@g5.osdl.org>	 <1141631240.26111.11.camel@homer> <1141710669.7901.9.camel@homer>
In-Reply-To: <1141710669.7901.9.camel@homer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Mon, 2006-03-06 at 08:47 +0100, Mike Galbraith wrote:
> 
>>On Sun, 2006-03-05 at 21:00 -0800, Linus Torvalds wrote:
>>
>>
>>>Is there something else I've missed?
>>
>>Maybe.  Does this add anything to the picture?  During boot,
>>recalc_task_prio() is called with now < p->timestamp.  This causes quite
>>a stir.  If you WARN_ON(now < p->timestamp) or printk, you'll have a
>>dead box due to hundreds of gripes as things churn.  Adding...
>>
>>if (unlikely(now < p->timestamp))
>>	__sleep_time = 0ULL;
>>
>>...turns it into exactly one gripe.
> 
> 
> Nope.  Further research shows that this is just a speed-step problem.
> Still, the scheduler needs to protect itself, because even with all of
> the speed-step stuff enabled, these continue to occurr even after
> boot-up if you switch to a low power setting, which screws up the
> scheduler.
> 

sched_clock needs to be fixed, rather than scheduler.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
