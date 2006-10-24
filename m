Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422758AbWJXWge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422758AbWJXWge (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422760AbWJXWge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:36:34 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:61162 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1422758AbWJXWgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:36:33 -0400
Date: Tue, 24 Oct 2006 16:36:32 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Roland Dreier <rdreier@cisco.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, John Partridge <johnip@sgi.com>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
Message-ID: <20061024223631.GT25210@parisc-linux.org>
References: <adafyddcysw.fsf@cisco.com> <20061024192210.GE2043@havoc.gtf.org> <20061024214724.GS25210@parisc-linux.org> <adar6wxbcwt.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adar6wxbcwt.fsf@cisco.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 02:51:30PM -0700, Roland Dreier wrote:
>  > I think the right way to fix this is to ensure mmio write ordering in
>  > the pci_write_config_*() implementations.  Like this.
> 
> I'm happy to fix this in the PCI core and not force drivers to worry
> about this.
> 
> John, can you confirm that this patch fixes the issue for you?

Hang on.  I wasn't thinking clearly.  mmiowb() only ensures the write
has got as far as the shub.  There's no way to fix this in the pci core
-- any PCI-PCI bridge can reorder the two.

This is only really a problem for setup (when we program the BARs), so
it seems silly to enforce an ordering at any other time.  Reluctantly, I
must disagree with Jeff -- drivers need to fix this.
