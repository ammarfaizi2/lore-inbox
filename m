Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263445AbTJ0TCL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 14:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTJ0TCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 14:02:10 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:44953 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263445AbTJ0TCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 14:02:08 -0500
Date: Mon, 27 Oct 2003 19:49:08 +0100
From: Dominik Brodowski <linux@brodo.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, albert@users.sourceforge.net
Subject: Re: ACPI PM-Timer [Was: Re: [RFC][PATCH] must fix lists]
Message-ID: <20031027184908.GA4240@brodo.de>
References: <3F94C833.8040204@cyberone.com.au> <1066943359.6102.14.camel@dhcp23.swansea.linux.org.uk> <20031023172323.A10588@osdlab.pdx.osdl.net> <1067113087.10272.4.camel@dhcp23.swansea.linux.org.uk> <3F9D1557.4050404@cyberone.com.au> <20031027182416.GA3905@brodo.de> <1067280154.1113.334.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067280154.1113.334.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 10:42:34AM -0800, john stultz wrote:
> On Mon, 2003-10-27 at 10:24, Dominik Brodowski wrote:
> > On Mon, Oct 27, 2003 at 11:53:43PM +1100, Nick Piggin wrote:
> > > +o alan, Albert Cahalan: 1000 HZ timer increases the need for a stable time
> > > +  source. Many laptops, SMI can lose ticks. ACPI timers? TSC?
> > 
> > A few months ago, I proposed to make the ACPI "Powermanagement" timer, a 
> > reliable timing source with  ~3.6MHz resolution, available as a timer_opts
> > for arch/i386/kernel/timers/timer.c. [1]
> > 
> > The major difficulty with this ACPI PM-Timer is that the I/O-port it is
> > located at is unknown during time_init.[2] So, it becomes necessary to use a
> > different timing source in the beginning, and switch to the ACPI PM-Timer
> > later.
> > 
> > Here are two different methods to replace one timing source with another.
> > First, the simple (and buggy) one -- the timing is broken until the next
> > timer "tick" == the next call to mark_offset().
> 
> Thanks for working on this, Dominik!  
> 
> My only comment is that rather then replacing the time source midstream,
> could we not do as the HPET time source does and use the late_time_init
> callback? That avoids the nasty time source switching code. 

Because "late_time_init" is way too early. It might be usable for the
(unimplemented) detection method c) -- parsing the ACPI FADT ourselves --
described in the timer_pm.c code.
However, the currently used method uses struct acpi_fadt which is
filled in drivers/acpi/bus.c:acpi_bus_init(), which is called from 
a subsys_initcall.

	Dominik
