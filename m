Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272485AbRH3VUq>; Thu, 30 Aug 2001 17:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272483AbRH3VUm>; Thu, 30 Aug 2001 17:20:42 -0400
Received: from ns2.cypress.com ([157.95.67.5]:50840 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S272474AbRH3VTT>;
	Thu, 30 Aug 2001 17:19:19 -0400
Message-ID: <3B8EADDA.8070803@cypress.com>
Date: Thu, 30 Aug 2001 16:19:22 -0500
From: Thomas Dodd <ted@cypress.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010802
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, 
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFS in 2.4.8/9ac
In-Reply-To: <E15cZ3Y-0001qB-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
>>2.4.7-ac10 worked fine.2.4.8-ac8 through 2.4.9-ac3
>>have trouble. I have not tested 2.4.8-ac[1..7] yet.
>>
> 
> Ok can you transplant drivers/net/tulip from a working -ac into the
> current tree and see if that fixes it - that tells us if its a network
> driver bug or a kernel core bug.
this is the only diff I find in the tulip directory.
(2.4.8 and 2.4.9 have no diff)

--- linux-2.4.7-ac10/drivers/net/tulip/tulip_core.c
+++ linux-2.4.9-ac3/drivers/net/tulip/tulip_core.c
@@ -1409,6 +1409,10 @@
         if (chip_idx == LC82C168)
                 csr0 &= ~0xfff10000; /* zero reserved bits 31:20, 16 */

+       /* DM9102A has troubles with MRM, clear bit 24 too. */
+       if (pdev->vendor == 0x1282 && pdev->device == 0x9102)
+               csr0 &= ~0x01200000;
+
         /*
          *      And back to business
          */
@@ -1751,9 +1755,9 @@
                 kfree (tp->mtable);
  #ifndef USE_IO_OPS
         iounmap((void *)ioaddr);
-#endif

  err_out_free_res:
+#endif
         pci_release_regions (pdev);

  err_out_free_netdev:

---------
the second hunk could be a problem.
I'll try moving the endif back tomorrow.

	-Thomas


