Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVCAP1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVCAP1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 10:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVCAP1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 10:27:49 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45068 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261940AbVCAP1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 10:27:39 -0500
Date: Tue, 1 Mar 2005 15:27:35 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc5-mm1
Message-ID: <20050301152735.B1940@flint.arm.linux.org.uk>
Mail-Followup-To: Valdis.Kletnieks@vt.edu, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050301012741.1d791cd2.akpm@osdl.org> <200503011336.j21DaaqC008164@turing-police.cc.vt.edu> <20050301135529.A1940@flint.arm.linux.org.uk> <200503011518.j21FIuQl004840@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200503011518.j21FIuQl004840@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Tue, Mar 01, 2005 at 10:18:56AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 10:18:56AM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 01 Mar 2005 13:55:29 GMT, Russell King said:
> > The PCI updates change the prototype of a helper function for 
> > pci_bus_alloc_resource(), but don't touch the actual helper function
> > in PCMCIA.
> 
> That explains the warning messages that gcc was tossing, which I suspected was
> involved...
> 
> > This means that the PCI update is actually broken - if it's merged as
> > is into Linus' tree, PCMCIA will break there as well.
> 
> Is the patch made to PCI actually incorrect, or is the proper way to do this
> to propagate the changes into the relevant PCMCIA code?

PCI has been updated to accept 64-bit resources, but the PCMCIA code 
has been missed.  So the correct fix is to propagate the changes where
necessary into the PCMCIA code.

The minimalist solution is to fix up the PCMCIA alignment functions.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
