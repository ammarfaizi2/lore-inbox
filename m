Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTFSVoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 17:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTFSVoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 17:44:10 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:64901 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S261153AbTFSVoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 17:44:07 -0400
Subject: Re: matroxfb console oops in 2.4.2x
From: David Woodhouse <dwmw2@infradead.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org
In-Reply-To: <4E2D2240020@vcnet.vc.cvut.cz>
References: <4E2D2240020@vcnet.vc.cvut.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1056059885.2282.38.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Thu, 19 Jun 2003 22:58:05 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: VANDROVE@vc.cvut.cz, linux-kernel@vger.kernel.org, jsimmons@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-19 at 20:45, Petr Vandrovec wrote:
> On 19 Jun 03 at 14:47, David Woodhouse wrote:
> > On Thu, 2003-06-19 at 13:21, Petr Vandrovec wrote:
> 
> > take_over_console() attempts to redraw the screen.
> 
> It is not take_over_console... It does init first. 

Hmm. OK. For some reason my two-year-old GDB and KGDB between them
aren't giving me a sensible backtrace today so I can't see precisely
what's happening. I accused take_over_console because my vague memory of
a debugging printk session the other day led me to believe that was the
case.

take_over_console (actually update_region()) is definitely doing
_something_ bizarre... there have been 34 lines of printk output since
boot, and it's rendering the 34th line 34 times, one on each of the top
34 lines of the new console.

> > >  
> > matroxfb: Pixel PLL not locked after 5 secs
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   
> This one is culprit. If you'll comment this message out, it will not
> crash.

OK; I'll try that in the morning.

> > Console: switching to colour frame buffer device 160x64
> > fb0: MATROX VGA frame buffer device
> > 
> > If I call matrox_init_putc() earlier as you suggest, then it seems to
> > end up busy-waiting in mga_fifo()...
> 
> Ok. It means that hardware is completely uninitialized when this happens.
> Probably accelerator clocks are stopped (== message about pixclocks was
> right...) Bad.
> 
> Does driver work with your change without problems? 

Yes, it's fine. The hardware just seems to take a few seconds to
initialise after printing the console/matroxfb-related messages.

> It looks strange to me that PLL did not stabilized in 5 seconds. Do
> you get same message when you change videomode with fbset, or happens
> this only once during boot, and never again?

Answering that question will require compiling/obtaining fbset for SH3.
Tomorrow.

-- 
dwmw2


