Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbVLAWNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbVLAWNY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 17:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVLAWNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 17:13:24 -0500
Received: from smtpout.mac.com ([17.250.248.87]:1516 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932517AbVLAWNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 17:13:23 -0500
In-Reply-To: <20051201135139.3d1c10df.akpm@osdl.org>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512010118200.1609@scrub.home> <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com> <Pine.LNX.4.61.0512011352590.1609@scrub.home> <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com> <20051201165144.GC31551@flint.arm.linux.org.uk> <20051201122455.4546d1da.akpm@osdl.org> <20051201211933.GA25142@elte.hu> <20051201135139.3d1c10df.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7D53372C-E138-4336-883F-A674BBBB09AA@mac.com>
Cc: Ingo Molnar <mingo@elte.hu>, rmk+lkml@arm.linux.org.uk,
       ray-gmail@madrabbit.org, zippel@linux-m68k.org, tglx@linutronix.de,
       linux-kernel@vger.kernel.org, george@mvista.com, johnstul@us.ibm.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch 00/43] ktimer reworked
Date: Thu, 1 Dec 2005 17:13:17 -0500
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 01, 2005, at 16:51, Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
>> we could merge the two by driving 'timeouts' via ktimers too - but  
>> there would be some unavoidable overhead to things like the TCP  
>> stack. But ktimers cannot be merged into timeouts, that's sure.
>
> I think you guys have an advantage over me because you've been  
> discussing and thinking about this terminology for months.  IOW,  
> your lips are moving but all I hear is blah, blah, blah ;)
>
> For instance, when Kyle came out with his one-sentence description  
> of timers versus timeouts, I thought he had them backwards.  Only  
> apparently he didn't.
>
> So either it's all confusing, or I'm dumb, or both.  I can evade  
> investigation of that by claiming that we should seek something  
> which is unconfusing to even dumb people.

I think part of this confusion was the little flamewar over naming.   
I think I can provide a succinct and simple description of this  
stuff, possibly as the start of some documentation:

In this patch there are two ways of setting up code to run at some  
point in the future: timers and timeouts.

A timeout (like waiting for somebody to answer the phone) is  
optimized to never happen (they will hopefully pick up first).  If  
everything works perfectly; it will be stopped before it has a chance  
to go off.

A timer (like a kitchen timer telling you the cookies are done) is  
optimized to be added and sit around until it expires.  You just  
don't turn off the timer and take the cookies out before they are done.

For the most part, you don't really care much about accuracy with a  
timeout.  It needs to happen no earlier than the specified time, but  
if it occurs a second late, so what?  The person might sit around  
waiting an extra few seconds for their friend to pick up, but that's  
not a major issue.  On the other hand, you really *do* care about how  
accurate your timer is.  If you wait an extra minute or two after the  
timer goes off before pulling the cookies from the oven, you have  
some rather inedible cookies.

> IOW: leave timer_lists alone.  Just add the needed new subsystem  
> and use it.

I think that this is a relatively useful distinction to make, and  
perhaps we _should_ rename the subsystem and educate developers about  
the difference between timers and timeouts.

Cheers,
Kyle Moffett

--
Debugging is twice as hard as writing the code in the first place.   
Therefore, if you write the code as cleverly as possible, you are, by  
definition, not smart enough to debug it.
   -- Brian Kernighan


