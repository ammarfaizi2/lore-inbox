Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVHQAGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVHQAGj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 20:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVHQAGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 20:06:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750736AbVHQAGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 20:06:39 -0400
Date: Tue, 16 Aug 2005 17:06:18 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: zach@vmware.com, akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org,
       hpa@zytor.com, Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zwame@arm.linux.org.uk
Subject: Re: [PATCH 1/14] i386 / Make write ldt return error code
Message-ID: <20050817000618.GT7762@shell0.pdx.osdl.net>
References: <200508110452.j7B4qpSE019505@zach-dev.vmware.com> <20050816234330.GF27628@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050816234330.GF27628@wotan.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Wed, Aug 10, 2005 at 09:52:51PM -0700, zach@vmware.com wrote:
> > Xen requires error returns from the hypercall to update LDT entries,
> > and this generates completely equivalent code on native.
> 
> I don't think that is something we want. Nothing in the callers will check
> the errors anyways. If Xen has such a requirement it should kill
> the guest when it is violated, otherwise they will be ignored.

In this case the callers do propagate the error (unless you mean
userspace doesn't check return value from syscall, which is same problem
if copy_from_user failed, for example).  Xen has done some more wrapping
of the hypercalls to be effectively synchronous exceptions on error.
Keir, Ian, is that preferred method going forward?

thanks,
-chris
