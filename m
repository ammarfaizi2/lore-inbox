Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVCBWtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVCBWtp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVCBWql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:46:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:48847 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262469AbVCBWoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:44:20 -0500
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <20050302182205.GI1220@austin.ibm.com>
References: <422428EC.3090905@jp.fujitsu.com> <42249A44.4020507@pobox.com>
	 <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org>
	 <20050302182205.GI1220@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 09:41:43 +1100
Message-Id: <1109803303.5611.108.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-02 at 12:22 -0600, Linas Vepstas wrote:
> On Tue, Mar 01, 2005 at 08:49:45AM -0800, Linus Torvalds was heard to remark:
> > 
> > The new API is what _allows_ a driver to care. It doesn't handle DMA, but
> > I think that's because nobody knows how to handle it (ie it's probably
> > hw-dependent and all existign implementations would thus be
> > driver-specific anyway).
> 
> ?  
> We could add a call 
> 
> int pci_was_there_an_error_during_dma (struct pci_dev);
> 
> right?  And it could return true/false, right?  I can certainly 
> do that today with ppc64.  I just can't tell you which dma triggered
> the problem.

That's ugly. I prefer asynchronous notification by far.

> > And yes, CLEARLY drivers will have to do all the heavy lifting. 
> 
> well .. maybe.  On ppc64, we have one hack-ish solution for
> hotplug-capable but pci-error-unaware device drivers, and that
> is to hot unplug the driver, clear the pci error condition, and 
> and replug the driver.  Works great for ethernet; haven't tested 
> USB.
> 
> I'm getting greif from the guys over here because my hack-ish code
> is hackish, and isn't arch-generic, and Paul Mackerras doesn't like it, 
> which is why Benh is threatening to re-write it, and etc. ... 
> which is why Seto is involved, and we're having this conversation ... 
> 
> 
> --linas
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

