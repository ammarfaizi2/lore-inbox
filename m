Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVCRAS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVCRAS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 19:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVCRAS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 19:18:26 -0500
Received: from fire.osdl.org ([65.172.181.4]:16348 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261293AbVCRASJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 19:18:09 -0500
Date: Thu, 17 Mar 2005 16:17:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prezeroing V8
Message-Id: <20050317161752.761fe8e9.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503171600320.10205@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
	<20050317140831.414b73bb.akpm@osdl.org>
	<Pine.LNX.4.58.0503171423590.10008@schroedinger.engr.sgi.com>
	<20050317151151.47fd6e5f.akpm@osdl.org>
	<Pine.LNX.4.58.0503171525360.10205@schroedinger.engr.sgi.com>
	<20050317155908.56e77b8e.akpm@osdl.org>
	<Pine.LNX.4.58.0503171600320.10205@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Thu, 17 Mar 2005, Andrew Morton wrote:
> 
> > >  http://oss.sgi.com/projects/page_fault_performance/
> >
> > Oh no, not that page again ;)
> 
> Yes indeed!
> 
> > Seems to say that prezeroing makes negligible difference to kernel builds,
> > but speeds up a big malloc+memset by 3x to 4x, yes?
> 
> Correct.
> 
> > Are there any real-worldish workloads which show an appreciable benefit?
> 
> Ummm. Big loads are our real-worldish workloads here.

Sure, but not malloc+memset+exit.

How much improvement do these big numerical tasks get from the patch?

> > The large speedup for a big memset seems odd - I assume it's simply
> > transferring CPU load from the user's process over to kscrubd.  Or is it
> > the fancy page-zeroing hardware?  How do we differentiate the two?
> 
> I switched off the page-zeroing hardware for the tests.

What tests?

See, a speedup in a simple malloc+memset could be due to either a simple
transfer of load from user to kscrubd, or it could be due to leveraging the
page-zeroing hardware.

The latter, I expect, if the workload is actually touching every byte of
all the pages.  Is it?

If we're doing kscrubd zeroing via memset() then the total system load
would actually be increased if the application is touching every byte, yes?

> > Are there any workloads which are seeing a benefit on a CPU which doesn't
> > have the zeroing hardware?
> 
> Without zeroing hardware the eroing actions are moved to idle
> system time (load < /proc/sys/vm/scrub_load). Its shifting the cpu load.

Right.  We'd expect that to be a net regression if the application is
touching all of the memory and a net win if it is touching the memory
sparsely, yes?


