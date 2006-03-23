Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWCWVjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWCWVjx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWCWVjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:39:52 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:19286 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932181AbWCWVjw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:39:52 -0500
Date: Thu, 23 Mar 2006 14:40:28 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Randy Vinson <rvinson@mvista.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       "Mark A.Greer" <mgreer@mvista.com>
Subject: Re: [PATCH, RFC] Stop using tasklet in ds1374 RTC driver
Message-ID: <20060323214028.GB21477@mag.az.mvista.com>
References: <20060323201030.ccded642.khali@linux-fr.org> <4423084B.1070701@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4423084B.1070701@mvista.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 01:42:51PM -0700, Randy Vinson wrote:
> Jean Delvare wrote:
> >Hi all,
> >
> >I have the following patch, which addresses a might-sleep-in-tasklet
> >issue in the ds1374 driver. I'm not too sure if the new code is right
> >or not, as I have never been using workqueues before, and I also don't
> >have a DS1374 chip to test my changes on.
> >
> >Can anyone comment on the patch and tell me if anything is wrong?
> >
> >Can anyone with a DS1374 chip please test it?
> 
> I've attached a similar patch that has been tested using the DS1374 on the 
> Freescale MPC8349MDS reference system. It is patterned after a similar 
> change made to the m41t00 driver. The changes work, but I am also 
> unfamiliar with workqueues, so my patch may not be any better.

I'm no expert in workqueues either; however, after reading
http://lwn.net/Articles/23634/, I believe that its unnecessary for an
rtc driver to have its own workqueue since rtc writes aren't particularly
time-critical.  If I am correct, then Randy's patch uses the proper wq calls.  

Agree?

Mark
