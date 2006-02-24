Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWBXU4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWBXU4g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWBXU4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:56:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29198 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932493AbWBXU4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:56:35 -0500
Date: Fri, 24 Feb 2006 20:56:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] inflate pt1: refactor boot-time inflate code
Message-ID: <20060224205626.GB28855@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <1.399206195@selenic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1.399206195@selenic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 02:12:15PM -0600, Matt Mackall wrote:
> This is a refactored version of the lib/inflate.c:
> 
> - clean up some really ugly code
> - clean up atrocities like '#include "../../../lib/inflate.c"'
> - drop a ton of cut and paste code from the kernel boot
> - move towards making the boot decompressor pluggable
> - move towards unifying the multiple inflate implementations
> - save space
> 
> I'm sending this out in three batches. This first batch is core
> clean-ups without arch-specific changes.
> 
> (This work was sponsored in part by the CE Linux Forum.)

ISTR something like this was posted months back, but I don't remember
what the status of it was.  Hence, I might be repeating myself in this
reply, but I feel it's better to mention this than not to.

There's a comment at the top of arch/arm/boot/compressed/misc.c which
describes the use of the inflate code on ARM - for the kernel it's a
special case where the decompressor is run from ROM.

There's also another twist to it though - our relocatable zImage
requires us to build all files in the executable part of zImage
without _any_ static variables.  If there's one or more static
variables, this feature breaks horribly (and silently in the non-
relocated cases.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
