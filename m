Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbULaKAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbULaKAr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 05:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbULaKAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 05:00:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10509 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261833AbULaKAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 05:00:42 -0500
Date: Fri, 31 Dec 2004 10:00:37 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: James Nelson <james4765@verizon.net>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] esp: Make driver SMP-correct
Message-ID: <20041231100037.A29868@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	James Nelson <james4765@verizon.net>,
	kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
References: <20041231014403.3309.58245.96163@localhost.localdomain> <20041231014611.003281e5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041231014611.003281e5.akpm@osdl.org>; from akpm@osdl.org on Fri, Dec 31, 2004 at 01:46:11AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2004 at 01:46:11AM -0800, Andrew Morton wrote:
> James Nelson <james4765@verizon.net> wrote:
> >
> > This is an attempt to make the esp serial driver SMP-correct.  It also removes
> >  some cruft left over from the serial_write() conversion.
> 
> >From a quick scan:
> 
> - startup() does multiple sleeping allocations and request_irq() under
>   spin_lock_irqsave().  Maybe fixed by this:

However, can you guarantee that two threads won't enter startup() at
the same time?  (that's what ASYNC_INITIALIZED is protecting the
function against, and the corresponding shutdown() as well.)

It's probably better to port ESP to the serial_core structure where
this type of thing is already taken care of.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
