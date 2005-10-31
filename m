Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbVJaXgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVJaXgk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 18:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVJaXgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 18:36:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44046 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932556AbVJaXgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 18:36:39 -0500
Date: Mon, 31 Oct 2005 23:36:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 17/20] inflate: mark some arrays as initdata
Message-ID: <20051031233633.GA2826@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
References: <17.196662837@selenic.com> <18.196662837@selenic.com> <20051031224301.GF20452@flint.arm.linux.org.uk> <20051031225746.GD4367@waste.org> <20051031231052.GA1710@flint.arm.linux.org.uk> <20051031231120.GF4367@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031231120.GF4367@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 03:11:21PM -0800, Matt Mackall wrote:
> On Mon, Oct 31, 2005 at 11:10:52PM +0000, Russell King wrote:
> > That's what threading is for. 8)
> 
> What's what's threading is for?
> 
> > > I think for ARM, we can simply do -DINITDATA=const, yes?
> > 
> > No, unless you want to make this const:
> > 
> > -static u8 window[0x8000]; /* use a statically allocated window */
> > +static u8 INITDATA window[0x8000]; /* use a statically allocated window */
> 
> Ok, that bit can just be dropped. It needn't be INITDATA anyway, as it
> now gets kmalloc'ed for users in the kernel proper. Anything else?

I didn't notice anything else, but it will need testing on ARM in
this configuration.

Basically, for the decompressor to work in this mode, we have to
ensure:

1. no static data
2. no initialised non-const data

gets placed into the decompressor.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
