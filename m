Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWJONw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWJONw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 09:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWJONw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 09:52:58 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:28044 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S964830AbWJONwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 09:52:54 -0400
Date: Sun, 15 Oct 2006 07:52:51 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: David Brownell <david-b@pacbell.net>
Cc: akpm@osdl.org, val_henson@linux.intel.com, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [Bulk] Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Message-ID: <20061015135251.GB22289@parisc-linux.org>
References: <1160161519800-git-send-email-matthew@wil.cx> <20061013214135.8fbc9f04.akpm@osdl.org> <20061014140249.GL11633@parisc-linux.org> <20061014134855.b66d7e65.akpm@osdl.org> <20061015032000.GP11633@parisc-linux.org> <20061015070809.978C714552@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061015070809.978C714552@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2006 at 12:08:09AM -0700, David Brownell wrote:
> > But the only effect of returning EINVAL is a printk (for this particular
> > driver):
> >
> >         /* PCI Memory-Write-Invalidate cycle support is optional (uncommon) */
> >         retval = pci_set_mwi(pdev);
> >         if (!retval)
> >                 ehci_dbg(ehci, "MWI active\n");
> 
> Erm, I've lost context here but it's completely legit for hardware
> to NOT support MWI, so it is in no way an error if it's not set.
> (Memory-Write-Invalidate is just a more efficient way to write data
> that may be cached; if the device can't issue those cycles, there's
> no loss of correctness.)
> 
> Since it's not an error, there should be no such printk ... which
> is exactly how it's coded above.
> 
> Who is issuing the printk on a non-error code path??

Er, that would be the EHCI driver, which you wrote ...
