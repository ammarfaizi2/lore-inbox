Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbTE3Wqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 18:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264150AbTE3Wqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 18:46:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:10486 "EHLO
	orion.mvista.com") by vger.kernel.org with ESMTP id S264142AbTE3Wqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 18:46:42 -0400
Date: Fri, 30 May 2003 16:00:02 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Cc: jsun@mvista.com
Subject: Re: Properly implement flush_dcache_page in 2.4?  (Or is it possible?)
Message-ID: <20030530160002.D1669@mvista.com>
References: <20030530103254.B1669@mvista.com> <20030530190929.E9419@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030530190929.E9419@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, May 30, 2003 at 07:09:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 07:09:29PM +0100, Russell King wrote:
> On Fri, May 30, 2003 at 10:32:54AM -0700, Jun Sun wrote:
> > So my question is: how other CPU arches with the same problem
> > implement flush_dcache_page()?  Flushing the whole cache? Or
> > have a broken implementation and pretend it is OK?  :)
> 
> See __flush_dcache_page() in arch/arm/mm/fault-armv.c in 2.5.70.
>

Is this routine tested to be working?  At least passing a page
index as a full virtual address to flush_cache_page() looks suspicious.

In addition, I am not sure if the vma struct will show up in the
"shared" list _if_ the page is only mapped in one user process and
in kernel (for example, those pages you obtain through get_user_pages()
call).

I am not familiar with 2.5 kernel.  I was under impression that reverse
page mapping might provide an easy solution to this problem.

Jun
