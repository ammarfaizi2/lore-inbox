Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbWA0VsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWA0VsR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 16:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWA0VsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 16:48:17 -0500
Received: from fmr23.intel.com ([143.183.121.15]:60629 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932506AbWA0VsQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 16:48:16 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: boot-time slowdown for measure_migration_cost
Date: Fri, 27 Jan 2006 13:48:07 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F058CC7A6@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: boot-time slowdown for measure_migration_cost
Thread-Index: AcYjhUFGEUY3c/kXR9qxGa44d9D+4gABDgAA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, "Ingo Molnar" <mingo@redhat.com>
Cc: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Jan 2006 21:48:08.0935 (UTC) FILETIME=[5CB3C770:01C6238B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The boot-time migration cost auto-tuning stuff seems to have
> been merged to Linus' tree since 2.6.15.  On little one- or
> two-processor systems, the time required to measure the
> migration costs isn't very noticeable, but by the time we
> get to even a four-processor ia64 box, it adds about
> 30 seconds to the boot time, which seems like a lot.

I only see about 16 seconds for a 4-way tiger (not that 16 seconds
is good ... but it not as bad as 30).  This was with a build
from tiger_defconfig that sets CONFIG_NR_CPUS=4 ... so I wonder
what's causing the factor of two.  I measured with a printk
each side of build_sched_domains() and booted with the "time"
command line arg to get:

[    0.540718] Building sched domains
[   16.124693] migration_cost=10091
[   16.124789] Done

More importantly, how does this time scale as the number of
cpus increases?  Linear, or worse?  What happens on a 512 cpu
Altix (if it's quadratic, they may be still waiting for the
boot to finish :-)

-Tony
