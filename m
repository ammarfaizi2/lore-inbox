Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWJ0Pxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWJ0Pxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 11:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWJ0Pxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 11:53:33 -0400
Received: from c60.cesmail.net ([216.154.195.49]:5478 "EHLO c60.cesmail.net")
	by vger.kernel.org with ESMTP id S1750933AbWJ0Pxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 11:53:32 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Pavel Roskin <proski@gnu.org>
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <B5254A8D-0E60-4C51-AF71-7F76F3B8B917@e18.physik.tu-muenchen.de>
References: <1161807069.3441.33.camel@dv>
	 <1161808227.7615.0.camel@localhost.localdomain>
	 <20061025205923.828c620d.akpm@osdl.org>
	 <1161859199.12781.7.camel@localhost.localdomain>
	 <1161890340.9087.28.camel@dv>  <20061026214600.GL27968@stusta.de>
	 <1161901793.9087.110.camel@dv>
	 <B5254A8D-0E60-4C51-AF71-7F76F3B8B917@e18.physik.tu-muenchen.de>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 11:53:30 -0400
Message-Id: <1161964410.2469.20.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roland,

On Fri, 2006-10-27 at 14:52 +0200, Roland Kuhn wrote:

> Maybe everyone would be more happy if this "completely different API"  
> would live at lower priviledge level, e.g. ring 1, so it could not  
> screw up kernel internals? Is this technically possible? Maybe it's  
> the same thing, but another way could be to run NDIS stuff inside a  
> xen-like virtual environment... Has anyone tried yet?

I think it would be better to move this discussion to ndiswrapper
<ndiswrapper-general@lists.sourceforge.net>

I'm not familiar with the fine details of ndiswrapper implementation and
neither am I good at understanding memory management in Linux, but I
suspect it's not worth the trouble.

I believe there is no "ring 1" on x86_64 (unless it's in i386
compatibility mode).  So it would work on i386 only.  Maybe x86_64 could
use its "ring 3" equivalent, i.e. standard userspace permissions, but I
don't think it would be what you want.

Even on i386, I don't see an easy way to allocate executable memory with
ring 1 permissions.  See include/asm-i386/pgtable.h.

I suspect that there is no support for running kernel code at anything
but "ring 0".  What do you think are the chances that support for
low-privileged kernel code will be added to the kernel just for
ndiswrapper?  I think the chances are pretty slim.

In the case of the PCI driver, some critical operations would have to be
passed to the NDIS driver, such as IRQ and DMA processing.  It would be
better to make sure that the code has the necessary priority to do it
fast and correctly.

In the case of the USB driver, it may be better to go all the way to the
standard userspace.  This would require a protocol to pass network API
to the userspace, including wireless extensions.  I believe the work is
underway.

-- 
Regards,
Pavel Roskin

