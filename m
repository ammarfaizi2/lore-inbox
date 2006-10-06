Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422905AbWJFT2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422905AbWJFT2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422903AbWJFT2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:28:44 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:21670 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1422650AbWJFT2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 15:28:43 -0400
Date: Fri, 6 Oct 2006 13:28:42 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Garzik <jeff@garzik.org>
Cc: Val Henson <val_henson@linux.intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] [TULIP] Check the return value from pci_set_mwi()
Message-ID: <20061006192842.GO2563@parisc-linux.org>
References: <1160161519800-git-send-email-matthew@wil.cx> <11601615192857-git-send-email-matthew@wil.cx> <4526AB43.7030809@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4526AB43.7030809@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 03:15:15PM -0400, Jeff Garzik wrote:
> Matthew Wilcox wrote:
> >Also, pci_set_mwi() will fail if the cache line
> >size is 0, so we don't need to check that ourselves any more.
> 
> NAK, not true on all arches.  sparc64 at least presumes that the 
> firmware DTRT with cacheline size, which hurts us now given this tulip patch

How does it hurt us?

int pcibios_prep_mwi(struct pci_dev *dev)
{
        /* We set correct PCI_CACHE_LINE_SIZE register values for every
         * device probed on this platform.  So there is nothing to check
         * and this always succeeds.
         */
        return 0;
}

If Dave's wrong about that, it hurts him, not us ;-)

It's still not necessary for the Tulip driver to check.
