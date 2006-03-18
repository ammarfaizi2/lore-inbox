Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932831AbWCRP67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932831AbWCRP67 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 10:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWCRP66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 10:58:58 -0500
Received: from mga03.intel.com ([143.182.124.21]:60232 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932101AbWCRP64 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 10:58:56 -0500
X-IronPort-AV: i="4.03,106,1141632000"; 
   d="scan'208"; a="13397924:sNHT101152891"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Sat, 18 Mar 2006 23:58:49 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC269@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZKo4ltkA5MNN/GRTGN2UXItiZGuQAADDAQ
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
X-OriginalArrivalTime: 18 Mar 2006 15:58:50.0693 (UTC) FILETIME=[D9455750:01C64AA4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Please try additional ugly hack
>>  5. in acpi_os_queue_for_execution:
>>	if(acpi_in_suspend == YES)
>>		do nothing.
>
>Am compiling it.  If acpi_in_suspend, I've had it do
>return_ACPI_STATUS(AE_BAD_PARAMETER).  Is there a better error code to
>use?  I didn't want to use AE_OK, since the caller might think that
>the function will be executed eventually, and might do something silly
>like wait for it to be executed -- and produce another hang.  I didn't
>know, but to be safe I wanted to return an error code.

just return AE_OK, because we are hacking. :-)
The only place that could have issue is in acpi_ev_global_lock_handler,
you can add a printk there, then you can know what happened.

>
>> Also, please add acpi_debug_layer=0x10 acpi_debug_leve=0x10 boot
>> option, then you can observe what methods were executed before
>> suspend.
>
>That's in my lilo.conf so all kernels I test use those options.  I can
>send you the dmesgs from the suspends without the ugly hack (and will
>send them from the upcoming suspends, with the ugly hack).

Thanks, I'm waiting for that to understand if the hack is clean for
killing unwanted AML methods call.
