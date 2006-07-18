Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWGRTZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWGRTZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 15:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWGRTZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 15:25:08 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:31616 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932366AbWGRTZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 15:25:06 -0400
Date: Tue, 18 Jul 2006 12:25:33 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 15/33] move segment checks to subarch
Message-ID: <20060718192533.GA2654@sequoia.sous-sol.org>
References: <20060718091807.467468000@sous-sol.org> <20060718091952.263186000@sous-sol.org> <1153249601.5467.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153249601.5467.31.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rusty Russell (rusty@rustcorp.com.au) wrote:
> On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> > plain text document attachment (i386-segments)
> > We allow for the fact that the guest kernel may not run in ring 0.
> > This requires some abstraction in a few places when setting %cs or
> > checking privilege level (user vs kernel).
> 
> Zach had an alternate patch for this, which didn't assume the kernel ran
> in a compile-time known ring, but is otherwise very similar.  I've put
> it below for discussion (but Zach now tells me the asm parts are not
> required: Zach, can you mod this patch and comment?).

This patch also doesn't have a compile time known ring, it's using
get_kernel_cs() because the Xen method for booting native is dynamic and
would resolve to ring 0 in that case (XENFEAT_supervisor_mode_kernel).

> Your patch #16 finishes the job you started here, by doing the mods to
> entry.S.  I think it's cleaner to have all this in one patch (and it can
> go in almost immediately AFAICT).

I totally agree.  I actually started doing rearranging the patch order
last night and that was one of the bits that got consolidated.  It was
getting light this morning and I gave up since I was wasting lots of
time fixing patch rejects from all the rearranging, and needed a bit of
sleep before KS;-)

> Comments?
> Rusty.
> 
> Name: Kernel Ring Cleanups
> Status: Booted on 2.6.18-rc1
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Looks fine to me, granted I haven't tried to boot it yet.  I'll double
check and report back.

thanks,
-chris
