Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbUAIVye (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUAIVyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:54:33 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:28917 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263891AbUAIVyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:54:23 -0500
Message-ID: <3FFF2304.8000403@mvista.com>
Date: Fri, 09 Jan 2004 13:54:12 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: kgdb cleanups
References: <20040109183826.GA795@elf.ucw.cz>
In-Reply-To: <20040109183826.GA795@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> No real code changes, but cleanups all over the place. What about
> applying?
> 
> Ouch and arch-dependend code is moved to kernel/kgdb.c. I'll probably
> do x86-64 version so that is rather important.
> 
> 								Pavel
A few comments:

I like the code seperation.  Does it follow what Amit is doing?  It would be 
nice if Amit's version and this one could come together around this.

I don't think we want to merge the eth and regular kgdb just yet.  I would, 
however, like to keep eth completly out of the stub.  Possibly a new module 
which just takes care of steering the I/O to the correct place.

I think we might want to try the bad sys call one more time.  If it triggers, a 
kernel fix is in order.  I don't see the point of removing it.  After all, the 
disable/enable on preempt really should be paired such that we never leave the 
kernel with a preempt count.

I have new dwarft stuff.  I actually have debug records that allow bt through 
interrupt code.  Working on the spin lock loops.  It is fine to drop these at 
this point as the new ones will replace them anyway.



-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

