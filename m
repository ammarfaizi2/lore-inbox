Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbTJ0SpV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 13:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTJ0SpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 13:45:21 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:38374 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263460AbTJ0SpR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 13:45:17 -0500
Subject: Re: ACPI PM-Timer [Was: Re: [RFC][PATCH] must fix lists]
From: john stultz <johnstul@us.ibm.com>
To: Dominik Brodowski <linux@brodo.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, albert@users.sourceforge.net
In-Reply-To: <20031027182416.GA3905@brodo.de>
References: <3F94C833.8040204@cyberone.com.au>
	 <1066943359.6102.14.camel@dhcp23.swansea.linux.org.uk>
	 <20031023172323.A10588@osdlab.pdx.osdl.net>
	 <1067113087.10272.4.camel@dhcp23.swansea.linux.org.uk>
	 <3F9D1557.4050404@cyberone.com.au>  <20031027182416.GA3905@brodo.de>
Content-Type: text/plain
Organization: 
Message-Id: <1067280154.1113.334.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Oct 2003 10:42:34 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-27 at 10:24, Dominik Brodowski wrote:
> On Mon, Oct 27, 2003 at 11:53:43PM +1100, Nick Piggin wrote:
> > +o alan, Albert Cahalan: 1000 HZ timer increases the need for a stable time
> > +  source. Many laptops, SMI can lose ticks. ACPI timers? TSC?
> 
> A few months ago, I proposed to make the ACPI "Powermanagement" timer, a 
> reliable timing source with  ~3.6MHz resolution, available as a timer_opts
> for arch/i386/kernel/timers/timer.c. [1]
> 
> The major difficulty with this ACPI PM-Timer is that the I/O-port it is
> located at is unknown during time_init.[2] So, it becomes necessary to use a
> different timing source in the beginning, and switch to the ACPI PM-Timer
> later.
> 
> Here are two different methods to replace one timing source with another.
> First, the simple (and buggy) one -- the timing is broken until the next
> timer "tick" == the next call to mark_offset().

Thanks for working on this, Dominik!  

My only comment is that rather then replacing the time source midstream,
could we not do as the HPET time source does and use the late_time_init
callback? That avoids the nasty time source switching code. 

thanks
-john

