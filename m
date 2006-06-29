Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932870AbWF2Jop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870AbWF2Jop (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 05:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932874AbWF2Jop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 05:44:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:56250 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932870AbWF2Joo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 05:44:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fGtL9VerQPHdcGtvZ2aMJHwq+Sa5/7e+HKNdI3thrRmlYtnk3FkpzQU+bwFc76StR+9rGRm5pm8D2WqeflPJHgX9zE5cf45lKT3XW5apGkUx2oJtEtNKE0KgfB/YZrEiwYi5oWDJGz4v4ScLF64gdCFZPRfUxNOevfPXXvAiP5g=
Message-ID: <40f323d00606290244y26898d1bk1c21a40a71b0ed9b@mail.gmail.com>
Date: Thu, 29 Jun 2006 11:44:43 +0200
From: "Benoit Boissinot" <bboissin@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm4
Cc: linux-kernel@vger.kernel.org, "Chris Leech" <christopher.leech@intel.com>
In-Reply-To: <20060629013643.4b47e8bd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060629013643.4b47e8bd.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm4/
>
>
> - The RAID patches have been dropped due to testing failures in -mm3.
>
> - The SCSI Attached Storage tree (git-sas.patch) has been restored.
>

Fix a warning in ioatdma:

drivers/dma/ioatdma.c: In function 'ioat_init_module':
drivers/dma/ioatdma.c:830: warning: control reaches end of non-void function

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

Index: linux/drivers/dma/ioatdma.c
===================================================================
--- linux.orig/drivers/dma/ioatdma.c
+++ linux/drivers/dma/ioatdma.c
@@ -826,7 +826,7 @@ static int __init ioat_init_module(void)
 	/* if forced, worst case is that rmmod hangs */
 	__unsafe(THIS_MODULE);

-	pci_module_init(&ioat_pci_drv);
+	return pci_module_init(&ioat_pci_drv);
 }

 module_init(ioat_init_module);
