Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272229AbTG3UQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 16:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272230AbTG3UQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 16:16:55 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:15002 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S272229AbTG3UQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 16:16:53 -0400
Subject: Re: [BUG] 2.6.0-test2 loses time on 486
From: john stultz <johnstul@us.ibm.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200307301919.h6UJJmMd020595@harpo.it.uu.se>
References: <200307301919.h6UJJmMd020595@harpo.it.uu.se>
Content-Type: text/plain
Organization: 
Message-Id: <1059595723.14766.105.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Jul 2003 13:08:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-30 at 12:19, Mikael Pettersson wrote:
> On 29 Jul 2003 11:59:06 -0700, john stultz wrote:
> >Hmm.  Sounds like you're loosing interrupts. This can happen due to
> >poorly behaving drivers (disabling interrupts for too long), or odd
> >hardware. The change from HZ=100 to HZ=1000 probably made this more
> >visible on your box, so could you try setting HZ back to 100 and see if
> >that helps (you may still lose time, but at a much slower rate). 
> 
> Yep, reducing HZ to 100 in param.h eliminated the time losses.

Ok, that's what I figured. 

> >Also what drivers are you running with?
> 
> IDE, no chipset driver, NE2000 ISA NIC (no traffic during the
> tests), AT keyboard + PS/2 mouse (unused during the tests).
> 
> The only things I can think of are:
> - a 486 simply cannot keep up with HZ=1000
> - the plain IDE driver w/o chipset & DMA support somehow
>   is much worse in 2.5/2.6 than in 2.4
> - the "no TSC" time-keeping code is broken

Well, I suspect its just the first. If you're not generating interrupts
then I'm doubtful the IDE driver is at fault (although I'd believe it if
you were losing time under load). Also the PIT based time source is
pretty simple and hasn't functionally changed much (well, it has been
moved around a bit). 

It may be the timer interrupt has grown in cost since the argument to
change HZ to 1000 was made. Although using the PIT there isn't much we
do from a time of day perspective. If I can find a second, I'll see if I
can compare interrupt overhead between 2.4 and 2.5. But I'd imagine the
box would barely be usable if we're wasting all our time handling timer
interrupts (is it usable??).

thanks
-john




