Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVBAXMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVBAXMh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVBAXMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:12:37 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:23789 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262154AbVBAXMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:12:20 -0500
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: John Stultz <johnstul@us.ibm.com>
Cc: Tim Bird <tim.bird@am.sony.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1107298089.2040.184.camel@cog.beaverton.ibm.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <41FFFD4F.9050900@am.sony.com>
	 <1107298089.2040.184.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1107299672.13413.25.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 02 Feb 2005 10:14:32 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John and Tim.

On Wed, 2005-02-02 at 09:48, john stultz wrote:
> > I didn't scan for all uses of read_persistent_clock, but
> > in my experience get_cmos_time() has a latency of up to
> > 1 second on x86 because it synchronizes with the rollover
> > of the RTC seconds.
> 
> I believe you're right. Although we don't call read_persistent_clock()
> very frequently, nor do we call it in ways we don't already call
> get_cmos_time(). So I'm not sure exactly what the concern is.

Tim and I talked about this at the recent CELF conference. I have a
concern in that suspend-to-disk calls the suspend methods and then
(after the atomic copy) the resume methods. Since the copy usually takes
< 1s, and the suspend and resume methods both make two calls to
get_coms_time, that's an average of 1.5s per suspend call and 1.5s per
resume call - but if the copy does take next to no time (as normal),
it's really 1.5s + 2s = 3.5s average just for getting the time. I
believe Tim has similar issues in code he is working on. It's a concern
if your battery is running out and you're trying to hibernate!

[...]

> I've only lightly tested the suspend code, but on my system I didn't see
> very much drift appear. Regardless, it should be better then what the
> current suspend/resume code does, which doesn't keep any sub-second
> resolution across suspend.

My question is, "Is there a way we can get sub-second resolution without
waiting for the start of a new second four times in a row?" I'm sure
there must be.

Regards,

Nigel

-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

