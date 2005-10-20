Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbVJTWTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbVJTWTe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 18:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbVJTWTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 18:19:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:65272 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932548AbVJTWTd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 18:19:33 -0400
Message-ID: <435817F1.3000402@mvista.com>
Date: Thu, 20 Oct 2005 15:19:29 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, ganzinger@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain> <Pine.LNX.4.64.0510190816380.30406@dhcp153.mvista.com> <Pine.LNX.4.58.0510200238390.27683@localhost.localdomain> <Pine.LNX.4.64.0510200759110.19738@dhcp153.mvista.com>
In-Reply-To: <Pine.LNX.4.64.0510200759110.19738@dhcp153.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Thu, 20 Oct 2005, Steven Rostedt wrote:
> 
>>
>> Yes, but that shouldn't make a difference.  NTP can slow down or speed up
>> the clock, but it should never make it go backwards. Especially for a
>> monotonic clock (as the name suggests).
> 
> 
>     It looks like if ntp_adj held a big negative number you might end up 
> with a smaller output . ntp_adj is signed too .. I don't know how 
> ntp_adj is set though .
> 
>     I thought I remember George Anzinger speculating that ntp could 
> cause the time to backwards , that's why I brought it up. Maybe if he's 
> read he can clue us in ..
> 
I think John has changed this, but in the "old" code if ntp was correcting the clock such that less 
than TICK_NSEC was added on a tick, AND, the time was read just prior to this tick the get_offset 
code would return ~TICK_NSEC of offset which would mean that a read right after the tick might be 
less than the one just prior to the tick.  The error, however, would be in the nanosecond area (no 
where near a second).  Again, as I said, I think John has changed this in is code so that the 
get_offset equivalent is also ntp corrected, thus eliminating the small back step.
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
