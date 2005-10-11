Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVJKHkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVJKHkw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 03:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbVJKHkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 03:40:52 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:53190
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750718AbVJKHkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 03:40:51 -0400
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, Andrew Morton <akpm@osdl.org>,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com,
       Christoph Hellwig <hch@infradead.org>, oleg@tv-sign.ru,
       tim.bird@am.sony.com
In-Reply-To: <Pine.LNX.4.61.0510100213480.3728@scrub.home>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509301825290.3728@scrub.home>
	 <1128168344.15115.496.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0510100213480.3728@scrub.home>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 11 Oct 2005 09:42:37 +0200
Message-Id: <1129016558.1728.285.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-10 at 19:22 +0200, Roman Zippel wrote:
> > The above gives a clear distinction between scalar and sec/nsec based
> > cases. So you cannot mess up without notice. 
> 
> There are enough macros to do this anyway. There are a number of 
> operations which are identical. Separating them artifically makes 
> everything only more complicated.

I don't see a distinct set of macros around which is providing all the
functionality.

> > As far as I understand SUS timer resolution is equal to clock resolution
> > and the timer value/interval is rounded up to the resolution.
> 
> Please check the rationale about clocks and timers. It talks about clocks 
> and timer services based on them and their resolutions can be different.

clock_settime():
... Time values that are between two consecutive non-negative integer
multiples of the resolution of the specified clock shall be truncated
down to the smaller multiple of the resolution.

timer_settime():
...Time values that are between two consecutive non-negative integer
multiples of the resolution of the specified timer shall be rounded up
to the larger multiple of the resolution. Quantization error shall not
cause the timer to expire earlier than the rounded time value.

> > Reprogramming interval timers by now + interval is completely wrong.
> > Reprogramming has to be 
> > timer->expires + interval and nothing else. 
> 
> Where do get the requirement for an explicit rounding from?
> The point is that the timer should not expire early, but there is more 
> than one way to do this and can be done implicitly using the timer 
> resolution.

See above.

tglx


