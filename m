Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVEWUUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVEWUUN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 16:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVEWUUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 16:20:13 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:39101 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261943AbVEWUUG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 16:20:06 -0400
Message-ID: <42923B19.7070306@tmr.com>
Date: Mon, 23 May 2005 16:20:41 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Andi Kleen <ak@muc.de>, Dave Jones <davej@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: tickle nmi watchdog whilst doing serial writes.
References: <20050513184806.GA24166@redhat.com> <m1u0l4afdx.fsf@muc.de> <20050515130742.A29619@flint.arm.linux.org.uk> <m1ekc8adfl.fsf@muc.de> <428BDCAD.2090307@mvista.com> <20050519083338.A28946@flint.arm.linux.org.uk>
In-Reply-To: <20050519083338.A28946@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, May 18, 2005 at 05:24:13PM -0700, George Anzinger wrote:
> 
>>Um... I would think the real fix is to set the UART up to generate the modem 
>>status interrupt and eliminate the pole loop.  Why can't this be done?  I, for 
>>one, don't want my cpu looping in the serial driver, even more so with the 
>>interrupt system off.  This, in my mind, is a real bug in the serial driver and 
>>should be so handled.
> 
> 
> Because printk is *synchronous*.  It never returns until it's written
> the entire message.  There is no buffering.
> 
> Extra complexity, adding reliance on interrupts, etc all means that
> you reduce the probability that you'll get the panic or oops message
> out of the system.
> 
This is a fine reason to loop in the serial code, I guess, but what's 
the reason for allowing the NMI oops? Having use of the serial console 
to catch an oops actually CAUSE an oops doesn't seem desirable, and is 
probably more likely than a hardlock in the serial driver.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
