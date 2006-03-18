Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWCRPsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWCRPsa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 10:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWCRPsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 10:48:30 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:13800 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750994AbWCRPs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 10:48:29 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Sat, 18 Mar 2006 23:10:32 +0800."
             <3ACA40606221794F80A5670F0AF15F84041AC268@pdsmsx403> 
Date: Sat, 18 Mar 2006 15:48:25 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FKdfF-00022L-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please try additional ugly hack
>  5. in acpi_os_queue_for_execution:
>	if(acpi_in_suspend == YES)
>		do nothing.

Am compiling it.  If acpi_in_suspend, I've had it do
return_ACPI_STATUS(AE_BAD_PARAMETER).  Is there a better error code to
use?  I didn't want to use AE_OK, since the caller might think that
the function will be executed eventually, and might do something silly
like wait for it to be executed -- and produce another hang.  I didn't
know, but to be safe I wanted to return an error code.

> Also, please add acpi_debug_layer=0x10 acpi_debug_leve=0x10 boot
> option, then you can observe what methods were executed before
> suspend.

That's in my lilo.conf so all kernels I test use those options.  I can
send you the dmesgs from the suspends without the ugly hack (and will
send them from the upcoming suspends, with the ugly hack).

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
