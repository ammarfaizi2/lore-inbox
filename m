Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVDDN6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVDDN6b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 09:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVDDN6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 09:58:31 -0400
Received: from users.ccur.com ([208.248.32.211]:23057 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S261237AbVDDN62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 09:58:28 -0400
Date: Mon, 4 Apr 2005 09:58:16 -0400
From: Joe Korty <joe.korty@ccur.com>
To: P@draigBrady.com
Cc: Jonathan Lundell <linux@lundell-bros.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: x86 TSC time warp puzzle
Message-ID: <20050404135816.GA2876@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <p06230505be73a5c345c7@[10.2.3.6]> <425101EA.7080001@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425101EA.7080001@draigBrady.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 09:59:22AM +0100, P@draigBrady.com wrote:
> Jonathan Lundell wrote:
> >Well, not actually a time warp, though it feels like one.
> >
> >I'm doing some real-time bit-twiddling in a driver, using the TSC to 
> >measure out delays on the order of hundreds of nanoseconds. Because I 
> >want an upper limit on the delay, I disable interrupts around it.
> >
> >The logic is something like:
> >
> >    local_irq_save
> >    out(set a bit)
> >    t0 = TSC
> >    wait while (t = (TSC - t0)) < delay_time
> >    out(clear the bit)
> >    local_irq_restore
> >
> > From time to time, when I exit the delay, t is *much* bigger than 
> >delay_time. If delay_time is, say, 300ns, t is usually no more than 
> >325ns. But every so often, t can be 2000, or 10000, or even much higher.
> >
> >The value of t seems to depend on the CPU involved, The worst case is 
> >with an Intel 915GV chipset, where t approaches 500 microseconds (!).


Add nmi_watchdog=0 to your boot command line.
