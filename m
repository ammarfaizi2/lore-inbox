Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUHGWpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUHGWpx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 18:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUHGWpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 18:45:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58378 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264560AbUHGWpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 18:45:42 -0400
Date: Sat, 7 Aug 2004 23:45:36 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
Subject: Re: [BUG] 2.6.8-rc3 jffs2 unable to read filesystems
Message-ID: <20040807234536.C1322@flint.arm.linux.org.uk>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-mtd@lists.infradead.org
References: <20040807141829.D2805@flint.arm.linux.org.uk> <1091915887.1438.99.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1091915887.1438.99.camel@imladris.demon.co.uk>; from dwmw2@infradead.org on Sat, Aug 07, 2004 at 10:58:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 10:58:07PM +0100, David Woodhouse wrote:
> On Sat, 2004-08-07 at 14:18 +0100, Russell King wrote:
> > This can be seen by tracing through the code from jffs2_alloc_raw_inode()
> > and noticing that previous implementations do not initialise this field -
> > AFAICS kmem_cache_alloc() does not guarantee that memory returned by
> > this function will be initialised.
> 
> Doh.
> 
> > Therefore, recent 2.6.8-rc kernels must _NOT_ use this field if they
> > wish to remain compatible with existing jffs2 filesystems.
> 
> The format is compatible in theory -- we just need to work around the
> bug in the older code. Can you try this?

Ok, this boots fine here, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
