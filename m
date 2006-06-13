Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752324AbWFMFnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbWFMFnS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 01:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbWFMFnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 01:43:17 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:5515 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752324AbWFMFnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 01:43:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=iGxxNxO+G/PVMkMxQRFv/rhHzeFoN2cuxx8APGmtvOx6MDuAC74++1jSgv9kbJ3PfSJJAk7XCmCxYCuefhQYqhlruRC6KYEqcmtnAlv55KgmAfElwj6PiOW16CZ1yFZywpA7AoAgu/BzZG8pOxUPEntkWroa+g5pkWlhSWSyG0Q=  ;
Message-ID: <448E5070.90003@yahoo.com.au>
Date: Tue, 13 Jun 2006 15:43:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Keith Owens <kaos@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
References: <10021.1150175320@kao2.melbourne.sgi.com> <200606130718.35498.ak@suse.de>
In-Reply-To: <200606130718.35498.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 13 June 2006 07:08, Keith Owens wrote:
> 
>>Andi Kleen (on Tue, 13 Jun 2006 06:56:45 +0200) wrote:
>>
>>>>I have previously suggested a lightweight solution that pins a process
>>>>to a cpu 
>>>
>>>That is preempt_disable()/preempt_enable() effectively
>>>It's also light weight as much as these things can be.
>>
>>The difference being that preempt_disable() does not allow the code to
>>sleep.  There are some places where we want to use cpu local data 
>>and 
>>the code can tolerate preemption and even sleeping, as long as the
>>process schedules back on the same cpu.
> 
> 
> Seems like a pretty obscure case to optimize for.
> 
> Anyways if you want to do that you can always do
> 
> disable_preempt(); 
> set thread affinity mask to current cpu
> enable_preempt(); 
> do weird stuff and sleep ...  ;
> restore affinity mask
> 
> Can any of these people proposing "solutions" in this thread
> demonstrate this stuff is actually performance critical?

You can't do this in general, because CPU hotplug will reset the
affinity mask if the CPU is unplugged. I'd just say: don't do that.

However you can get some similar functionality by putting stuff in
task_struct.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
