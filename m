Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWDTWTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWDTWTV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWDTWTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:19:21 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:27287 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932080AbWDTWTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:19:20 -0400
Date: Fri, 21 Apr 2006 00:18:57 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Lee Revell <rlrevell@joe-job.com>
cc: Michael Monnerie <michael.monnerie@it-management.at>,
       linux-kernel@vger.kernel.org
Subject: Re: rtc: lost some interrupts at 256Hz
In-Reply-To: <1145566983.5412.31.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0604210012530.28841@yvahk01.tjqt.qr>
References: <200604202237.34134@zmi.at> <1145566983.5412.31.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 20 2006 16:57, linux-os (Dick Johnson) wrote:
>On Thu, 20 Apr 2006, Michael Monnerie wrote:
>
>> When you google for such messages, you can find a lot of people asking,
>> but nobody seems to have an answer. That's why I ask this list, where
>> the Godfathers Of Linux reside, and maybe someone hears my prayer and
>> could explain us sheep what you should do in such a case. Increase the
>> HZ from 250 to 1000, or decrease to 100? Or maybe setting the
>> preemption model from server to voluntary or preemptible? Or is that
>> whining to be ignored, and if yes, what is this message for at all?
>>
>> Please give us wisdom, and we will spread your word. Amen.
>>
>> Answers please per PM, I'm not on this list.
>
>If you are losing interrupts at 256 Hz, you have either/or:
>(1) Some very BAD driver that is disabling interrupts for way too long.
>(2) Some very slow CPU (like 40 Mhz) that is being overwhelmed by a lot of
>network interrupt activity.

On Apr 20 2006 17:03, Lee Revell wrote:
>Date: Thu, 20 Apr 2006 17:03:02 -0400
>Changing the preemption model to voluntary or full preemption could
>certainly help.  What app is using the RTC, mplayer?


I see this message too. (And I've got some more details).

Whenever I switch from console to X, I get that message. I presume it is 
due the binary nvidia blob I have loaded, because when switching to X, 
even the sound gets distorted for a microsecond (the well-known the 
soundcard replays the sound buffer - no new data transferred to it).
Yeah, looks like something's keeping IRQ disabled for quite a while.
(My normal freq is 100 Hz + no preemption, if that makes any difference.)

I have not yet seen this on the free nv driver for Xorg or the (free) 
ati/Xorg. Same configuration (100 Hz, no preempt), though!

Does not really matter what userspace app is running. If it's mplayer the 
message is "rtc: lost some interrupts at 1024Hz.", and if it's VMware it's 
whatever the Guest OS requires, mostly 2000 or 200 Hz.


Jan Engelhardt
-- 
