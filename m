Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWCSOdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWCSOdN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 09:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWCSOdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 09:33:13 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:23205 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751029AbWCSOdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 09:33:13 -0500
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
In-Reply-To: Your message of "Sun, 19 Mar 2006 12:12:09 +0800."
             <3ACA40606221794F80A5670F0AF15F84041AC26C@pdsmsx403> 
Date: Sun, 19 Mar 2006 14:33:08 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FKyxw-0003Iq-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe I need to make a summary here for this issue:
> 1. The s3 hang is in While-loop in SMPI that looks like
> waiting BIOS response.

Right.

> 2. If THM2, THM6, THM7 disabled, disabling THM0._TMP
> fix the s3 hang.

Right.  And many ways of disabling THM0._TMP fix the hang:

1. making acpi_evaluate_integer() not evaluate _TMP methods.
2. the short-term fix using acpi_in_suspend
3. taking out \_SB.PCI0.ISA0.EC0.UPDT () line from _TMP method.

> I think you need to continue to find out which THMs, which methods
> cause s3 hang when THM0._TMP disabled.  I assume the problem is:
> THM0._TMP && THMx._XXX && THMy._YYY..

I agree, and am testing the other thermal methods one at a time.  I
suspect that THMx.AC0 will be involved, but we'll see.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
