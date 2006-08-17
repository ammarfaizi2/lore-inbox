Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbWHQQOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWHQQOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 12:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbWHQQOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 12:14:00 -0400
Received: from arrakeen.ouaza.com ([212.85.152.62]:974 "EHLO
	arrakeen.ouaza.com") by vger.kernel.org with ESMTP id S964855AbWHQQN7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 12:13:59 -0400
Date: Thu, 17 Aug 2006 18:10:42 +0200
From: Raphael Hertzog <hertzog@debian.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: How to avoid serial port buffer overruns?
Message-ID: <20060817161042.GC10818@ouaza.com>
References: <20060816104559.GF4325@ouaza.com> <1155753868.3397.41.camel@mindpipe> <44E37095.9070200@microgate.com> <1155762739.7338.18.camel@mindpipe> <1155767066.2600.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1155767066.2600.19.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006, Paul Fulghum wrote:
> On Wed, 2006-08-16 at 17:12 -0400, Lee Revell wrote:
> > 2.6.15 and 2.6.16.  Here is the .config:
> 
> Alan's rework of the receive tty buffering went
> into 2.6.16 and cured some problems, but clearly not yours.
> Some more adjustments are in 2.6.18-rc4, so that
> would be interesting to try for diagnosing this.

I will try 2.6.18-rc4 and keep you informed.

> I was wondering if the problem was interrupt latency,
> the tty receive buffering, or something totally different.
> I don't know if your problem and Raphael's are caused
> by the same mechanism. I would still like to know which
> kernel versions he has tried.

I tried 2.6.17.7.

But I'm really not sure that the 2.6 is a regression from 2.4, in fact I
think it does better by default.

The stock 2.4.31 kernel I was using had serial overruns at 9600 bauds
already. Once patched with the low latency/preemptive kernel patchs, it
was way better and I had only overruns at 115200 bauds.

With the 2.6.17.7 kernel (configured with CONFIG_PREEMPT and
CONFIG_HZ=1000), I'm seeing overruns starting at 38400 bauds. So
compared to plain 2.4, it's better. However compared to the patched
2.4, it's worse.

(the figures are *very approximative* as the overruns haven't been
detected with the same test conditions on 2.4 and on 2.6)

I have no result with the 2.6.17.7 patched with the real time patch of
Ingo/Thomas since it currently doesn't work on my card (see my separate
bugreport).

(those questions may have been directed to Lee but I'll respond in my case
as well)
> Are you using the low_latency flag on the serial device?

I tried that option with the 2.4 kernel and it didn't improve the situation
at all, and I haven't retried it with the 2.6 yet. But I will do.

> What type of UART has been tested (16550? other?)

I'm using only 16550 and I have no choice here, it's an "off the shelf"
card.

> Are you seeing overruns or just lost data?

I'm seeing overruns.

Regards,
-- 
Raphaël Hertzog

Premier livre français sur Debian GNU/Linux :
http://www.ouaza.com/livre/admin-debian/
