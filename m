Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264159AbTCXTmj>; Mon, 24 Mar 2003 14:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264213AbTCXTmj>; Mon, 24 Mar 2003 14:42:39 -0500
Received: from fmr01.intel.com ([192.55.52.18]:7636 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S264159AbTCXTmi> convert rfc822-to-8bit;
	Mon, 24 Mar 2003 14:42:38 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: lmbench results for 2.4 and 2.5 -- updated results
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Date: Mon, 24 Mar 2003 11:53:44 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF19010485F1@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: lmbench results for 2.4 and 2.5 -- updated results
Thread-Index: AcLx5HjEnEc7Y3+jSQWOSRF7A91qAgAT8upA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Linus Torvalds" <torvalds@transmeta.com>
X-OriginalArrivalTime: 24 Mar 2003 19:53:44.0683 (UTC) FILETIME=[13AE0BB0:01C2F23F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Linus Torvalds [mailto:torvalds@transmeta.com] 
> Sent: Monday, March 24, 2003 12:40 AM
> To: linux-kernel@vger.kernel.org
> Subject: Re: lmbench results for 2.4 and 2.5 -- updated results
> 
> 
> >--page fault (is this significant?)
> 
> I don't think so, there's something strange with the lmbench pagefault
> tests, it only has one significant digit of accuracy, and I don't even
> know what it is testing. Because of the single lack of precision, it's
> hard to tell what the real change is.
> 

This single digit accuracy is coming from a minor integer division bug
in lmbench.
Appended LMbench patch should resolve it.

Thanks,
-Venkatesh

--- LMbench/src/lat_pagefault.c.org	Mon Mar 24 10:40:46 2003
+++ LMbench/src/lat_pagefault.c	Mon Mar 24 10:54:34 2003
@@ -67,5 +67,5 @@
 		n++;
 	}
 	use_int(sum);
-	fprintf(stderr, "Pagefaults on %s: %d usecs\n", file, usecs/n);
+	fprintf(stderr, "Pagefaults on %s: %f usecs\n", file, (1.0 *
usecs) / n);
 }

