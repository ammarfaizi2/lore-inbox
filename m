Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTDDTrV (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 14:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbTDDTrV (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 14:47:21 -0500
Received: from [12.47.58.55] ([12.47.58.55]:45075 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261276AbTDDTrU (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 14:47:20 -0500
Date: Fri, 4 Apr 2003 11:57:56 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: torvalds@transmeta.com, jjs@tmsusa.com, andrew.grover@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] acpi compile fix
Message-Id: <20030404115756.66d87211.akpm@digeo.com>
In-Reply-To: <20030404121812.GA23352@suse.de>
References: <20030403130505.199294c7.akpm@digeo.com>
	<20030404121812.GA23352@suse.de>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Apr 2003 19:58:43.0341 (UTC) FILETIME=[983CE3D0:01C2FAE4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> On Thu, Apr 03, 2003 at 01:05:05PM -0800, Andrew Morton wrote:
> 
>  > diff -puN drivers/acpi/osl.c~acpi-spinlock-casts drivers/acpi/osl.c
>  > --- 25/drivers/acpi/osl.c~acpi-spinlock-casts	Thu Apr  3 13:00:54 2003
>  > +++ 25-akpm/drivers/acpi/osl.c	Thu Apr  3 13:01:25 2003
>  > @@ -736,7 +736,7 @@ acpi_os_acquire_lock (
>  >  	if (flags & ACPI_NOT_ISR)
>  >  		ACPI_DISABLE_IRQS();
>  >  
>  > -	spin_lock(handle);
>  > +	spin_lock((spinlock_t *)handle);
> 
> Is there a reason these functions can't just have their arguments
> changed to take a spinlock_t* instead of an acpi_handle ?
> That cast looks really fugly IMO.
> 

I think acpi_handle_t is "an opaque type specific to the OS on which the APCI
code happens to be running".

It is presently `void *', implicitly pointing at a spinlock_t.

If the above guesses (I'd prefer not to look) are correct then

	struct acpi_handle_t {
		spinlock_t lock;
	};

would make a ton more sense.


