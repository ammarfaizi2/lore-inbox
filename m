Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbULJW1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbULJW1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 17:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbULJW0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 17:26:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46292 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261858AbULJWZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 17:25:18 -0500
Date: Fri, 10 Dec 2004 17:24:55 -0500
From: Dave Jones <davej@redhat.com>
To: Miguel Angel Flores <maf@sombragris.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aic7xxx driver warning
Message-ID: <20041210222455.GE6648@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Miguel Angel Flores <maf@sombragris.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41BA201C.9090103@sombragris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BA201C.9090103@sombragris.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 11:15:56PM +0100, Miguel Angel Flores wrote:
 > Hi all,
 > 
 > These are two possible patches for the 2.6.10rc3. The patches correct a 
 > compiler warning when CONFIG_HIGHMEM64G is not defined.
 > 
 > Both patches works well. "Opt1" is the Alan Cox way and "Opt2" is the 
 > MaF way :-)

-       mask_39bit = 0x7FFFFFFFFFULL;
        if (sizeof(dma_addr_t) > 4
         && ahc_linux_get_memsize() > 0x80000000
         && pci_set_dma_mask(pdev, mask_39bit) == 0) {
+               mask_39bit = (dma_addr_t)0x7FFFFFFFFFULL;
                ahc->flags |= AHC_39BIT_ADDRESSING;
                ahc->platform_data->hw_dma_mask = mask_39bit;
        } else {

How can this work ? You're using mask_39bit before you set it
(See the pci_set_dma_mask call)

		Dave

