Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316978AbSGCIxC>; Wed, 3 Jul 2002 04:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316981AbSGCIxB>; Wed, 3 Jul 2002 04:53:01 -0400
Received: from 89dyn229.com21.casema.net ([62.234.20.229]:17869 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S316978AbSGCIxB>; Wed, 3 Jul 2002 04:53:01 -0400
Message-Id: <200207030854.KAA02662@cave.bitwizard.nl>
Subject: Re: Rusty's module talk at the Kernel Summit
In-Reply-To: <200207030731.AAA03720@adam.yggdrasil.com> from "Adam J. Richter"
 at "Jul 3, 2002 00:31:35 am"
To: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 3 Jul 2002 10:54:34 +0200 (MEST)
CC: kaos@ocs.com.au, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice: Read http://www.bitwizard.nl/cou.html for the licence to my Emailaddr.
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> >The total saving over all 2.5.24 modules is 4% of the total module
> >sizes, rounded to page boundaries.
> 
>       As individual space optimizations go, 4% is respectable,
> especially for something that has no cost, helps detect bugs and
> simplifies the kernel.  It is hard to think of many potential
> other space improvements that would as effective, especially as
> function of implementation effort.  In comparison, my vmlinux is
> 5% init sections.  So, if init sections are worth it for the
> core kernel, they should be worth it for modules.

Ehmmm. You normally load one big 1Mb kernel, freeing about 40 or 50k
at init time.

You normally load a couple of modules, totalling much less. 

Hmm. Just checked on a system with sound as modules, I see half a
megabyte of modules. So maybe that 20k is worth it. On the other hand,
you only load half a megabyte of shit if you have the RAM to spare.
20k is not worth the time I spend typing this....


> >Most of that saving comes from a few modules.
> 
> 	This makes me wonder if __init procedures are not being
> aggressively identified.  I wonder if people would use __init a little
> more if they knew they would get the benefit of it in the module case.
> Perhaps someday someone will write a tool to identify procedures that
> are only called from init sections.

Sometimes the "error path" will try to reset/reinit the chip. You will
not see that happening during a normal usage cycle, but you will get
bitten if you remove the init based on an actual call-trace.... 

> 	Kernel modules have been a way of life for me for years, and I
> don't think I've ever caught a kernel bug by the mechanism that you

This happens often enough "during development" that the bugs get fixed
before you get to see them....

> describe.  However, I see no harm in having a debugging option that
> always vmalloc'ed kernel modules.  This faciilty could be entirely
> configuarable from user level by having insmod allocate a module of
> *exactly* one page for modules that were less than a page (since you
> would only want to kmalloc modules that were *less* than one page).

As far as I know, kmallocing more than half a page will actually
allocate the whole page. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
