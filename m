Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWDCSB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWDCSB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 14:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWDCSB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 14:01:56 -0400
Received: from rune.pobox.com ([208.210.124.79]:38045 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S964825AbWDCSBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 14:01:55 -0400
Date: Mon, 3 Apr 2006 13:01:31 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linuxppc-dev@ozlabs.org,
       ak@suse.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
Message-ID: <20060403180131.GD25663@localdomain>
References: <20060402213216.2e61b74e.akpm@osdl.org> <Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com> <20060402221513.96f05bdc.pj@sgi.com> <Pine.LNX.4.64.0604022224001.18401@schroedinger.engr.sgi.com> <20060403141027.GB25663@localdomain> <Pine.LNX.4.64.0604031039560.20648@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604031039560.20648@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> 
> On Mon, 3 Apr 2006, Nathan Lynch wrote:
> 
> > In this case, disabling preempt around the for_each_online_cpu loop
> > would prevent any cpu from going down in the meantime.  But since this
> > function doesn't look like it's a hot path, and we're potentially
> > traversing lots of zones and cpus, lock_cpu_hotplug might be preferable.
> > 
> > As Paul noted, the fix as it stands isn't adequate.
> 
> There are many other for_each_*_cpu loops in the kernel that do not have 
> any of the instrumentation you suggest. I suggest you come up with a 
> general solution and then go through all of them and fix this. Please be 
> aware that many of these loops are performance critical.

But this one isn't, right?

And I'm afraid there's a misunderstanding here -- only
for_each_online_cpu (or accessing the cpu online map in general) has
such restrictions -- for_each_possible_cpu doesn't require any locking
or preempt tricks since cpu_possible_map must not change after boot.
