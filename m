Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbWCUBjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWCUBjF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 20:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWCUBjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 20:39:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:22563 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S964953AbWCUBjD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 20:39:03 -0500
X-IronPort-AV: i="4.03,112,1141632000"; 
   d="scan'208"; a="14620242:sNHT10117174466"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Tue, 21 Mar 2006 09:38:42 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B417262@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZL6V/h+tyooSpERoy/KQ1OK2/c7AAmoIMQ
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
X-OriginalArrivalTime: 21 Mar 2006 01:38:44.0086 (UTC) FILETIME=[30934960:01C64C88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I think you need to continue to find out which THMs, which methods
>> cause s3 hang when THM0._TMP disabled.
>
>So far I've found that if (with no THM0 loaded) I load exactly one of
>THM2, THM6, or THM7, then there's no hang.  Now I am looking for which
>combinations of the THM[0267] zones cause the problem.

Hmm, I guess you don't need to try each combination of  THM[0267].
>From pervious experience, we know _THM0._TMP causes problem.
If you fake _TMP for all THM, what could happen?

If you verified _TMP cause issue by fake them in DSDT,  probably,
we need to continue dig Method : UPDT. 

                    Method (UPDT, 0, NotSerialized)
                    {
                        If (IGNR)
                        {
                            Decrement (IGNR)
                        }
                        Else
                        {
                            If (H8DR)
                            {
                                If (Acquire (I2CM, 0x0064)) {}
                                Else
                                {
                                    Store (I2RB (Zero, 0x01, 0x04),
Local7)
                                    If (Local7)
                                    {
                                        Fatal (0x01, 0x80000003, Local7)
                                    }
                                    Else
                                    {
                                        Store (HBS0, TMP0)
                                        Store (HBS2, TMP2)
                                        Store (HBS6, TMP6)
                                        Store (HBS7, TMP7)
                                    }

                                    Release (I2CM)
                                }
                            }
                        }
                    }

Thanks,
Luming
