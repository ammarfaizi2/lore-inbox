Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWCQHvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWCQHvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 02:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWCQHvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 02:51:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:28245 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S964872AbWCQHvC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 02:51:02 -0500
X-IronPort-AV: i="4.03,103,1141632000"; 
   d="scan'208"; a="13990740:sNHT14655956"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Fri, 17 Mar 2006 15:50:35 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC265@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZJlR49nP18laXUT8CfO+ELmgEYLgAADSuQ
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
X-OriginalArrivalTime: 17 Mar 2006 07:50:35.0877 (UTC) FILETIME=[79C96950:01C64997]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> How about re-testing dummy _PSV and dummy _AC0 in DSDT?
>
>Just retested and you were right.  This time I managed to get it to
>hang, after many cycles of sleep.sh and "modprobe -r thermal ;
>modprobe thermal" mixed in.
>

Hmmm, may I think this is a problem of:
_TMP ,

It is neither _TMP && (_PSV || _AC0),
nor  _TMP || _PSV || _AC0.

So, please try hack thermal.c by removing calls to _TMP.
And do stress test with Vanilla Kernel, Vanilla Dsdt , just
with hacked thermal.c

Anyway, the clean way to fix your problem might be:

 suspend thermal driver with disabling AML methods invoke
that might cause/ trigger BIOS issues.

Thanks,
Luming
