Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbULTJYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbULTJYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 04:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbULTJYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 04:24:22 -0500
Received: from fmr05.intel.com ([134.134.136.6]:10645 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261327AbULTJYF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 04:24:05 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Date: Mon, 20 Dec 2004 17:22:34 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE7427013CA31@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Thread-Index: AcTmcOTy3Z9Q1Y9oRrukhsx3K0/D/gAAw0iQ
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>, "Andrew Morton" <akpm@osdl.org>
Cc: <lista4@comhem.se>, <linux-kernel@vger.kernel.org>, <mr@ramendik.ru>,
       <kernel@kolivas.org>, <riel@redhat.com>
X-OriginalArrivalTime: 20 Dec 2004 09:22:35.0234 (UTC) FILETIME=[70DD7420:01C4E675]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, based on this and other scattered reports, I'd say it seems
> quite likely that token based thrashing control is the culprit. Based
> on the cost/benefit, I wonder if we should disable TBTC by default for
> 2.6.10, rather than trying to fix it, and try again for 2.6.11?
> 
> Rik? Andrew?
> 
> Also, it would be nice to have a sysctl to *completely* disable TBTC,
> that would make testing easier.
> 
> Nick

I have run some stress tests against 2.6.9, 
2.6.9 + ignore-swap-token-when-in-trouble.patch
and 2.6.10-rc3-mm1 on an Itanium2 with 4G memory.

With 2.6.9
OOM killer will be invoked within a few hours of stress test running.

With 2.6.9 + vmscan-ignore-swap-token-when-in-trouble.patch
OOM killer will be invoked around 30 hours.

While 2.6.10-rc3-mm1 seems to be much more stable.
At least for the test I was running, it bypassed 48 hours test.

Zou Nan hai
