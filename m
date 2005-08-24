Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVHXUTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVHXUTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 16:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVHXUTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 16:19:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932088AbVHXUTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 16:19:42 -0400
Date: Wed, 24 Aug 2005 13:19:20 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>
Subject: Re: [PATCH 5/5] Create a hole in high linear address space
Message-ID: <20050824201920.GN7762@shell0.pdx.osdl.net>
References: <200508241845.j7OIjIeM001900@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508241845.j7OIjIeM001900@zach-dev.vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Allow compile time creation of a hole at the high end of linear address space.
> This makes accomodating a hypervisor a much more tractable problem by giving
> it ample playground to live in.  Currently, the hole size is fixed at config
> time; I have experimented with dynamically sized holes, and have a later
> patch that developes this potential, but it becomes much more useful once
> the exact negotiation of linear address space with the hypervisor is defined.
> 
> The fixed compile time solution is sufficient for now.

Xen moves __FIXADDR_TOP like this:

#ifdef CONFIG_X86_PAE
# define HYPERVISOR_VIRT_START (0xF5800000UL)
#else
# define HYPERVISOR_VIRT_START (0xFC000000UL)
#endif

and

#define __FIXADDR_TOP  (HYPERVISOR_VIRT_START - 2 * PAGE_SIZE)

and also adds bits to fixmap.

So this proposed mechanism isn't quite good enough.

thanks,
-chris
