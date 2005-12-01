Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbVLAVwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbVLAVwq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVLAVwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:52:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8913 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932501AbVLAVwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:52:45 -0500
Date: Thu, 1 Dec 2005 13:51:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: rmk+lkml@arm.linux.org.uk, ray-gmail@madrabbit.org, zippel@linux-m68k.org,
       mrmacman_g4@mac.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
       george@mvista.com, johnstul@us.ibm.com
Subject: Re: [patch 00/43] ktimer reworked
Message-Id: <20051201135139.3d1c10df.akpm@osdl.org>
In-Reply-To: <20051201211933.GA25142@elte.hu>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
	<Pine.LNX.4.61.0512010118200.1609@scrub.home>
	<23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
	<Pine.LNX.4.61.0512011352590.1609@scrub.home>
	<2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com>
	<20051201165144.GC31551@flint.arm.linux.org.uk>
	<20051201122455.4546d1da.akpm@osdl.org>
	<20051201211933.GA25142@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> we could merge the two by driving 'timeouts' via ktimers too - but there 
>  would be some unavoidable overhead to things like the TCP stack. But 
>  ktimers cannot be merged into timeouts, that's sure.

I think you guys have an advantage over me because you've been discussing
and thinking about this terminology for months.  IOW, your lips are moving
but all I hear is blah, blah, blah ;) 

For instance, when Kyle came out with his one-sentence description of
timers versus timeouts, I thought he had them backwards.  Only apparently
he didn't.

So either it's all confusing, or I'm dumb, or both.  I can evade
investigation of that by claiming that we should seek something which is
unconfusing to even dumb people.

We have timer_lists.  But you say they don't suit precision timers.  Fine. 
So why cannot we call the new precision timers something like "precision
timers" and avoid this semantic confusion over timeouts versus timers?

IOW: leave timer_lists alone.  Just add the needed new subsystem and use it.

I guess old-timers can mentally do s/ktimeout/timer_list/ whenever they
come across the danged thing, but it's a bit painful.  If we called them
"timer_list" and "hrtimer", things would be much clearer.  Plus that's a
description of what they *are*, rather than of how we expect them to be
applied.
