Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbULXQRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbULXQRm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 11:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbULXQRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 11:17:42 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:1986 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261232AbULXQRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 11:17:35 -0500
Date: Fri, 24 Dec 2004 08:17:07 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Prezeroing V2 [0/3]: Why and When it works
In-Reply-To: <Pine.LNX.4.58.0412231325420.2654@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0412240812190.6505@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
 <16843.13418.630413.64809@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0412231325420.2654@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2004, Linus Torvalds wrote:

> So if we make the "what load is considered low" tunable, a system
> administrator can use that to make it more aggressive. And indeed, you
> might have a cron-job that says "be more aggressive at clearing pages
> between 2AM and 4AM in the morning" or something - if you have so much
> memory that it actually matters if you clear the memory just occasionally.
>
> And the tunable load-average check has another advantage: if you want to
> benchmark it, you can first set it to true zero (basically never), and run
> the benchmark, and then you can set it to something very agressive ("clear
> pages every five seconds regardless of load") and re-run.
>
> Does this sound sane? Christoph - can you try making the "scrub deamon" do
> that? Instead of the "scrub-low" and "scrub-high" (or in _addition_ to
> them), do a "scub-load" thing that takes a scaled integer, and compares it
> with "avenrun[0]" in kernel/timer.c: calc_load() when the average is
> updated every five seconds..

Sure V3 will have that. So far the impact of zeroing is quite minimal
on IA64 (even without using hardware), the big zeroing happens immediately
after activating it anyways. I have not seen any measurable effect on
benchmarks even with 4G allocations on a 6G machine.

> Personally, at least for a desktop usage, I think that the load average
> would work wonderfully well. I know my machines are often at basically
> zero load, and then having low-latency zero-pages when I sit down sounds
> like a good idea. Whether there is _enough_ free memory around for a
> 5-second thing to work out well, I have no idea..

The CPU can do a couple of Gigs of zeroing per second per CPU and the
zeroing zeros local RAM. On my 6G machine with 8 Cpus it can only
take a fraction of a second to zero all RAM.

Merry Christmas, I am off till now next year. SGI mandatory holiday
shutdown so all addicts have to go cold turkey ;-)

