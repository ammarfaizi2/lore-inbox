Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbUKKB1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbUKKB1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 20:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbUKKB1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 20:27:21 -0500
Received: from fmr11.intel.com ([192.55.52.31]:677 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S262077AbUKKB1Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 20:27:16 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] cpufreq_(ondemand|conservative) (round three)
Date: Wed, 10 Nov 2004 17:27:07 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB600351CB3F@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cpufreq_(ondemand|conservative) (round three)
Thread-Index: AcTGliPCALv37s1sRbOBn5TanQegdAA8uO/g
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Alexander Clouter" <alex@digriz.org.uk>, <linux-kernel@vger.kernel.org>,
       <cpufreq@www.linux.org.uk>
Cc: <linux@dominikbrodowski.de>
X-OriginalArrivalTime: 11 Nov 2004 01:27:08.0949 (UTC) FILETIME=[8FC38C50:01C4C78D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the patches. Here are some comments about _ondemand patches.

(1) 00_consistency patch
I think it is OK to do this for sampling_rate. But, we may have some
nasty races / corner conditions if we do this for up_threashold and
down_threshold. The race I am thinking about is: we check the new
down_value with old up_value and we may end up finally with
down_threshold greater than up_threshold.

(2) 01_ignore-nice
The idea to have this is good. Somehow I am thinking of some corner
cases here too.
If the prev_cpu_idle_up and prev_cpu_idle_down have unconditionally
include nice and total_ticks includes it conditionally, then we cannot
do the proper subtract and compare of idle times. Am I missing anything
here?

(3) 02_check-rate-and-break-out
This looks good and ready to go. 

(4) 03_sys_freq_step
Looks good. One minor issue. Policy->max can change at run time (when
a/c power and battery power). So behaviour might change if you
initialize freq_step once instead of checking 5% of max during each
switching. But, doing it this way should be OK too, as 5% is not a
strict number.

Thanks,
Venki
