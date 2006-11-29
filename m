Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966602AbWK2Jbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966602AbWK2Jbk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 04:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966606AbWK2Jbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 04:31:40 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:52851 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966602AbWK2Jbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 04:31:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=deVq3apWKR8iDAJhtWQRQo86yFfYtYbJHjDxSvRSZtBum+yKohz1uHftU5ZPtd8wyMy/BZkLgMjlRYIIE9MJJdw2OmUlbAX1Zr9+ryR3Lh0/KG29IWlnwz3XoJ4O0onOcPUwYrnpFOfWfxhzVkas8jEJRC/T8imbM7rLGj4pEdU=  ;
X-YMail-OSG: r9cfyOgVM1nXZlV9mVh3DUDvufZNiko5W0ttSO.H2lTg5OLNfxVJFhAo4zrZXd6YwQp5.bV7gPDw1ELfMRSttcYczLgIRb9gQYc.AaqvtPsfR7iTrgKpnNvS72839Wu3X2U7D7gA15xtvlA-
Message-ID: <456D5347.3000208@yahoo.com.au>
Date: Wed, 29 Nov 2006 20:30:47 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Aubrey <aubreylee@gmail.com>
CC: Sonic Zhang <sonic.adi@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, vapier.adi@gmail.com
Subject: Re: The VFS cache is not freed when there is not enough free memory
 to allocate
References: <6d6a94c50611212351if1701ecx7b89b3fe79371554@mail.gmail.com>	 <1164185036.5968.179.camel@twins>	 <6d6a94c50611220202t1d076b4cye70dcdcc19f56e55@mail.gmail.com>	 <456A964D.2050004@yahoo.com.au>	 <4e5ebad50611282317r55c22228qa5333306ccfff28e@mail.gmail.com> <6d6a94c50611290127u2b26976en1100217a69d651c0@mail.gmail.com>
In-Reply-To: <6d6a94c50611290127u2b26976en1100217a69d651c0@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey wrote:
> On 11/29/06, Sonic Zhang <sonic.adi@gmail.com> wrote:
> 
>> Forward to the mailing list.
>>
>> > On 11/27/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>
>>
>> >> I haven't actually written any nommu userspace code, but it is obvious
>> >> that you must try to keep malloc to <= PAGE_SIZE (although order 2 and
>> >> even 3 allocations seem to be reasonable, from process context)... 
>> Then
>> >> you would use something a bit more advanced than a linear array to 
>> store
>> >> data (a pagetable-like radix tree would be a nice, easy idea).
>> >>
>> >
>> > But, even we split the 8M memory into 2048 x 4k blocks, we still face
>> > this failure. The key problem is that available memory is small than
>> > 2048 x 4k, while there are still a lot of VFS cache. The VFS cache can
>> > be freed, but kernel allocation function ignores it. See the new test
>> > application.
>>
>>
>> Which kernel allocation function? If you can provide more details I'd
>> like to get to the bottom of this.
> 
> 
> I posted it here, I think you missed it. So forwarded it to you.

That was the order-9 allocation failure. Which is not going to be
solved properly by just dropping caches.

But Sonic apparently saw failures with 4K allocations, where the
caches weren't getting shrunk properly. This would be more interesting
because it would indicate a real problem with the kernel.

>>
>> Also, do you happen to know of a reasonable toolchain + emulator setup
>> that I could test the nommu kernel with?
> 
> 
> A project named skyeye.
> http://www.skyeye.org/index.shtml

Thanks, I'll give that one a try.

Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
