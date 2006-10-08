Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWJHRSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWJHRSE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 13:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWJHRSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 13:18:04 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:28599 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751286AbWJHRSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 13:18:01 -0400
Subject: Re: + clocksource-increase-initcall-priority.patch added to -mm
	tree
From: Daniel Walker <dwalker@mvista.com>
To: tglx@linutronix.de
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160326363.5686.48.camel@localhost.localdomain>
References: <200610070153.k971ren4020838@shell0.pdx.osdl.net>
	 <1160294812.22911.8.camel@localhost.localdomain>
	 <1160302797.22911.37.camel@localhost.localdomain>
	 <1160319033.3693.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160319234.5686.12.camel@localhost.localdomain>
	 <1160322317.3693.47.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160323127.5686.37.camel@localhost.localdomain>
	 <1160324288.3693.71.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160326363.5686.48.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 10:17:59 -0700
Message-Id: <1160327879.3693.97.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 18:52 +0200, Thomas Gleixner wrote:
> On Sun, 2006-10-08 at 09:18 -0700, Daniel Walker wrote:
> > > Early bootup Instrumentation is really not a good argument to make that
> > > fragile time related stuff even more complex. There is no problem to
> > > register reliable clocksources in early bootup, but do not make this
> > > mandatory. Not every system is an ARM SoC, where you can and must rely
> > > on the one source which is available usually right when the CPU comes
> > > up.
> > 
> > It's not mandatory, it's just preferred.. As I said above, to avoid
> > churn. I don't like the churn at boot up, and I tried to make sure there
> > was none added in the patch set. 
> 
> What churn at bootup ? The clocksources _can_ be switched and it does
> not matter, when this is done. We had the trouble with the early
> registration a couple of month ago, and there is no reason to
> reintroduce it. On systems which have exactly one clocksource, you can
> register them early in bootup, but please do not touch the x86 setup for
> no good reason.

There was a special case inside kernel/time/clocksource.c to prevent
clock switching during boot up. If you remove that (which I have) then
you will end up with clock switching happening a few times during bootup
(whenever a new highest rated clock is registered), that's the churn I'm
referring to.

The churn is not optimal. I've used postcore to prevent it, and make the
API usable earlier. So there is a reason for the change. 

Daniel

