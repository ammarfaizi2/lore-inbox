Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWCBUof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWCBUof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWCBUof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:44:35 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:49078 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932531AbWCBUoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:44:34 -0500
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Dave Miller <davem@redhat.com>,
       axboe@suse.de, bzolnier@gmail.com, james.steward@dynamicratings.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org, mattjreimer@gmail.com
In-Reply-To: <20060302203039.GH28895@flint.arm.linux.org.uk>
References: <11371658562541-git-send-email-htejun@gmail.com>
	 <1137167419.3365.5.camel@mulgrave>
	 <20060113182035.GC25849@flint.arm.linux.org.uk>
	 <1137177324.3365.67.camel@mulgrave>
	 <20060113190613.GD25849@flint.arm.linux.org.uk>
	 <20060222082732.GA24320@htj.dyndns.org>
	 <1141325189.3238.37.camel@mulgrave.il.steeleye.com>
	 <20060302203039.GH28895@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 02 Mar 2006 14:43:59 -0600
Message-Id: <1141332239.3238.59.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 20:30 +0000, Russell King wrote:
> Your understanding of the problem on ARM remains fundamentally flawed.
> I see no way to resolve this since you don't seem to listen or accept
> my reasoning.

You have advanced no reason for using flush_dcache_page() instead of
flush_kernel_dcache_page() except this:

>    ISTR davem recommended flush_dcache_page() be used for this.

and this:


> 2. (this is my own)  The cachetlb document specifies quite clearly
> what
>    is required whenever a page cache page is written to - that is
>    flush_dcache_page() is called.  The situation when a driver uses
> PIO
>    quote clearly violates the requirements set out in that document.
> 

Your problem, as you state:


>    However, in the PIO case, there is the possibility that the data
> read
>    from the device into the kernel mapping results in cache lines
>    associated with the page.  Moreover, if the cache is
> write-allocate,
>    you _will_ have cache lines.
> 
>    Therefore, you have two completely differing system states
> depending
>    on how the driver decided to transfer data from the device to the
> page
>    cache.

It is my contention that flush_kernel_dcache_page() ejects the cache
lines that may be dirty in the kernel mapping and makes the underlying
memory coherent again.  This is the same net effect as a DMA transfer
(data in memory but not in kernel cache).

> Therefore, message I'm getting from you is that we are not allowed to
> have an ARM system which can possibly work correctly with PIO.
> 
> As a result, I have no further interest in trying to resolve this issue,
> period.  ARM people will just have to accept that PIO mode IDE drivers
> just will not be an option.

Could you actually address the argument instead of getting all huffy?

James


