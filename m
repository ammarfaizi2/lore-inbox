Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbULWVD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbULWVD2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 16:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbULWVD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 16:03:27 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15766 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261298AbULWVDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 16:03:03 -0500
Date: Thu, 23 Dec 2004 13:02:57 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [0/3]: Why and When it works
In-Reply-To: <p73ekhgzrnp.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.58.0412231257340.32338@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com.suse.lists.linux.kernel>
 <41C20E3E.3070209@yahoo.com.au.suse.lists.linux.kernel>
 <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com.suse.lists.linux.kernel>
 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com.suse.lists.linux.kernel>
 <p73ekhgzrnp.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2004, Andi Kleen wrote:

> > 1. Aggregating zeroing operations to only apply to pages of higher order,
> > which results in many pages that will later become order 0 to be
> > zeroed in one go. For that purpose the existing clear_page function is
> > extended and made to take an additional argument specifying the order of
> > the page to be cleared.
>
> But if you do that you should really use a separate function that
> can use cache bypassing stores.
>
> Normal clear_page cannot use that because it would be a loss
> when the data is soon used.

Clear_page is used both in the cache hot and no cache wanted case now.

> So the two changes don't really make sense.

Which two changes?

If an arch can do zeroing without touching the cpu caches then that can
be done with a zero driver.

> Also I must say I'm still suspicious regarding your heuristic
> to trigger gang faulting - with bad luck it could lead to a lot
> more memory usage to specific applications that do very sparse
> usage of memory.

Gang faulting is not part of this patch. Please keep the issues separate.

> There should be at least an madvise flag to turn it off and a sysctl
> and it would be better to trigger only on a longer sequence of
> consecutive faulted pages.

Again this is not related to this patchset. Look at the V13 of the page
fault scalability patch and you will find a /proc/sys/vm setting to
manipulate things. This is V2 of the prezeroing patch.

> How about some numbers on i386?

Umm. Yeah. I only have smallish i386 machines here. Maybe next year ;-)
