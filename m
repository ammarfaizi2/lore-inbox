Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752550AbWCQG5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbWCQG5u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 01:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbWCQG5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 01:57:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:25101 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752550AbWCQG5t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 01:57:49 -0500
X-IronPort-AV: i="4.03,103,1141632000"; 
   d="scan'208"; a="13593993:sNHT34415955"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Fri, 17 Mar 2006 14:57:38 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC264@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZJjJtKX1xnRMYMR26bduQ8nvvflgAAYUCg
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
X-OriginalArrivalTime: 17 Mar 2006 06:57:39.0981 (UTC) FILETIME=[14CE23D0:01C64990]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hmm,  we can continue to have fun with debugging. Right?
>
>Definitely, I haven't given up.

Great!

>
>>> The second sleep.sh hangs going to sleep.  It is in an endless loop
>>> printing the following line, once per second (from the
>>> polling_frequency):
>>>
>>>  Execute Method: [\_TZ_.THM0._TMP] (Node c157bf88)
>
>I don't think these lines are a problem.  They just reflect that
>thermal polling is happening once per second.  So even though the ACPI
>system is hanging in the SMPI loop (as you say below), it is alive
>enough to poll the temperature sensors.
>
>> Also please mute THM0 polling.
>
>I retested the hacked kernel (with faked thermal_active/passive)
>but with no thermal polling, just doing
>
>  cat THM*/polling_frequency (they were all 'polling disabled')
>  sleep.sh  (works)
>  sleep.sh  (hangs in the usual SMPI loop)
>
>and it hangs as usual.

Good news, no new branch needed to track. 
I assume the problem is still like _TMP & (_PSV | _AC0).

How about re-testing dummy _PSV and dummy _AC0 in DSDT?
Because, your testing result with dummy _PSV and dummy_AC0
IS NOT consistent with the result of hacking
acpi_thermal_passive/active.
Maybe I need to reconsider the impact of _PSV or_AC0 on the 
platform.

How about  just faking _TMP in DSDT. I'm sure you have done this before.
But, I need to confirm that the problem is NOT _TMP | _PSV | _AC0.

Thanks,
Luming
