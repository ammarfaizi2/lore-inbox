Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273335AbTG3TT5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273336AbTG3TT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:19:57 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:50361 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S273335AbTG3TTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:19:51 -0400
Date: Wed, 30 Jul 2003 21:19:48 +0200 (MEST)
Message-Id: <200307301919.h6UJJmMd020595@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: johnstul@us.ibm.com
Subject: Re: [BUG] 2.6.0-test2 loses time on 486
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jul 2003 11:59:06 -0700, john stultz wrote:
>On Tue, 2003-07-29 at 10:34, Mikael Pettersson wrote:
>> My old 486 test box is losing time at an alarming rate
>> when running 2.6.0-test kernels. It loses almost 2 minutes
>> per hour, less if it sits idle. This problem does not
>> occur when it's running a 2.4 kernel.
>> 
>> There's nothing noteworthy in dmesg.
>> 
>> This has been going on since at least the 2.5.7x kernels,
>> and possible also the 2.5.6x kernels. I strongly suspect
>> a bug in the time-keeping changes in late 2.5 kernels.
>> The 486 has no TSC, and I don't have an NTP server to
>> keep my machines' times in sync.
>
>Hmm.  Sounds like you're loosing interrupts. This can happen due to
>poorly behaving drivers (disabling interrupts for too long), or odd
>hardware. The change from HZ=100 to HZ=1000 probably made this more
>visible on your box, so could you try setting HZ back to 100 and see if
>that helps (you may still lose time, but at a much slower rate). 

Yep, reducing HZ to 100 in param.h eliminated the time losses.

>Also what drivers are you running with?

IDE, no chipset driver, NE2000 ISA NIC (no traffic during the
tests), AT keyboard + PS/2 mouse (unused during the tests).

The only things I can think of are:
- a 486 simply cannot keep up with HZ=1000
- the plain IDE driver w/o chipset & DMA support somehow
  is much worse in 2.5/2.6 than in 2.4
- the "no TSC" time-keeping code is broken

/Mikael
