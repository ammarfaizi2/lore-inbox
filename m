Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422666AbWJFUAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbWJFUAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422682AbWJFUAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:00:11 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:20905 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422666AbWJFUAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:00:10 -0400
Message-ID: <4526B5BD.4030809@garzik.org>
Date: Fri, 06 Oct 2006 15:59:57 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Val Henson <val_henson@linux.intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] [TULIP] Check the return value from pci_set_mwi()
References: <1160161519800-git-send-email-matthew@wil.cx> <11601615192857-git-send-email-matthew@wil.cx> <4526AB43.7030809@garzik.org> <20061006192842.GO2563@parisc-linux.org>
In-Reply-To: <20061006192842.GO2563@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Fri, Oct 06, 2006 at 03:15:15PM -0400, Jeff Garzik wrote:
>> Matthew Wilcox wrote:
>>> Also, pci_set_mwi() will fail if the cache line
>>> size is 0, so we don't need to check that ourselves any more.
>> NAK, not true on all arches.  sparc64 at least presumes that the 
>> firmware DTRT with cacheline size, which hurts us now given this tulip patch
> 
> How does it hurt us?
> 
> int pcibios_prep_mwi(struct pci_dev *dev)
> {
>         /* We set correct PCI_CACHE_LINE_SIZE register values for every
>          * device probed on this platform.  So there is nothing to check
>          * and this always succeeds.
>          */
>         return 0;
> }
> 
> If Dave's wrong about that, it hurts him, not us ;-)
> 
> It's still not necessary for the Tulip driver to check.

The unmodified tulip driver checks both MWI and cacheline-size because 
one of the clones (PNIC or PNIC2) will let you set the MWI bit, but 
hardwires cacheline size to zero.

If the arches do not behave consistently, we need to keep the check in 
the tulip driver, to avoid incorrectly programming the csr0 MWI bit.

	Jeff



