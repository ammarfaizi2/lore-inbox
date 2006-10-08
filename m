Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWJHTD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWJHTD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 15:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWJHTD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 15:03:28 -0400
Received: from www.osadl.org ([213.239.205.134]:53181 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751342AbWJHTD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 15:03:26 -0400
Subject: Re: + clocksource-increase-initcall-priority.patch added to -mm
	tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160327879.3693.97.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <200610070153.k971ren4020838@shell0.pdx.osdl.net>
	 <1160294812.22911.8.camel@localhost.localdomain>
	 <1160302797.22911.37.camel@localhost.localdomain>
	 <1160319033.3693.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160319234.5686.12.camel@localhost.localdomain>
	 <1160322317.3693.47.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160323127.5686.37.camel@localhost.localdomain>
	 <1160324288.3693.71.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160326363.5686.48.camel@localhost.localdomain>
	 <1160327879.3693.97.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 21:03:25 +0200
Message-Id: <1160334205.5686.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 10:17 -0700, Daniel Walker wrote:
> There was a special case inside kernel/time/clocksource.c to prevent
> clock switching during boot up. If you remove that (which I have) then
> you will end up with clock switching happening a few times during bootup
> (whenever a new highest rated clock is registered), that's the churn I'm
> referring to.
> 
> The churn is not optimal. I've used postcore to prevent it, and make the
> API usable earlier. So there is a reason for the change. 

Yes, a bad one. The disabling had a totally different reason and you are
not listening at all.

You just introduce a problem again, because it does not happen on your
machines and you think, that some not yet available instrumentation code
needs high resolution time stamps. 

The reason why this was delayed into late boot is simply that the
unstable, unsynchronized TSC's made way too much trouble and the pmtimer
can not be initialized early.

I'm not going to accept that. Your change might work on 5 machines you
have tested on, but we start over with the same breakage we solved
already. 

This early boot instrumentation code can work with low resolution time
information quite well and none of the boot code does need any high res
time information. Boot code is different from a running system and has
different requirements. 

This is a solution for a nonexisting problem, which just brings back
already solved ones.

	tglx



