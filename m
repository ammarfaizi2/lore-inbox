Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbVLOCae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbVLOCae (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 21:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbVLOCae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 21:30:34 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:52465 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1030295AbVLOCad
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 21:30:33 -0500
Message-ID: <43A0D505.3080507@mvista.com>
Date: Wed, 14 Dec 2005 18:29:25 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: tglx@linutronix.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rostedt@goodmis.org, johnstul@us.ibm.com,
       mingo@elte.hu
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
References: <20051206000126.589223000@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0512061628050.1610@scrub.home>  <1133908082.16302.93.camel@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0512070347450.1609@scrub.home>  <1134148980.16302.409.camel@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0512120007010.1609@scrub.home> <1134405768.4205.190.camel@tglx.tec.linutronix.de> <439E2308.1000600@mvista.com> <Pine.LNX.4.61.0512150141050.1609@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0512150141050.1609@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Mon, 12 Dec 2005, George Anzinger wrote:
> 
> 
>>My $0.02 worth: It is clear (from the standard) that the initial time is to be
>>ABS_TIME.
> 
> 
> Yes.
> 
> 
>> It is also clear that the interval is to be added to that time.
> 
> 
> Not necessarily. It says it_interval is a "reload value", it's used to 
> reload the timer to count down to the next expiration.
> It's up to the implementation, whether it really counts down this time or 
> whether it converts it first into an absolute value.
> 
> 
>>IMHO then, the result should have the same property, i.e. ABS_TIME.  Sort of
>>like adding an offset to a relative address. The result is still relative.
> 
> 
> If the result is relative, why should have a clock set any effect?
> IMO the spec makes it quite clear that initial timer and the periodic 
> timer are two different types of the timer. The initial timer only 
> specifies how the periodic timer is started and the periodic timer itself 
> is a "relative time service".
> 
Well, I guess we will have to agree to disagree.  That which the 
interval is added to is an absolute time, so I, and others, take the 
result as absolute.  At this point there really is no "conversion" to 
an absolute timer.  Once the timer initial time is absolute, 
everything derived from it, i.e. all intervals added to it, must be 
absolute.

For what its worth, I do think that the standards folks could have 
done a bit better here.  I, for example, would have liked to have seen 
a discussion about what to do with overrun in the face of clock setting.


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
