Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbTDDMKo (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 07:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbTDDMKn (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 07:10:43 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:5055 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263693AbTDDMHF (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 07:07:05 -0500
Date: Fri, 4 Apr 2003 13:18:12 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, jjs <jjs@tmsusa.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] acpi compile fix
Message-ID: <20030404121812.GA23352@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>,
	Linus Torvalds <torvalds@transmeta.com>, jjs <jjs@tmsusa.com>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	linux-kernel@vger.kernel.org
References: <20030403130505.199294c7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030403130505.199294c7.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 01:05:05PM -0800, Andrew Morton wrote:

 > diff -puN drivers/acpi/osl.c~acpi-spinlock-casts drivers/acpi/osl.c
 > --- 25/drivers/acpi/osl.c~acpi-spinlock-casts	Thu Apr  3 13:00:54 2003
 > +++ 25-akpm/drivers/acpi/osl.c	Thu Apr  3 13:01:25 2003
 > @@ -736,7 +736,7 @@ acpi_os_acquire_lock (
 >  	if (flags & ACPI_NOT_ISR)
 >  		ACPI_DISABLE_IRQS();
 >  
 > -	spin_lock(handle);
 > +	spin_lock((spinlock_t *)handle);

Is there a reason these functions can't just have their arguments
changed to take a spinlock_t* instead of an acpi_handle ?
That cast looks really fugly IMO.

		Dave

