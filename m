Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVBBCA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVBBCA2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 21:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVBBCA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 21:00:28 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:9415 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262202AbVBBCAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:00:20 -0500
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
From: john stultz <johnstul@us.ibm.com>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4200316C.2080709@am.sony.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <41FFFD4F.9050900@am.sony.com>
	 <1107298089.2040.184.camel@cog.beaverton.ibm.com>
	 <4200166A.6050309@am.sony.com>
	 <1107303548.2040.204.camel@cog.beaverton.ibm.com>
	 <4200316C.2080709@am.sony.com>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 18:00:16 -0800
Message-Id: <1107309617.2040.227.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 17:48 -0800, Tim Bird wrote:
> john stultz wrote:
> > Interesting patch. Indeed, the trade off is just how quickly you want to
> > boot vs how much drift you gain each suspend/resume cycle. Assuming all
> > of the clocks are good, your patch could introduce up to 2 seconds of
> > drift each suspend/resume cycle. 
> 
> If we're not writing to the RTC on suspend, then I believe the drift is
> capped.  For some consumer products, 2 seconds of drift is OK.
> 
> Nigel, does the RTC get written to, or just read, on suspend?

I'll let Nigel respond, but I don't believe so. The time code only
writes out to the CMOS every X-minutes if we're synced w/ the NTP
server.

> Also, I'm worried about the clock appearing to run backwards over a suspend.
> Unless a suspend/resume cycle took less than 1 second, I don't think this could
> happen.  Is that right?

Well (with my code, the existing code might be slightly different), on
suspend we read the persistent clock and we accumulate all the time that
has passed on the timesource. Then on resume we read the persistent
clock, the delta between persistent clock reads (which cannot be
negative unless the CMOS runs backwards) is added to the system time and
a new time interval is started from the current value of the
timesource. 

So, unless something tweaks the CMOS between reads, or the hardware has
problems, then time should not go backwards.

thanks
-john


