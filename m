Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbVIHIL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbVIHIL2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 04:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbVIHIL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 04:11:28 -0400
Received: from fmr15.intel.com ([192.55.52.69]:50381 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751342AbVIHIL1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 04:11:27 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [GIT PATCH] ACPI for 2.6.14
Date: Thu, 8 Sep 2005 04:11:06 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30048B3F04@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [GIT PATCH] ACPI for 2.6.14
Thread-Index: AcW0R8k61XKcCzCTSTylwYojt55eDQAAU9nQ
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 08 Sep 2005 08:11:10.0331 (UTC) FILETIME=[DF17A4B0:01C5B44C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>There are a few bugs which I'd identified as arising from the acpi tree
>while it was in -mm.  Is this patch likely to drag them into mainline?
>
>They include:
>
>
>http://bugzilla.kernel.org/show_bug.cgi?id=4977
>            Summary: ACPI 20050708 fails on HP RX2600 platform

This was filed against ACPICA 20050708
which had a known problem with module-level code.
The ACPI patch now contains ACPICA 20050902 which
fixes that issue, and this system needs to be
re-tested with the latest patch.

>http://bugzilla.kernel.org/show_bug.cgi?id=4867
>            Summary: bug in ACPI crashes machine when reading
>                     /proc/acpi/thermal_zone/THRM/temperature

UNREPRODUCIBLE.
test system died and is no longer available.

>http://bugzilla.kernel.org/show_bug.cgi?id=4980
>            Summary: krash on entering mem sleep

The submitter confirmed that suspend to memory now works on this box.

The remaining issue on this box is related to the EC and battery,
and we're getting contradictory feedback on it.
Frankly, I think we need broader testing, and
pushing the latest ec code into 2.6.14 now is the best
way to get that.  If it turns out to be a mistake
we can always turn back time and revert
drivers/acpi/ec.c to the one that shipped in 2.6.12 --
but the one in the latest patch has proven to be
superior to 2.6.13 on other systems.

>Plus we have all the battery monitor woes, but they're in 
>2.6.13 already.

Re: 2.6.13 regressions vs 2.6.12, I'm aware of these:

  http://bugzilla.kernel.org/show_bug.cgi?id=5165
  smp c-states on Pentium 4 with hyperthreading causes big slow-down

  http://bugzilla.kernel.org/show_bug.cgi?id=5171
  2.6.13 SMP kernel crash on boot at pm_idle_save()

I saw lots of transient battery issues from 2.6.13-rc3
until 2.6.13-rc6, but the ones I followed went away
as of 2.6.13 final.  Do you have your eye on others
besides 4980?

thanks,
-Len
