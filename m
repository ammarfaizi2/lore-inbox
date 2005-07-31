Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVGaUB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVGaUB3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 16:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVGaUB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 16:01:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:44979 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261967AbVGaUAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 16:00:30 -0400
Date: Sun, 31 Jul 2005 13:00:12 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Alex Williamson <alex.williamson@hp.com>
cc: tony.luck@intel.com, linux-kernel@vger.kernel.org
Subject: Re: long delays (possibly infinite) in time_interpolator_get_counter
In-Reply-To: <1122829379.6946.11.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0507311256440.32674@schroedinger.engr.sgi.com>
References: <200507292206.j6TM6w4k004594@agluck-lia64.sc.intel.com> 
 <Pine.LNX.4.62.0507291625390.19428@schroedinger.engr.sgi.com> 
 <1122742054.28719.58.camel@localhost.localdomain> 
 <Pine.LNX.4.62.0507301105120.25104@schroedinger.engr.sgi.com>
 <1122829379.6946.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2005, Alex Williamson wrote:

>    Ok, here's an optimization that should help reduce contention on the
> cmpxchg, has zero impact on the nojitter path, and doesn't require any
> changes to fsys.  When a caller already had the xtime_lock write lock
> there's no need to fight with other CPUs for the cmpxchg.  The other

Yup correct.

> "reader" CPUs will have to fetch it again since a seqlock write is in
> progress.  Therefore we can simplify this path as shown below.  The
> write is atomic, and we don't care if another CPU has changed last_cycle
> since it can't return the value until the write lock is released.  This
> has only been compile tested, but I'm interested to hear your opinion.

time_interpolator_get_counter is static inline. So you may modify the
existing function and pass a constant parameter without a 
performance reduction. Two different versions will then be generated for 
time_interpolator_get_counter at compile time.

Maybe call the parameter "writelock"?

