Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbWCOG0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbWCOG0m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 01:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWCOG0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 01:26:42 -0500
Received: from fmr18.intel.com ([134.134.136.17]:47772 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932605AbWCOG0l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 01:26:41 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Wed, 15 Mar 2006 14:25:45 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B32AAAE@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
thread-index: AcZH9a/8sUg4AIF1RPeq7wHG4pEmkwAAoKqA
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
X-OriginalArrivalTime: 15 Mar 2006 06:25:47.0593 (UTC) FILETIME=[4C1B6390:01C647F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>One sad piece of data that I came across, perhaps worth investigating
>further after this one is chased down:
>
>As described in the last email, the combination of _TMP fakery (in
>utils.c) plus the bisecting version of thermal.c (loading only the
>zone THM0 and then only up to bisect_get_info=1) got rid of the hangs.
>
>So I got bold and tried _TMP fakery but with the vanilla thermal.c.
>The idea being that if _TMP is to blame for all the problems, then S3
>sleep should work fine with this setup.  But it hung in the usual way,
>on the second sleep.  Below are the dmesgs after the usual boot-time
>ones.
>
>This experiment produces a hang even with _TMP faked, whereas the
>previous experiment didn't (also with _TMP faked but, after the boot,
>loading only the THM0 zone and only doing the _TMP methods of it, even
>on wake).  So one of the non-TMP methods below must be causing a
>problem?  My suspicion is that it's one of the methods called on wake
>(_THM0._PSV or ._TC1, etc. or maybe one of the other zone's methods),
>which would explain why the first sleep goes fine but the second one
>fails.
>
>I don't think it's any of the calls made when 'thermal' is loading at
>boot time, because the same calls happen in the previous experiment.
>In that experiment, thermal loads normally (with _TMP faked), and only
>after boot do I unload it and replace it with
>
>  modprobe thermal zone_to_keep=0 bisect_get_info=1
>
>Anyway, here are the dmesgs for this experiment (hangs on 2nd sleep):

Ok, Let's change the way of hacking. Let's start bisection
without  touching kernel, instead with DSDT.
Firstly, you need to find out which THM.
Then,  which Methods.
Finally, which statements that triggers S3 hang.

Thanks,
Luming

