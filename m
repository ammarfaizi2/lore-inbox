Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbUCEGor (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 01:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbUCEGor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 01:44:47 -0500
Received: from fmr99.intel.com ([192.55.52.32]:13759 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S262094AbUCEGop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 01:44:45 -0500
Subject: Re: Hyper-threaded pickle
From: Len Brown <len.brown@intel.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40480795.5000402@pobox.com>
References: <40480795.5000402@pobox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1078469072.12990.1742.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Mar 2004 01:44:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re: old systems -- we use dmi_scan to disable ACPI on systems by default
on systems older than 1/1/2001.

Re: opteron & !HT.  Andi showed me a patch today that disables X86_HT if
you build specifically for an AMD CPU that doesn't support HT.  This
looks like a good idea, and possibly should be expanded.

Re: your power button
I can't explain the 4-second over-ride not working, is this prototype
hardware?  In any case, I'll be happy to work with you to figure out why
ACPI isn't working properly on this box -- a bug report with the details
would be the way to go.  Note that if poweroff works in uni-processor
mode but not in SMP mode, you'll want the latest patch here:
http://bugzilla.kernel.org/show_bug.cgi?id=1141

thanks,
-Len

On Thu, 2004-03-04 at 23:52, Jeff Garzik wrote:
> So,
> 
> Just now getting my dual athlon going under 2.6.x.  It _really_ doesn't 
> like ACPI.
> 
> ACPI specifications dictate some hardware characteristics, as well as 
> specifying table structures and such.  One of those characteristics is 
> the 4-second poweroff:  if you hold down the power button for 4-5 
> seconds, your motherboard is required to poweroff the machine.  This is 
> supposed to be a hard poweroff, and on most machines this works even 
> when various pieces of hardware are frozen/locked-up.
> 
> Turning on ACPI kills my 4-second poweroff, which is pretty darn 
> impressive.  So I proceed to disable ACPI...  but CONFIG_ACPI_BOOT 
> doesn't want to disable.  I am trying to restore my working, non-ACPI 
> configuration under 2.6, but this seems to be preventing me from doing so:
> 
> drivers/acpi/Kconfig:
> config ACPI_BOOT
>          bool
>          depends on ACPI || X86_HT
>          default y
> 
> arch/i386/Kconfig:
> config X86_HT
>          bool
>          depends on SMP && !(X86_VISWS || X86_VOYAGER)
>          default y
> 
> My dual athlon _definitely_ doesn't have hyperthreading, and I am 
> willing to bet that force-enabling the ACPI boot and HT code for all SMP 
> machines breaks other older-SMP boxes as well.
> 
> 	Jeff
> 
> 
> 
> 

