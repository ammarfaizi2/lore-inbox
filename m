Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVHBKHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVHBKHK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 06:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVHBKHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 06:07:09 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:41038 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261474AbVHBKGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 06:06:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xm/WhX/oovSlRWLg/8TwEqWtCUIyKsnhIW0uJt031+0P7vQ68XulXbn668HBDZgZ9l6GA3flXLNfuYzr0z7JH/yQos8arxfMUX3pu1s25sdaTlRu1Isb6MbOi9GvtwisT0iym6Nqo+3JBc1JULnRUezo2PxVQ+r6h5HeZcdgKWw=  ;
Message-ID: <42EF4597.1080208@yahoo.com.au>
Date: Tue, 02 Aug 2005 20:06:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, steiner@sgi.com
Subject: Re: [Patch] don't kick ALB in the presence of pinned task
References: <20050801174221.B11610@unix-os.sc.intel.com> <42EF0E0D.8000906@yahoo.com.au> <20050802094318.GC20978@elte.hu>
In-Reply-To: <20050802094318.GC20978@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>
>>Hmm, I would have hoped the new "all_pinned" logic should have handled 
>>this case properly. [...]
> 
> 
> no, active_balance is a different case, not covered by the all_pinned 
> logic. This is a HT-special scenario, where busiest->nr_running == 1, 
> and we have to do active load-balancing. This does not go through 
> move_tasks() and does not set all_pinned. (If nr_running werent 1 we'd 
> not have to kick active load-balancing.)
> 

Yeah I see. It looks like Suresh's patch should do a reasonable
job at doing "all pinned backoff" too, using the existing logic.
So I agree - great catch.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
