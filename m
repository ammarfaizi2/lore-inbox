Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVBHAj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVBHAj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 19:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVBHAjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 19:39:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:1701 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261346AbVBHAjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 19:39:20 -0500
Date: Mon, 7 Feb 2005 16:20:22 -0800
From: Greg KH <greg@kroah.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] pci_raw_ops should use unsigned args
Message-ID: <20050208002022.GC28803@kroah.com>
References: <1107457685.12618.23.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107457685.12618.23.camel@eeyore>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 12:08:05PM -0700, Bjorn Helgaas wrote:
> Convert pci_raw_ops to use unsigned segment (aka domain),
> bus, and devfn.  With the previous code, various ia64 config
> accesses fail due to segment sign-extension problems.
> 
> ia64:
>     - With a signed seg >= 0x8, unwanted sign-extension occurs when
>       "seg << 28" is cast to u64 in PCI_SAL_EXT_ADDRESS()
>     - PCI_SAL_EXT_ADDRESS(): cast to u64 *before* shifting; otherwise
>       "seg << 28" is evaluated as unsigned int (32 bits) and gets
>       truncated when seg > 0xf
>     - pci_sal_read(): validate "value" ptr as other arches do
>     - pci_sal_{read,write}(): return -EINVAL rather than SAL error status
> 
>  arch/i386/pci/direct.c     |   12 ++++++----
>  arch/i386/pci/mmconfig.c   |    6 +++--
>  arch/i386/pci/numa.c       |    6 +++--
>  arch/i386/pci/pcbios.c     |    6 +++--
>  arch/ia64/pci/pci.c        |   53 ++++++++++++++++++---------------------------
>  arch/x86_64/pci/mmconfig.c |    8 ++++--
>  include/linux/pci.h        |    6 +++--
>  7 files changed, 51 insertions(+), 46 deletions(-)
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Applied, thanks.

greg k-h
