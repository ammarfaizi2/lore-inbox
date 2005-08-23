Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVHWOHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVHWOHb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 10:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVHWOHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 10:07:31 -0400
Received: from fmr13.intel.com ([192.55.52.67]:15580 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932184AbVHWOHa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 10:07:30 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: CONFIG_PRINTK_TIME woes
Date: Tue, 23 Aug 2005 07:07:17 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0434ACEA@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CONFIG_PRINTK_TIME woes
Thread-Index: AcWnsvKpfKtQQW5CRy6V4lbjyvnyHgAOG8TQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Tony Lindgren" <tony@atomide.com>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <jasonuhl@sgi.com>
X-OriginalArrivalTime: 23 Aug 2005 14:07:19.0541 (UTC) FILETIME=[F9865250:01C5A7EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I'd hate to have to test for something for CONFIG_PRINTK_TIME
>every time sched_clock() is being called.

Me too.

>The quick fix would seem to be to only allow CONFIG_PRINTK_TIME
>from kernel cmdline to make it happen a bit later. So basically
>make int printk_time = 0 until command line is evaluated.

Good thought, but this won't work for ia64 in the hot-plug cpu case.
There are a couple of printk() calls by new cpus as they boot before
they have set-up their per-cpu areas.  So there is no global state
that can be checked to decide whether it is safe for printk() to
call sched_clock().

-Tony
