Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752527AbWAGCwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbWAGCwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 21:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbWAGCwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 21:52:51 -0500
Received: from smtp110.plus.mail.mud.yahoo.com ([68.142.206.243]:23904 "HELO
	smtp110.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752519AbWAGCwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 21:52:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=T3CMO9H3Grk4Q1hPQPsgMzzpbJeOUZ/qFyZOSSoBmptlFDJwg9FMw3KzV3iJ/mZq+kh7DaUYfxWwJZVGs7GcwzYEeqvjgpDGjczt1oyLrEyeGNPPkM5s8xqrfAqBcZrMuQfWw0y4tgxgMsGuesWGg/HcKeL3EhhVmRJLEYVxIzI=  ;
Message-ID: <43BF2D03.2030908@yahoo.com.au>
Date: Sat, 07 Jan 2006 13:52:51 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] use local_t for page statistics
References: <20060106215332.GH8979@kvack.org> <20060106163313.38c08e37.akpm@osdl.org>
In-Reply-To: <20060106163313.38c08e37.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Benjamin LaHaise <bcrl@kvack.org> wrote:
> 
>>The patch below converts the mm page_states counters to use local_t.  
>>mod_page_state shows up in a few profiles on x86 and x86-64 due to the 
>>disable/enable interrupts operations touching the flags register.  On 
>>both my laptop (Pentium M) and P4 test box this results in about 10 
>>additional /bin/bash -c exit 0 executions per second (P4 went from ~759/s 
>>to ~771/s).  Tested on x86 and x86-64.  Oh, also add a pgcow statistic 
>>for the number of COW page faults.
> 
> 
> Bah.  I think this is a better approach than the just-merged
> mm-page_state-opt.patch, so I should revert that patch first?
> 

No. On many load/store architectures there is no good way to do local_t,
so something like ppc32 or ia64 just uses all atomic operations for
local_t, and ppc64 uses 3 counters per-cpu thus tripling the cache
footprint.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
