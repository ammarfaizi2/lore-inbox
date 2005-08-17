Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbVHQTv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVHQTv3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 15:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVHQTv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 15:51:29 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1531 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751229AbVHQTv3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 15:51:29 -0400
Message-ID: <43039535.2010600@mvista.com>
Date: Wed, 17 Aug 2005 12:51:17 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
CC: Roman Zippel <zippel@linux-m68k.org>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [UPDATE PATCH] push rounding up of relative request to schedule_timeout()
References: <Pine.LNX.4.61.0507232151150.3743@scrub.home> <20050727222914.GB3291@us.ibm.com> <Pine.LNX.4.61.0507310046590.3728@scrub.home> <20050801193522.GA24909@us.ibm.com> <Pine.LNX.4.61.0508031419000.3728@scrub.home> <20050804005147.GC4255@us.ibm.com> <20050804051434.GA4520@us.ibm.com> <42F24643.7080702@mvista.com> <20050816230512.GD2806@us.ibm.com> <4302872F.2050303@mvista.com> <20050817055622.GB4143@us.ibm.com>
In-Reply-To: <20050817055622.GB4143@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan wrote:
~
>>IMNSHO we should not get too parental with kernel only interfaces. 
>>Adding 1 is easy enough for the caller and even easier to explain in the 
>>instructions (i.e. this call sleeps for X jiffies edges).  This allows 
>>the caller to do more if needed and, should he ever just want to sync to 
>>the next jiffie he does not have to deal with backing out that +1.
> 
> 
> I don't want to be too parental either, but I also am trying to avoid
> code duplication. Lots of drivers basically do something like
> poll_event() does (or could do with some changes), i.e. looping a
> constant amount multiple times, checking something every so often. The
> patch was just a thought, though. I will keep evaluating drivers and see
> if it's a useful interface to have eventually.
> 
> I guess I'm just concerned with making an unintuitive interface. As was
> brought up at OLS, drivers are a major source of bugs/buggy code. The
> simpler, more useful we can make interfaces, the better, I think. I'm
> not claiming you disagree, I just want to make my own motives clear.
> While fixing up the schedule_timeout() comment would make it clear what
> schedule_timeout() achieves, I'm not sure how useful such an interface
> is, if every caller adds 1 :) I need to mull it over, though... Lots to
> consider. I also, of course, want to stay flexible for the reasons you
> mention (letting the driver adjust the timeout as they expect to).

I would leave the +1 alone and put in the correct documentation.  This 
way _more_ folks will be made aware of the mid jiffie issue.  Far to 
often we see (and let get in) patches that mess up user interfaces 
around this issue.  The recent changes to itimer come to mind...
> 
~
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
