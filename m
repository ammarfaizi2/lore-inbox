Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946371AbWJSS5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946371AbWJSS5H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946367AbWJSS5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:57:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:41543 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1946356AbWJSS5E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:57:04 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="149115615:sNHT20241172"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: speedstep-centrino: ENODEV
Date: Thu, 19 Oct 2006 11:56:58 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454C1A534@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: speedstep-centrino: ENODEV
Thread-Index: AcbzqyLKGSn02FDxRyixfBJ3yPIVNAAA+eTA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: =?iso-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Cc: "Jiri Slaby" <jirislaby@gmail.com>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 19 Oct 2006 18:57:00.0381 (UTC) FILETIME=[5BA288D0:01C6F3B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Sune Mølgaard [mailto:sune@molgaard.org] 
>Sent: Thursday, October 19, 2006 11:19 AM
>To: Pallipadi, Venkatesh
>Cc: Jiri Slaby; Linux kernel mailing list; linux-acpi@vger.kernel.org
>Subject: Re: speedstep-centrino: ENODEV
>
>Thanks for taking an interest, if I haven't said so before.
>
>Now, I was about to write that I couldn't open /dev/mem, but luckily 
>remembered to try sudo'ing acpidump :-$
>
>Enclosed is the dump, created while running 2.6.18.1.
>

OK. Things seem to be fine with the BIOS. 

You said it was working with 2.6.15. Do you remember whether kernel was using acpi-cpufreq or speedstep-centrino?

One change that has happened in this region is that If your BIOS supports both speedstep-centrino and acpi-cpufreq, with 2.6.15 any one of those drivers would have worked. But now with 2.6.18, acpi-cpufreq will not work in the above case and you have to use speedstep_centrino. This was done because, speedstep-centrino has more features than acpi-cpufreq and also doing this helped to elimiate issues with lot of systems with kernel trying to do multiple ACPI PDC writes when BIOS doesn't expect it to. 

In short:
(1) If you were using acpi-cpufreq in 2.6.15, there is a high chance that it wont work with 2.6.18 and you should be able to use speedstep-centrino in its place. Make sure you have properly configured speedstep-centrino (You should select X86_SPEEDSTEP_CENTRINO_ACPI along with X86_SPEEDSTEP_CENTRINO).

(2) If you were using speedstep-centrino in 2.6.15 and now it doesn't work with 2.6.18, then we have a new regression here and we need to root cause it further by enabling cpufreq.debug and getting more debug messages to see where it is failing....

Thanks,
Venki
