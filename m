Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422986AbWCXBcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422986AbWCXBcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422978AbWCXBcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:32:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:20006 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1422979AbWCXBcA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:32:00 -0500
X-IronPort-AV: i="4.03,124,1141632000"; 
   d="scan'208"; a="15579990:sNHT30973278"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Fri, 24 Mar 2006 09:31:46 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B469696@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZOrvkPb7swOezVT4WoNvklebIJKQAL+khA
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
X-OriginalArrivalTime: 24 Mar 2006 01:31:49.0094 (UTC) FILETIME=[B875C860:01C64EE2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

es it mean we need to slow down  acpi_ec_intr_read/write ?
>> Could you try to insert acpi_os_stall (100)  after  ACPI_DEBUG_PRINT
>> statement both in acpi_ec_intr_read/write.
>
>I added that line in those two places.  The result refused to hang with
>acpi_debug_layer=0x00100010, but it did hang (on the usual 
>second sleep)
>with it set to 0x10.

Really strange,  how several printks could change the results.
Could you try to repalce acpi_os_stall with acpi_os_sleep(1)
in acpi_ec_intr_read/write?

>
>> Hmmm, then I cannot get the ec access log for hang case?!
>
>It seems difficult, but let's keep trying if you have other ideas for
>how to get it.
>

Also, please change I2RB copy to: 

                    Method (I2RBcopy, 3, NotSerialized)
                    {
                        Store (Arg0, HCSL)
                        Store (ShiftLeft (Arg1, 0x01), HMAD)
                        Store (Arg2, HMCM)
                        Store (0x0B, HMPR)

		Store(CHKS(), local0)
		Store(local0, Debug)

                        Return (local0)
                    }
And boot with acpi_dbg_layer=0x10 acpi_dbg_level=0x10,
Post full log (Don't edit) for both not hang case, and hang case on
bugzilla.
There should have some clues.

Thanks,
Luming
