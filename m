Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVHITYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVHITYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 15:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVHITYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 15:24:44 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:50351 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S932188AbVHITYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 15:24:43 -0400
Date: Tue, 9 Aug 2005 21:24:37 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Ian Campbell <icampbell@arcom.com>
Cc: Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>,
       linux-kernel@vger.kernel.org
Subject: Re: deactivating PXA255 watchdog
Message-ID: <20050809192437.GJ499@infomag.infomag.iguana.be>
References: <1117700284.3063.51.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117700284.3063.51.camel@icampbell-debian>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

> I think you are the current "watchdog guy", although watchdog doesn't
> have a MAINTAINERS entry so I'm looking at bk/lkml history etc and might
> be mistaken...

Sorry for the late response. I indeed try to maintain the watchdog drivers
and get a uniform API for all the watchdog drivers.

> I wrote to the the linux-arm-kernel mailing list recently with a query
> because the sa1100_wdt code supports the writing 'V' to deactivate the
> watchdog thing, but unfortunately once armed the hardware cannot be
> deactivated. 
> 
> I was going to produce a patch to remove the 'V' support and it was
> suggested by Russell that I should ask for your opinion. Do you have a
> preference with regards to offering a warning or error etc if a 'V' is
> written?
> 
> My original message is below. I have had confirmation that the SA1100
> has the same behaviour as PXA2xx from Nico.

the actual problem you have is not the magic char 'V' that needs to be
written to safely stop the watchdog. The problem is that your watchdog
can not be stopped once started.
What we should do (in my opinion) is to add a timer like done in
mixcomwd.c. What this timer does is ping/tickle the watchdog internally
when the watchdog is supposed to be not active. (So it starts pinging
the watchdog after userspace stopped/released /dev/watchdog and it stops
again when the userspace opens /dev/atchdog again).
The writing of the magic char V is a failsafe mechanism for if the 
watchdog daemon would crash and close /dev/watchdog when it is supposed
to keep working...

Greetings,
Wim.

