Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272286AbTG3WwQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272290AbTG3WwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:52:16 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:61383 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S272286AbTG3WwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:52:09 -0400
Date: Thu, 31 Jul 2003 00:52:07 +0200 (MEST)
Message-Id: <200307302252.h6UMq7aw024159@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: johnstul@us.ibm.com
Subject: Re: [BUG] 2.6.0-test2 loses time on 486
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jul 2003 13:08:44 -0700, john stultz <johnstul@us.ibm.com> wrote:
>On Wed, 2003-07-30 at 12:19, Mikael Pettersson wrote:
>> On 29 Jul 2003 11:59:06 -0700, john stultz wrote:
>> >Hmm.  Sounds like you're loosing interrupts. This can happen due to
>> >poorly behaving drivers (disabling interrupts for too long), or odd
>> >hardware. The change from HZ=100 to HZ=1000 probably made this more
>> >visible on your box, so could you try setting HZ back to 100 and see if
>> >that helps (you may still lose time, but at a much slower rate). 
>> 
>> Yep, reducing HZ to 100 in param.h eliminated the time losses.
>
>Ok, that's what I figured. 
>
>> >Also what drivers are you running with?
>> 
>> IDE, no chipset driver, NE2000 ISA NIC (no traffic during the
>> tests), AT keyboard + PS/2 mouse (unused during the tests).
>> 
>> The only things I can think of are:
>> - a 486 simply cannot keep up with HZ=1000
>> - the plain IDE driver w/o chipset & DMA support somehow
>>   is much worse in 2.5/2.6 than in 2.4
>> - the "no TSC" time-keeping code is broken
>
>Well, I suspect its just the first. If you're not generating interrupts
>then I'm doubtful the IDE driver is at fault (although I'd believe it if
>you were losing time under load). Also the PIT based time source is
>pretty simple and hasn't functionally changed much (well, it has been
>moved around a bit). 
>
>It may be the timer interrupt has grown in cost since the argument to
>change HZ to 1000 was made. Although using the PIT there isn't much we
>do from a time of day perspective. If I can find a second, I'll see if I
>can compare interrupt overhead between 2.4 and 2.5. But I'd imagine the
>box would barely be usable if we're wasting all our time handling timer
>interrupts (is it usable??).

Well, the test the box was running (recompile 2.4.22-pre) generates
a lot of disk traffic, including swapping, since the box has so little
RAM (only 28M). So IDE interrupts are frequent and the box is both
CPU and I/O bound. I can still log in to it, type shell commands and
so on, but starting emacs would be a bad idea...
 
To test the "486 can't cope with HZ=1000" thesis I tried a RedHat
2.4.18-27.8 kernel which has a CONFIG_HZ option. Using 2.4.18-27.8
with CONFIG_HZ=1000, the box still lost time during the "recompile
2.4.22-pre" test, but only about 15 seconds per hour instead of 2
minutes per hour as it does with 2.6-test.

/Mikael
