Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSJMCEd>; Sat, 12 Oct 2002 22:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261429AbSJMCEd>; Sat, 12 Oct 2002 22:04:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:6565 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261426AbSJMCEb>;
	Sat, 12 Oct 2002 22:04:31 -0400
Message-ID: <3DA8D5E6.8090201@us.ibm.com>
Date: Sat, 12 Oct 2002 19:09:42 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Structure clobbering causes timer oopses
References: <3DA8C585.1030600@us.ibm.com> <3DA8C75C.C38F840B@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Dave Hansen wrote:
>>...
>>timer magic check failed timer:__run_timers():351
>>begin: 0xc035fbc8 end:0xc035fbe8
> 
> Can you look these up in System.map?

Inside tvec_bases, just like eip, because of timer_t->function.
c035fa80 d tvec_bases
c037fe80 d pidmap_lock
c037fea0 D page_states

>>BTW, I found lots of users who aren't using init_timer().  Should I
>>publicly humiliate them?
> 
> If they're initially using add_timer(), that works out
> OK.  It they start out using mod_timer() (or del_timer) then bug.

The init_timer() comment says otherwise, but I imagine that not using 
it shouldn't _cause_ any bugs.

* init_timer() must be done to a timer prior calling *any* of the
* other timer functions.

> I assume you tried all the memory debugging options?

No luck there.  I can't even get the oops to trigger with all the 
debugging on.

-- 
Dave Hansen
haveblue@us.ibm.com

