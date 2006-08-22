Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWHVQzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWHVQzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 12:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWHVQzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 12:55:45 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:43273 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751399AbWHVQzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 12:55:44 -0400
Date: Tue, 22 Aug 2006 17:55:36 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3] add generic udelay(), mdelay() and ssleep()
Message-ID: <20060822165536.GA31064@flint.arm.linux.org.uk>
Mail-Followup-To: Denis Vlasenko <vda.linux@googlemail.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200608221545.26019.vda.linux@googlemail.com> <200608221548.37192.vda.linux@googlemail.com> <200608221551.48423.vda.linux@googlemail.com> <200608221622.43244.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608221622.43244.vda.linux@googlemail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 04:22:43PM +0200, Denis Vlasenko wrote:
> On Tuesday 22 August 2006 15:51, Denis Vlasenko wrote:
> > > A few arch files won't see the definition of udelay()
> > > in asm/delay.h anymore. Prevent that from biting us later.
> > 
> > We are going to kill MAX_UDELAY_MS, so replace it
> > in common code with 1. Also fix a buglet on the way:
> > mpc83xx_spi->nsecs > MAX_UDELAY_MS * 1000
> > was comparing nanoseconds to microseconds.
> 
> This patch does the following:
> * make it so than asm/delay.h does not define udelay(),
>   only __udelay(), to be used in generic udelay()
> * add generic udelay() which calls __udelay() repeatedly,
>   as needed. Protect against overflow in udelay() argument.
> * similarly for mdelay() and ssleep()
> * __const_udelay for all arches is removed or renamed to
>   __const_delay (it did not do microsecond delays anyway)
>   if still used by arch ndelay() function/macro
> * remove EXPORT_SYMBOL(__udelay). It is not used in modules
>   anymore
> * remove MAX_UDELAY_MS
> 
> We specifically do not touch ndelay() in thess patches.
> It is not changed.

Please keep a "const" version in ARM.  Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
