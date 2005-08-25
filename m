Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVHYXKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVHYXKv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 19:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbVHYXKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 19:10:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:21496 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S964992AbVHYXKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 19:10:51 -0400
Message-ID: <430E4FE9.6000607@mvista.com>
Date: Thu, 25 Aug 2005 16:10:33 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John McCutchan <ttb@tentacle.dhs.org>
CC: Robert Love <rml@novell.com>, jim.houston@ccur.com,
       Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       johannes@sipsolutions.net, linux-kernel@vger.kernel.org
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>	 <430D986E.30209@reub.net>  <1124976814.5039.4.camel@vertex>	 <1124983117.6810.198.camel@betsy>  <430E13D8.8070005@mvista.com> <1124996687.16219.3.camel@vertex>
In-Reply-To: <1124996687.16219.3.camel@vertex>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan wrote:
> On Thu, 2005-08-25 at 11:54 -0700, George Anzinger wrote:
> 
>>Robert Love wrote:
>>
>>>On Thu, 2005-08-25 at 09:33 -0400, John McCutchan wrote:
>>>
>>>
>>>>On Thu, 2005-08-25 at 22:07 +1200, Reuben Farrelly wrote:
~
>>I think the best thing is to take idr into user space and emulate the 
>>problem usage.  To this end, from the log it appears that you _might_ be 
>>moving between 0, 1 and 2 entries increasing the number each time.  It 
>>also appears that the failure happens here:
>>add 1023
>>add 1024
>>find 1024  or is it the remove that fails?  It also looks like 1024 got 
>>allocated twice.  Am I reading the log correctly?
> 
> 
> You are reading the log correctly. There are two bugs. One is that if we
> pass X to idr_get_new_above, it can return X again (doesn't ever seem to
> return < X). The other problem is that the find fails on 1024 (and 2048
> if we skip 1024).

That IS strange.  1024 is on a "level" boundry, but then next level is 
2**15, not 2**11.  I will take a look.

> 
> 
>>So, is it correct to assume that the tree is empty save these two at 
>>this time?  I am just trying to figure out what the test program needs 
>>to do.
> 
> 
> Yes that is the exact scenario. Only 2 id's are used at any given time,
> and once we hit 1024 things break. This doesn't happen when the tree is
> not empty.
> 
> Thanks for looking at this!

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
