Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752223AbWCPH3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbWCPH3z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 02:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbWCPH3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 02:29:55 -0500
Received: from fmr20.intel.com ([134.134.136.19]:42455 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752223AbWCPH3y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 02:29:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Thu, 16 Mar 2006 15:28:47 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B37A72F@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZIxvh5cmjl+S1lTMiwn45d1D/i4QAASHUQ
From: "Yu, Luming" <luming.yu@intel.com>
To: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       <michael@mihu.de>, <mchehab@infradead.org>,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, <gregkh@suse.de>,
       "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       <jgarzik@pobox.com>, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
X-OriginalArrivalTime: 16 Mar 2006 07:28:49.0351 (UTC) FILETIME=[449F9D70:01C648CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It doesn't hang.  Though it seemed close to hanging a couple times,
>but after a 5-10 second pause always managed to go to sleep.  I tried
>about 15 sleep cycles, with a few echo 1 > polling_frequency thrown in.

ACPI SPEC define:

_PSV  : thermal zone object that returns Passive trip point in
	tenths of digress Kelvin.

_ACx:  thermal zone object that returns active cooling policy 
	threshold values in tenths of degrees Kelvin.

I suspect , when hang, the system was trying to start active cooling
with Fan
in function acpi_thermal_active that was somehow conflict request with
_PTS's call to SMPI in BIOS.  So, the solution is :

	Disable active/passive cooling request before suspend.

To verify this, please hack acpi_thermal_active.

We need a suspend/resume method for acpi thermal to cleanly solve 
your problem.

Thanks,
Luming
