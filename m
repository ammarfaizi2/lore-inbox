Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWHCGTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWHCGTV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 02:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWHCGTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 02:19:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750841AbWHCGTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 02:19:20 -0400
Date: Wed, 2 Aug 2006 23:19:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, jeremy@goop.org, zach@vmware.com,
       chrisw@sous-sol.org
Subject: Re: [patch 7/8] Add a bootparameter to reserve high linear address
 space.
Message-Id: <20060802231912.ed77f930.akpm@osdl.org>
In-Reply-To: <20060803002518.595166293@xensource.com>
References: <20060803002510.634721860@xensource.com>
	<20060803002518.595166293@xensource.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2006 17:25:17 -0700
Jeremy Fitzhardinge <jeremy@xensource.com> wrote:

> +		/*
> +		 * reservetop=size reserves a hole at the top of the kernel
> +		 * address space which a hypervisor can load into later.
> +		 * Needed for dynamically loaded hypervisors, so relocating
> +		 * the fixmap can be done before paging initialization.
> +		 * This hole must be a multiple of 4M.
> +		 */
> +		else if (!memcmp(from, "reservetop=", 11)) {
> +			unsigned long reserve = memparse(from+11, &from);
> +			reserve &= ~0x3fffff;
> +			reserve_top_address(reserve);
> +		}

I assume that this argument will normally be passed in via the hypervisor
rather than by human-entered information?

In which case, perhaps a panic would be a more appropriate response to a
non-multiple-of-4M.

Either way, rounding the number down rather than up seems wrong...
