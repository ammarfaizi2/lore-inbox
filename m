Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVBBCVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVBBCVF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 21:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVBBCVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 21:21:05 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:44945 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262206AbVBBCUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:20:55 -0500
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: John Stultz <johnstul@us.ibm.com>
Cc: Tim Bird <tim.bird@am.sony.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1107309617.2040.227.camel@cog.beaverton.ibm.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <41FFFD4F.9050900@am.sony.com>
	 <1107298089.2040.184.camel@cog.beaverton.ibm.com>
	 <4200166A.6050309@am.sony.com>
	 <1107303548.2040.204.camel@cog.beaverton.ibm.com>
	 <4200316C.2080709@am.sony.com>
	 <1107309617.2040.227.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1107310940.13413.78.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 02 Feb 2005 13:23:05 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-02-02 at 13:00, john stultz wrote:
> On Tue, 2005-02-01 at 17:48 -0800, Tim Bird wrote:
> > john stultz wrote:
> > > Interesting patch. Indeed, the trade off is just how quickly you want to
> > > boot vs how much drift you gain each suspend/resume cycle. Assuming all
> > > of the clocks are good, your patch could introduce up to 2 seconds of
> > > drift each suspend/resume cycle. 
> > 
> > If we're not writing to the RTC on suspend, then I believe the drift is
> > capped.  For some consumer products, 2 seconds of drift is OK.
> > 
> > Nigel, does the RTC get written to, or just read, on suspend?
> 
> I'll let Nigel respond, but I don't believe so. The time code only
> writes out to the CMOS every X-minutes if we're synced w/ the NTP
> server.

Yes, just read.

> > Also, I'm worried about the clock appearing to run backwards over a suspend.
> > Unless a suspend/resume cycle took less than 1 second, I don't think this could
> > happen.  Is that right?
> 
> Well (with my code, the existing code might be slightly different), on
> suspend we read the persistent clock and we accumulate all the time that
> has passed on the timesource. Then on resume we read the persistent
> clock, the delta between persistent clock reads (which cannot be
> negative unless the CMOS runs backwards) is added to the system time and
> a new time interval is started from the current value of the
> timesource. 
> 
> So, unless something tweaks the CMOS between reads, or the hardware has
> problems, then time should not go backwards.

Sounds good.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

