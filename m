Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWFVQPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWFVQPF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWFVQPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:15:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13064 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030299AbWFVQPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:15:03 -0400
Date: Thu, 22 Jun 2006 17:14:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
Message-ID: <20060622161447.GC999@flint.arm.linux.org.uk>
Mail-Followup-To: Mel Gorman <mel@csn.ul.ie>,
	Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060621034857.35cfe36f.akpm@osdl.org> <449AB01A.5000608@innova-card.com> <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie> <449ABC3E.5070609@innova-card.com> <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 04:54:06PM +0100, Mel Gorman wrote:
> On Thu, 22 Jun 2006, Franck Bui-Huu wrote:
> >It's the default value (see memory_model.h). It means that pfn start
> >for node 0 is 0, therefore your physical memory address starts at 0.
> 
> I know, but what I'm getting at is that ARCH_PFN_OFFSET may be unnecessary 
> with flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch applied. 
> ARCH_PFN_OFFSET is used as
> 
> #define page_to_pfn(page)       ((unsigned long)((page) - mem_map) + \
>                                  ARCH_PFN_OFFSET)
> 
> because it knew that the map may not start at PFN 0. With 
> flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch, the map will 
> start at PFN 0 even if physical memory does not start until later.

Doesn't that result in a massive array of struct pages if your memory
starts a 3GB physical and has 4K pages?  If you have only 32MB in that
scenario, and that was correct, you'd gobble 25MB of that just to
store that array.  Ouch.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
