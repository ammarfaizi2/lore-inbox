Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWBFVKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWBFVKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWBFVKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:10:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31453 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750811AbWBFVKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:10:53 -0500
Date: Mon, 6 Feb 2006 13:10:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: ak@suse.de, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: OOM behavior in constrained memory situations
Message-Id: <20060206131026.53dbd8d5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> There are situations in which memory allocations are restricted by policy, 
> by a cpuset or by type of allocation. 
> 
> I propose that we need different OOM behavior for the cases in which the
> user has imposed a limit on what type of memory to be allocated. In that 
> case the application should be terminate with OOM. The OOM killer should 
> not run.
> 
> The huge page allocator has already been modified to return a Bus Error
> because it would otherwise trigger the OOM killer. Its a bit strange
> if an app returns a Bus Error because it its out of memory.
> 
> Could we modify the system so that the application requesting 
> memory is terminated with an out of memory condition if
> 
> 1. No huge pages are available anymore.
> 
> 2. The application has set a policy that restricts allocation to
>    certain nodes.
> 
> 3. An application is restricted by a cpuset to certain nodes.
> 
> 4. An application has requested large amounts of memory and the 
>    allocation fails.
> 
> That should avoid the OOM killer in most situations.

Do we really want to kill the application?  A more convetional response
would be to return NULL from the page allocator and let that trickle back.

The hugepage thing is special, because it's a pagefault, not a syscall.
