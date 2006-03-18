Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751974AbWCRGKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbWCRGKu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 01:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWCRGKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 01:10:50 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:6235 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751971AbWCRGKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 01:10:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=3tqqWph6XJktQaW1je8nLBq5aI5DHadexBxlu5mtLSKu/eVt4z9m1QfVvB4JmDkmc8fabeg28SXZKzgtE9T+fDH+BUG7hILxhEuk8+iGdQpNyNwq8KSfuCq0hpXK/6m6JCOHaMkB330SX3vv493MUKYrWzN0TSXv+i4YCtB6xZg=  ;
Message-ID: <441BA466.6000903@yahoo.com.au>
Date: Sat, 18 Mar 2006 17:10:46 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: steiner@sgi.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce overhead of calc_load
References: <20060317145709.GA4296@sgi.com>	<20060317145912.GA13207@elte.hu>	<20060317152611.GA4449@sgi.com>	<20060317171538.3826eb41.akpm@osdl.org>	<441B6BD3.2030807@yahoo.com.au>	<20060317183742.10431ba2.akpm@osdl.org>	<441B7489.1090403@yahoo.com.au> <20060317211315.55457f22.akpm@osdl.org> <441B9CE2.2050204@yahoo.com.au>
In-Reply-To: <441B9CE2.2050204@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Andrew Morton wrote:

>> Take a look at (for example) nr_iowait.  We forget to spill the count out
>> of the departing CPU's runqueue and hence we have to sum it across all
> 
> 
> I don't think a departing runqueue should have any iowaiters on it, 
> should it?
> 

No I'm wrong there. Instead of doing all these migrations and having the
ugly nr_iowait and nr_uninterruptible things I would much prefer just to
migrate the stat when the actual task is migrated. This should take care
of cpu hotplug, and also can make everything consistent.

I'll try doing a patch for that sometime.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
