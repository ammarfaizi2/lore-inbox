Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263315AbUD2E0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbUD2E0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 00:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbUD2E0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 00:26:45 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:45446 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263315AbUD2E0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 00:26:21 -0400
Message-ID: <409083E9.2080405@yahoo.com.au>
Date: Thu, 29 Apr 2004 14:26:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Singer <elf@buici.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40904A84.2030307@yahoo.com.au> <20040429005801.GA21978@buici.com> <40907AF2.2020501@yahoo.com.au> <20040429042047.GB26845@buici.com>
In-Reply-To: <20040429042047.GB26845@buici.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer wrote:
> On Thu, Apr 29, 2004 at 01:48:02PM +1000, Nick Piggin wrote:
> 
>>Marc Singer wrote:
>>
>>>On Thu, Apr 29, 2004 at 10:21:24AM +1000, Nick Piggin wrote:
>>>
>>>
>>>>Anyway, I have a small set of VM patches which attempt to improve
>>>>this sort of behaviour if anyone is brave enough to try them.
>>>>Against -mm kernels only I'm afraid (the objrmap work causes some
>>>>porting difficulty).
>>>
>>>
>>>Is this the same patch you wanted me to try?  
>>>
>>> Remember, the embedded system where NFS IO was pushing my
>>> application out of memory.  Setting swappiness to zero was a
>>> temporary fix.
>>>
>>>
>>
>>Yes this is the same patch I wanted you to try. Yes I
>>remember your problem!
>>
>>Didn't anyone come up with a patch for you to test the
>>stale PTE theory? If so, what where the results?
> 
> 
> Russell King is working on a lot of things for the MMU code in ARM.
> I'm waiting to see where he ends up.  I believe he's planning on
> removing the lazy PTE release logic.
> 
> I hacked at it for some time.  And I'm convinced that I correctly
> forced the TLBs to be flushed.  Still, I was never able to get the
> system to behave.
> 
> Now, I just read a comment you or WLI made about the page cache
> use-once logic.  I wonder if that's the real culprit?  As I wrote to
> Andrew Morton, the kernel seems to be assigning an awful lot of value
> to page cache pages that are used once (or twice?).  I know that it
> would be expensive to perform an HTG aging algorithm where the head of
> the LRU list is really LRU.  Does your patch pursue this line of
> thought?
> 

Yes it includes something which should help that. Along with
the "split active lists" that I mentioned might help your
problem when WLI first came up with the change to the
swappiness calculation for your problem.

It would be great if you had time to give my patch a run.
It hasn't been widely stress tested yet though, so no
production systems, of course!
