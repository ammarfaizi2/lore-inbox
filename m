Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVEZWud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVEZWud (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 18:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVEZWuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 18:50:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:19690 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261716AbVEZWrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 18:47:05 -0400
Date: Thu, 26 May 2005 15:53:30 -0700
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Changing pci_iounmap to take 'bar' argument
Message-ID: <20050526225330.GA20370@kroah.com>
References: <1117080454.9076.25.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117080454.9076.25.camel@gaston>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2005 at 02:07:34PM +1000, Benjamin Herrenschmidt wrote:
> Hi !
> 
> On ppc and ppc64 platforms, pci_iounmap() currently does nothing, which
> is bogus (leak of ioremap space for mmio). It needs to iounmap for MMIOs
> and do nothign for IO space.
> 
> The problem is that wether it's IO or MMIO cannot be easily deduced from
> the virtual address. We _could_ change the whole thing on ppc32 to play
> tricks with the top address bits, and we could compare the virtual
> address with the known regions containing PHBs IO space, but that sounds
> to me like working around a bad API in the first place.
> 
> What about, instead, just adding the "int bar" argument to pci_iounmap()
> like we pass to pci_iomap() so it can access the resource flags ?
> 
> If it's ok with you, I'll send a patch doing it later today.

Fine with me.

thanks,

greg k-h
