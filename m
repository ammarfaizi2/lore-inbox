Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVCNSMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVCNSMO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVCNSMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:12:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53522 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261685AbVCNSLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:11:18 -0500
Date: Mon, 14 Mar 2005 18:11:08 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matthew Wilcox <willy@parisc-linux.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, matthew@wil.cx
Subject: Re: [PATCH] Releasing resources with children
Message-ID: <20050314181108.A4705@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Wilcox <willy@parisc-linux.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, matthew@wil.cx
References: <20050314174916.B49754957B9@palinux.hppa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050314174916.B49754957B9@palinux.hppa>; from willy@parisc-linux.org on Mon, Mar 14, 2005 at 10:49:16AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 10:49:16AM -0700, Matthew Wilcox wrote:
> What does it mean to release a resource with children?  Should the
> children become children of the released resource's parent?  Should they
> be released too?  Should we fail the release?

I've been running kernels with:

+       if (old->child) {
+               printk("Resource %p still has children: %s\n", old, old->name);
+               return -EINVAL;
+       }
+

here and it hasn't triggered once.  I suspect the reason it hasn't is
because no one does release a resource with children, but I suspect
that's just by mere luck than design.

The only thing I'd question is whether we really need to BUG_ON() here.
ISTR Linus' policy for BUG()/BUG_ON() was only if the condition lead
directly to a filesystem-corrupting bug.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
