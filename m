Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751851AbWCILlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbWCILlk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWCILlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:41:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8723 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751851AbWCILlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:41:39 -0500
Date: Thu, 9 Mar 2006 12:41:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: bcollins@debian.org, scjody@modernduck.com
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: drivers/ieee1394/ohci1394.c: function calls without effect
Message-ID: <20060309114138.GA21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While investigating two (incorrect) errors of the Coverity checker, I 
found the following in drivers/ieee1394/ohci1394.c:ohci1394_pci_remove():

                /* Free IR dma */
                free_dma_rcv_ctx(&ohci->ir_legacy_context);

                /* Free IT dma */
                free_dma_trm_ctx(&ohci->it_legacy_context);

                /* Free IR legacy dma */
                free_dma_rcv_ctx(&ohci->ir_legacy_context);


Both functions contain:


<--  snip  -->

static void free_dma_rcv_ctx(struct dma_rcv_ctx *d)
{
        int i;
        struct ti_ohci *ohci = d->ohci;

        if (ohci == NULL)
                return;
...
        /* Mark this context as freed. */
        d->ohci = NULL;
}

<--  snip  -->


There are no other return possibilities in these functions.


Therefore, the latter two of the three function calls above aren't doing 
anything.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

