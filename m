Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVETQ6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVETQ6b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 12:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVETQ6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 12:58:30 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:2016 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261498AbVETQ6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 12:58:06 -0400
Message-ID: <428E16D1.2070800@candelatech.com>
Date: Fri, 20 May 2005 09:56:49 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.7) Gecko/20050417 Fedora/1.7.7-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Helge Hafting <helge.hafting@aitel.hist.no>,
       Arjan van de Ven <arjan@infradead.org>, linux-os@analogic.com,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       "Gilbert, John" <JGG@dolby.com>, linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>	 <20050518195337.GX5112@stusta.de>	 <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>	 <20050519112840.GE5112@stusta.de>	 <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>	 <1116505655.6027.45.camel@laptopd505.fenrus.org>	 <428CCD19.6030909@candelatech.com>  <428DAD71.4050105@aitel.hist.no> <1116607623.28552.12.camel@mindpipe>
In-Reply-To: <1116607623.28552.12.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Fri, 2005-05-20 at 11:27 +0200, Helge Hafting wrote:
> 
>>Ben Greear wrote:
>>
>>
>>>Arjan van de Ven wrote:
>>>
>>>
>>>>HZ may not exist. At all; people are trying to remove it. And userspace
>>>>has no business knowing about it either.
>>>
>>>
>>>It can be helpful to know what HZ you are running at, for instance if 
>>>you care
>>>very much about the (average) precision of a select/poll timeout.
>>>
>>
>>Will  knowing it help?  You may find out that you don't have much precision,
>>but then theres nothing to do about it.
> 
> 
> Yes, it will.  If you have an RT constraint and 10ms won't cut it (say,
> you want to send MIDI clock) then you can use the RTC.

Right.  For instance, before I found the 1000 HZ patch for the 2.4
kernel I would set the RTC to tick 1024 times a second, and then add
that FD to my select() fd-sets.  That causes select to return after about
1ms, and I could do this in a loop to get the X ms of sleep that I needed.

This is not as nice as having a clean 1ms tick clock, but it's a hell of
a lot better than a full busy spin...

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

