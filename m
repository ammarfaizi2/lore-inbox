Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbWGNKfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWGNKfx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 06:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161029AbWGNKfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 06:35:53 -0400
Received: from mkedef1.rockwellautomation.com ([208.22.104.18]:4932 "EHLO
	ranasmtp01.ra.rockwell.com") by vger.kernel.org with ESMTP
	id S1161020AbWGNKfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 06:35:53 -0400
To: Kevin Hilman <khilman@deeprooted.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.17-rt add clockevent to ixp4xx
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF17E03102.B88C1774-ONC12571AB.003987F5-C12571AB.003A4830@ra.rockwell.com>
From: Milan Svoboda <msvoboda@ra.rockwell.com>
Date: Fri, 14 Jul 2006 12:36:20 +0200
X-MIMETrack: Serialize by Router on RANASMTP01/NorthAmerica/RA/Rockwell(Release 6.5.4FP1|June
 19, 2005) at 07/14/2006 05:36:41 AM,
	Serialize complete at 07/14/2006 05:36:41 AM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin,

> On Thu, 2006-07-13 at 10:53 +0000, Milan Svoboda wrote:
> 
> > there are patches that enable clock event on ixp4xx platform. This 
should
> > enable high resolution timers... Option for hrtimers in menuconfig is
> > also enabled.
> 
> Milan,
> 
> I've also done a clockevent driver for ixp4xx and it looks pretty much
> like yours.  I've been waiting to submit as Thomas has recently reworked
> the clockevent layer a bit in his -hrt-dyntick patchset.
> 
> Here are a couple comments on your patchset
> 
> - since you've registered the clockevent with CAP_TICK, both the
> arch interrupt handler and the clockevent handler are handling the tick
> and calling do_timer().  While I don't think this will negatively affect
> timekeeping, it's unncessary overhead.

Yeah, I had a headache from this mistake, I found it a few minutes
after sendig mail ;-)

> - why the addition of clockevent_hz2mult()? since shift is 32, you
> could use existing div_sc32()

I didn't know about div_sc32... Simply, I have no problem with using
div_sc32 now when I know that is exists ;-)

> The attached patch is a combination of my patch and yours and addresses
> my comments above.  I simply removed the CLOCK_CAP_TICK and removed your
> clockevent_hz2mult() and used div_sc32().
> 

Good.

> Also, below are a few runs of the nanosleep_jitter test that comes with
> the sourceforge HRT test suite.  Something strange is that with the
> nanosleep_jitter test, I only see max sleeps of ~300-400 usec but with
> your test I see max sleeps up to 1.3 msec.
> 

Maybe my test program is not as good as nanosleep_jitter :-)

I did patch against -hrt-dyntick (see lkml, this thread) wich is almost 
the same
as this one against -rt (for ixp4xx part only) and I found that when timer 
is
loaded with IXP4XX_OST_ONE_SHOT the latency time suddenly drops to ~30usec instead
of ~2000usec! I'd like know what's the reason for this...

Best regards,
Milan

