Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161136AbWGNPsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbWGNPsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 11:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbWGNPsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 11:48:50 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:58278 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161136AbWGNPst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 11:48:49 -0400
Subject: Re: 2.6.18-rc1-mm2
From: Dave Hansen <haveblue@us.ibm.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 08:48:43 -0700
Message-Id: <1152892123.24925.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 22:48 -0700, Andrew Morton wrote:
> - Added the avr32 architecture.  Review is sought, please. 

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/broken-out/avr32-arch.patch

> +#define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
> +#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
> +#define PFN_PHYS(x)	((x) << PAGE_SHIFT)

Please use include/linux/pfn.h instead of defining these

> Since there's only a single board available, and that board has no use for
> discontigmem or sparsemem anyway, I figured it's better to just turn it off
> until a need for it arises.

How about we help you get sparsemem working properly, and you can kill
all of the discontigmem support from your arch?  You can be the first
non-legacy-impeded architecture. ;)

Feel free to mail Andy or myself with your compile errors, and I'm sure
we can iron it out.  I'd try myself, but I don't have a cross-compiler
for your arch yet.  Do you have one handy?

It would also be nice to see a _couple_ of patches that perhaps abstract
a thing or two into generic code.  I know that new architectures usually
begin with a 'cp -r', but it would be nice to see a wee bit of code
refactoring as a small price of admission.  Some of the ioremap and
other pagetable code looked pretty generic to me.

-- Dave

