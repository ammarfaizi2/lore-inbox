Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTE3RTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 13:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTE3RTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 13:19:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34035 "EHLO
	orion.mvista.com") by vger.kernel.org with ESMTP id S263823AbTE3RTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 13:19:35 -0400
Date: Fri, 30 May 2003 10:32:54 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: jsun@mvista.com, Ralf Baechle <ralf@linux-mips.org>
Subject: Properly implement flush_dcache_page in 2.4?  (Or is it possible?)
Message-ID: <20030530103254.B1669@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My understanding is that if a page is mapped in both user space
and kernel space flush_dcache_page() is used to ensure those mappings
are consistent to each other.

In other words, if the page is modified in user space, kernel needs
to call flush_dcache_page() in order to see the change properly. 
Vice versa.

One immediate problem we have is that given the struct page
pointer argument to this function we have no way of knowing the user 
space virture address of that page (without searching through the whole
page table).  And worse, we might have multiple mappings of the same
page to different user processes at the different virtual addresses.

If a MIPS cpu has a virtually-indexed dcache and has cache aliasing 
problem, we need to know those user space vritual addresses
to flush this page properly.  I suspect some other CPU architectures 
should have this problem too.  True?

So my question is: how other CPU arches with the same problem
implement flush_dcache_page()?  Flushing the whole cache? Or
have a broken implementation and pretend it is OK?  :)

BTW, I assume this is not a big problem in 2.5 as we have reverse page
mapping.

Cheers.

Jun

