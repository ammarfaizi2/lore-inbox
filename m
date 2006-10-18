Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161266AbWJRSkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161266AbWJRSkg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161268AbWJRSkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:40:36 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:18524 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161266AbWJRSkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:40:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lRUg5IZTTtLYq3h+iySbgrIKVW7D3+hbEQPTsNSLkkp8NbIjx8gxatbIAljb2BxdjI6OvA6tV6fem7dzFSdpTKd5i5Irz4LojU9Isg5/s9hqUAD1AkML3tPL4dRNrQNSExjJHR8u0VIYdECafTOsrUSx9EtkctlAFvQzxS30TP4=  ;
Message-ID: <45367521.4080209@yahoo.com.au>
Date: Thu, 19 Oct 2006 04:40:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix generic WARN_ON message
References: <4535902E.1000608@goop.org> <20061018055542.GA14784@elte.hu> <45367350.4070902@goop.org>
In-Reply-To: <45367350.4070902@goop.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> Ingo Molnar wrote:
> 
>> Firstly, most WARN_ON()s are /bugs/, not warnings ... If it's a real 
>> warning, a KERN_INFO printk should be done.
>>   
> 
> 
> It seems to me that either the warnings are really bugs, in which case 
> they should be using BUG/BUG_ON, or they're not really bugs, in which 
> case they should be presented differently.

No. A BUG() will terminate the current process which, aside from the
loss of userspace data, can tangle up the kernel badly and deadlock
or panic it.

If a bug can be fixed up or otherwise will not result in unstable
behaviour with continued operation, then it should be a WARN.

> 
>> Secondly, the reason i changed it to the 'BUG: ...' format is that i 
>> tried to make it easier for automated tools (and for users) to figure 
>> out that a kernel bug happened.
>>   
> 
> 
> Well, are they bugs or not?  I think people are more confused by the 
> "BUG" prefix and stacktrace than helped by it (even an experienced eye 
> will glance-parse a BUG+stack trace as a serious oops-level problem 
> rather than a warning).

Definitely a bug. If the condition is not a bug then the code calling
WARN is, so it is a bug no matter how you look at it ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
