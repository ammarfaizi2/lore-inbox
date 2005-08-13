Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVHMBP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVHMBP5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 21:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVHMBP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 21:15:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8697 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932120AbVHMBP5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 21:15:57 -0400
Message-ID: <42FD4942.8050407@mvista.com>
Date: Fri, 12 Aug 2005 18:13:38 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Subject: Re: [PATCH] eliminte NMI entry/ exit code
References: <42FD42C1.6040009@mvista.com> <42FD4548.3060204@yahoo.com.au>
In-Reply-To: <42FD4548.3060204@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> George Anzinger wrote:
> 
>> The NMI entry and exit code fiddles with bits in the preempt count.  
>> If an NMI happens while some other code is doing the same, bits will 
>> be lost.  This patch removes this modify code from the NMI path till 
>> we can come up with something better.
>>
> 
> Humour me for a minute here...
> NMI restores preempt_count back to its old value upon exit, right?
> So what does a race case look like?

Normal code                   NMI
fetch preempt_count
add                   <-----  interrupt here add and store then subtract 
and store, darn!
store preempt_count

Ok, no problem.

The problem is in the RT code when PREEMPT_DEBUG is on.  The tests for 
reasonable counts fail because of the rather undefined state when NMI 
picks up the word.  The failure is on the NMI side...
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
