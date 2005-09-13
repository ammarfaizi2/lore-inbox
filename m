Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbVIMRfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbVIMRfE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbVIMRfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:35:03 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:36294 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964920AbVIMRfA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:35:00 -0400
Subject: Re: HZ question
From: john stultz <johnstul@us.ibm.com>
To: markh@compro.net
Cc: George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4326EAD7.50004@compro.net>
References: <4326CAB3.6020109@compro.net>
	 <Pine.LNX.4.61.0509130919390.29445@chaos.analogic.com>
	 <4326DB8A.7040109@compro.net>
	 <Pine.LNX.4.53.0509131615160.13574@gockel.physik3.uni-rostock.de>
	 <4326EAD7.50004@compro.net>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 10:34:16 -0700
Message-Id: <1126632856.3455.45.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 11:05 -0400, Mark Hounschell wrote:
> Tim Schmielau wrote:
> > On Tue, 13 Sep 2005, Mark Hounschell wrote:
> > 
> >>Most if not all userland delay calls rely on HZ value in some way or
> >>another. The minimum reliable delay you can get is one (kernel)HZ. A
> >>program that needs an acurrate delay for a time shorter that one
> >>(kernel)HZ may have an alternative if it knows that HZ is greater the
> >>the requested delay.
> > 
> > Just assume that kernel HZ are USER_HZ and see anything else as an
> > additional bonus that you cannot rely on.
> > 
> > What does 'acurrate delay' mean, anyways?
> > 
> > Tim
> > 
> 
> But they are not the same. Why can I get USER_HZ but not HZ?

Because USER_HZ is there only because HZ changes on various systems and
we don't want to break userland apps that assume its value.


> On a 100HZ kernel ANY requested delay via udelay or 
> pthread_cond_timedwait of less than 10000usecs is unreliable and the the 
> actual results are totally unacceptable.
> 
> On a 1000HZ kernel the number is 1000 usecs.
> 
> I'm not asking the kernel running at 1000hz to actually give me 500 usec 
> delay if I ask. I do expect it to be at least 500 usec and within +- a 
> single HZ however. Oviously a 1000HZ machine is going to give me better 
> resulution in any requested delay. Why is it unreasonable for userland 
> to know the probable resolution of userland delay requests.

But you don't really want to know HZ, you want to know timer resolution.
That's a reasonable request and I believe the posix-timers
clock_getres() interface might provide what you need. Although I'd defer
to George (CC'ed) since he's more of an expert on those interfaces.

You might also want to check out his HRT patches.

thanks
-john


