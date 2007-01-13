Return-Path: <linux-kernel-owner+w=401wt.eu-S1161186AbXAMAYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161186AbXAMAYr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 19:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbXAMAYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 19:24:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:34342 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161186AbXAMAYq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 19:24:46 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,180,1167638400"; 
   d="scan'208"; a="35736670:sNHT20848041"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG] NMI watchdog lockups caused by mwait_idle
Date: Fri, 12 Jan 2007 16:24:44 -0800
Message-ID: <EB12A50964762B4D8111D55B764A8454011D61F7@scsmsx413.amr.corp.intel.com>
In-Reply-To: <45A7F70E.80507@us.ibm.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] NMI watchdog lockups caused by mwait_idle
Thread-Index: Acc2jMmCJWWYW8FySmyd/qyoYGdbaQAFkjNg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Jan 2007 00:24:45.0702 (UTC) FILETIME=[3A312260:01C736A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Darrick,

I tried 2.6.20-rc4 on a Dempsey system here in my lab and it worked
fine. No watchdog lockups.
Can you try idle routine with hlt instead of mwait. There is no boot
option for this in x86_64, but you can change
arch/x86_64/kernel/process.c:select_idle_routine() not to enable mwait.
With that default kernel should use hlt based idle.

Also, worth seeing will be, what happens when nmi_watchdog=0,
nmi_watchdog=1, and nmi_watchdog=2 boot options. That should tell us
whether nmi_watchdog is raising some false alarm or the CPUs are indeed
getting locked up here..

Thanks,
Venki


>-----Original Message-----
>From: Darrick J. Wong [mailto:djwong@us.ibm.com] 
>Sent: Friday, January 12, 2007 1:01 PM
>To: Pallipadi, Venkatesh
>Cc: Linux Kernel Mailing List
>Subject: [BUG] NMI watchdog lockups caused by mwait_idle
>
>Hi Venkatesh,
>
>I have an IBM IntelliStation Z30 with two Dempsey CPUs.  When I try to
>boot 2.6.20-rc4 on it, the system prints messages about NMI watchdog
>lockups.  git-bisect determined that the patch "[PATCH] x86-64: Fix
>interrupt race in idle callback (3rd try)" was the source of these
>problems, and I can work around the problem either by passing
>"idle=poll" to get avoid mwait_idle or by reverting the patch.
>
>Other non-Dempsey Xeon machines with mwait support do not exhibit these
>symptoms.  I will try to determine if this is a bug specific to Dempsey
>CPUs or this particular type of machine.  I suspect the latter, but I
>don't know enough about monitor/mwait to pursue this much further.
>
>What else can I do to diagnose this?
>
>--D
>
