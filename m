Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263662AbUDFInH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 04:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbUDFInH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 04:43:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53774 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263662AbUDFInD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 04:43:03 -0400
Date: Tue, 6 Apr 2004 09:42:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4: disabling SCSI support not possible
Message-ID: <20040406094258.A15945@flint.arm.linux.org.uk>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org
References: <406D65FE.9090001@broadnet-mediascape.de> <6uad1uv7kr.fsf@zork.zork.net> <20040402144216.A12306@flint.arm.linux.org.uk> <20040402165941.GA29046@kroah.com> <20040402181630.B12306@flint.arm.linux.org.uk> <c4slos$6tq$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <c4slos$6tq$1@gatekeeper.tmr.com>; from davidsen@tmr.com on Mon, Apr 05, 2004 at 06:17:14PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 06:17:14PM -0400, Bill Davidsen wrote:
> Intuitive isn't the issue, if you can't figure out why you can't turn 
> off SCSI, you leave it on, which you need to make USB storage work. If 
> you're trying to make a small kernel you presumably would have turned 
> off USB if you didn't want it. The other way, if you can turn on USB w/o 
> SCSI, it won't work, and people thing Linux is broken.

When I hit it, I was trying to build a kernel for test purposes, so I
didn't want all the drivers turned on.  I found I couldn't turn off
SCSI and continued anyway turning other things off.  However, USB appears
_after_ SCSI, you can not go through the configuration logically to turn
off features.  Moreover, you do not get any suggestion when attempting
to turn SCSI off that you need to turn off USB.

> Chances are that most people wouldn't have USB on if they didn't want 
> it, but there's no downside to doing this.

The x86 default configuration has USB + USB Storage turned on.  It makes
it _non-trivial_ to turn SCSI off unless you have prior knowledge that
you need to turn USB off before hand.

> > (b) have kconfig tell you why you can't turn off the option.
> 
> I thought that was what (a) did.

No - the configuration system just doesn't let you turn SCSI off.  No
complaint, no warning, no nothing.  It just won't change the symbol.

> > Silently preventing options being turned off with no obvious reason
> > is a pretty major misfeature.
> 
> Compared to enabling USB storage with no hope of having it work? Adding 
> user info is desirable, but making it easy, or even possible, to build a 
>   non-working config is a lot more of a problem. You haven't compiled on 
> a slow machine lately, forcing config combinations which work is a 
> benefit of kconfig.

Umm, you're talking to an ARM developer who builds some kernels natively.
I suspect that your definition of "slow" is actually faster than my
definition of the same.

> If you want it broken you have to edit the config code. That's a good thing.

Read what I'm saying.  *Silently* preventing options being turned off
with *no* *obvious* *reason* is a pretty major misfeature.

I hope the emphasis will highlight the problem more clearly.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
