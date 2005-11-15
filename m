Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbVKOTxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbVKOTxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVKOTxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:53:40 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:46224 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965016AbVKOTxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:53:39 -0500
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B10)
From: john stultz <johnstul@us.ibm.com>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <43796C76.8070603@tuxrocks.com>
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
	 <4378FFFF.4010706@tuxrocks.com> <1132004327.4668.30.camel@leatherman>
	 <4379074D.5060308@tuxrocks.com> <1132005736.4668.34.camel@leatherman>
	 <437918A0.8000308@tuxrocks.com> <1132010724.4668.40.camel@leatherman>
	 <43796C76.8070603@tuxrocks.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 11:53:34 -0800
Message-Id: <1132084415.2906.12.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-14 at 22:04 -0700, Frank Sorenson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> john stultz wrote:
> > Hrm.. How about sending a dmesg of just vanilla 2.6.14-mm2? Also does
> > the behavior change booting w/ idle=poll ?
> 
> idle=poll does seem to fix the major clock drift problem.  There may
> still be an issue, but it's much smaller:
> 
> 2.6.14-mm2-todb10:
> 14 Nov 21:50:57      offset: -0.025373       drift: -22404.0 ppm
> 14 Nov 21:51:59      offset: -1.577053       drift: -24985.4603175 ppm
> 14 Nov 21:53:00      offset: -3.104569       drift: -25012.9032258 ppm
> 
> 2.6.14-mm2-todb10 with idle=poll:
> 14 Nov 21:37:59      offset: 5.9e-05         drift: 63.0 ppm
> 14 Nov 21:39:00      offset: 0.003207        drift: 51.7903225806 ppm

Hmm. It seems the c3 compensation is triggering when it shouldn't, or
maybe its over compensating. 

I can't reproduce it on my laptop. Do you recall if in previous tests
you saw anything like this? I'm trying to narrow down if its just a
difference in hardware or if something in the c3 idle code changed.

thanks
-john


