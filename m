Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVCBSYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVCBSYP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVCBSYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:24:04 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:42985 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262413AbVCBSWI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 13:22:08 -0500
Date: Wed, 2 Mar 2005 12:22:05 -0600
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Message-ID: <20050302182205.GI1220@austin.ibm.com>
References: <422428EC.3090905@jp.fujitsu.com> <42249A44.4020507@pobox.com> <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 08:49:45AM -0800, Linus Torvalds was heard to remark:
> 
> The new API is what _allows_ a driver to care. It doesn't handle DMA, but
> I think that's because nobody knows how to handle it (ie it's probably
> hw-dependent and all existign implementations would thus be
> driver-specific anyway).

?  
We could add a call 

int pci_was_there_an_error_during_dma (struct pci_dev);

right?  And it could return true/false, right?  I can certainly 
do that today with ppc64.  I just can't tell you which dma triggered
the problem.

> And yes, CLEARLY drivers will have to do all the heavy lifting. 

well .. maybe.  On ppc64, we have one hack-ish solution for
hotplug-capable but pci-error-unaware device drivers, and that
is to hot unplug the driver, clear the pci error condition, and 
and replug the driver.  Works great for ethernet; haven't tested 
USB.

I'm getting greif from the guys over here because my hack-ish code
is hackish, and isn't arch-generic, and Paul Mackerras doesn't like it, 
which is why Benh is threatening to re-write it, and etc. ... 
which is why Seto is involved, and we're having this conversation ... 


--linas

