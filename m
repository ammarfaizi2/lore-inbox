Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVCRAF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVCRAF0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 19:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVCRAFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 19:05:25 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:16038 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261396AbVCRAEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 19:04:42 -0500
Date: Thu, 17 Mar 2005 16:04:39 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prezeroing V8
In-Reply-To: <20050317155908.56e77b8e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503171600320.10205@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
 <20050317140831.414b73bb.akpm@osdl.org> <Pine.LNX.4.58.0503171423590.10008@schroedinger.engr.sgi.com>
 <20050317151151.47fd6e5f.akpm@osdl.org> <Pine.LNX.4.58.0503171525360.10205@schroedinger.engr.sgi.com>
 <20050317155908.56e77b8e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005, Andrew Morton wrote:

> >  http://oss.sgi.com/projects/page_fault_performance/
>
> Oh no, not that page again ;)

Yes indeed!

> Seems to say that prezeroing makes negligible difference to kernel builds,
> but speeds up a big malloc+memset by 3x to 4x, yes?

Correct.

> Are there any real-worldish workloads which show an appreciable benefit?

Ummm. Big loads are our real-worldish workloads here.

> The large speedup for a big memset seems odd - I assume it's simply
> transferring CPU load from the user's process over to kscrubd.  Or is it
> the fancy page-zeroing hardware?  How do we differentiate the two?

I switched off the page-zeroing hardware for the tests.

> Are there any workloads which are seeing a benefit on a CPU which doesn't
> have the zeroing hardware?

Without zeroing hardware the eroing actions are moved to idle
system time (load < /proc/sys/vm/scrub_load). Its shifting the cpu load.

But I just fixed things up so that the kernel can return hot zeroed
pages to the pool for quicklist management. This yields zeroed pages
without kscrubd.
