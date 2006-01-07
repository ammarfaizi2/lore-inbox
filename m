Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWAGDTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWAGDTs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 22:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWAGDTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 22:19:48 -0500
Received: from smtp104.plus.mail.mud.yahoo.com ([68.142.206.237]:23376 "HELO
	smtp104.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030326AbWAGDTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 22:19:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=d4s/MxZp/KTrbCvVgBpxLDg8hRhnhIOkdO78RQAnJMMCQ7UosFVuEXgDr0vGdFb8c4YdbnH1UQyQmAhhv9AFhfwmF15oFwhFX4OFlZPFCk5bBJoyARaU3/I3n5pzFzK9UeuskHysn1gB7rRlQWG3HP/NqR/qGVt8FHibdW2JDjQ=  ;
Message-ID: <43BF3355.5060606@yahoo.com.au>
Date: Sat, 07 Jan 2006 14:19:49 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] use local_t for page statistics
References: <20060106215332.GH8979@kvack.org> <20060106163313.38c08e37.akpm@osdl.org> <43BF2D03.2030908@yahoo.com.au> <200601070401.47618.ak@suse.de>
In-Reply-To: <200601070401.47618.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Saturday 07 January 2006 03:52, Nick Piggin wrote:
> 
> 
>>No. On many load/store architectures there is no good way to do local_t,
>>so something like ppc32 or ia64 just uses all atomic operations for
> 
> 
> well, they're just broken and need to be fixed to not do that.
> 

How?

> Also I bet with some tricks a seqlock like setup could be made to work.
> 

I asked you how before. If you can come up with a way then it indeed
might be a good solution... The problem I see with seqlock is that it
is only fast in the read path. That path is not the issue here.

> 
>>local_t, and ppc64 uses 3 counters per-cpu thus tripling the cache
>>footprint.
> 
> 
> and ppc64 has big caches so this also shouldn't be a problem.
> 

Well it is even less of a problem for them now, by about 1/3.

Performance-wise there is really no benefit for even i386 or x86-64
to move to local_t now either so I don't see what the fuss is about.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
