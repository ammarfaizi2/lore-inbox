Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVCRA3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVCRA3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 19:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVCRA3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 19:29:46 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:28087 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261407AbVCRA3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 19:29:34 -0500
Date: Thu, 17 Mar 2005 16:29:28 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prezeroing V8
In-Reply-To: <20050317161752.761fe8e9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503171623150.10205@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
 <20050317140831.414b73bb.akpm@osdl.org> <Pine.LNX.4.58.0503171423590.10008@schroedinger.engr.sgi.com>
 <20050317151151.47fd6e5f.akpm@osdl.org> <Pine.LNX.4.58.0503171525360.10205@schroedinger.engr.sgi.com>
 <20050317155908.56e77b8e.akpm@osdl.org> <Pine.LNX.4.58.0503171600320.10205@schroedinger.engr.sgi.com>
 <20050317161752.761fe8e9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005, Andrew Morton wrote:

> > I switched off the page-zeroing hardware for the tests.
>
> What tests?

For the results on the darn URL.

> See, a speedup in a simple malloc+memset could be due to either a simple
> transfer of load from user to kscrubd, or it could be due to leveraging the
> page-zeroing hardware.
>
> The latter, I expect, if the workload is actually touching every byte of
> all the pages.  Is it?

If the workload is touching every byte of the workload immediately after a
page fault then prezeroing is not effective. Its only useful for sparse
accesses (like page tables etc).

> If we're doing kscrubd zeroing via memset() then the total system load
> would actually be increased if the application is touching every byte, yes?

The kernel would have zeroed a page uselessly at an idle time.

> > Without zeroing hardware the eroing actions are moved to idle
> > system time (load < /proc/sys/vm/scrub_load). Its shifting the cpu load.
>
> Right.  We'd expect that to be a net regression if the application is
> touching all of the memory and a net win if it is touching the memory
> sparsely, yes?

There will be no regression (as shown on the unnamed URL) if the scrubd
is only run during idle times (and also there will be no regression if
the known zeroed pages are returned to the hotlists and then
used).

Kscrubd is an experimental configuration option. Switch it off[default]
and the zero hotlists are only populated by the return of known zeroed
pages via free_hot_zeroed_page etc.

