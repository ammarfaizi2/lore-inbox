Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWDWSPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWDWSPW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 14:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWDWSPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 14:15:22 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:55653 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751437AbWDWSPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 14:15:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dRXc8qIeLl6+q9u7QQUQ3ZDXt4HsDN78Y44oGSs0aIewcBQEd+dao6EuxdlWOJioEvWqzHp8zd6tliG0XAQqb4uIK0/UyOGDmTGed9WQi7F66OLqPK2KlQ+DV/yFIt6MRytnWMOiYISAjKClYR+X9w+VYMUpsa16R1ICwn50+rI=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SCSI: aic7xxx_osm_pci resource leak fix.
Date: Sun, 23 Apr 2006 20:16:02 +0200
User-Agent: KMail/1.9.1
Cc: James.Bottomley@hansenpartnership.com, linux-scsi@vger.kernel.org,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604232016.02979.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix resource leak in 
drivers/scsi/aic7xxx/aic7xxx_osm_pci.c::ahc_linux_pci_dev_probe()

Found by the coverity checker (#668)


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.17-rc2-git4-orig/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17-rc2-git4/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2006-04-23 20:05:50.000000000 +0200
@@ -219,6 +219,7 @@ ahc_linux_pci_dev_probe(struct pci_dev *
 		ahc->flags |= AHC_39BIT_ADDRESSING;
 	} else {
 		if (dma_set_mask(dev, DMA_32BIT_MASK)) {
+			ahc_free(ahc);
 			printk(KERN_WARNING "aic7xxx: No suitable DMA available.\n");
                 	return (-ENODEV);
 		}




(please keep replies CC'ed to me)


