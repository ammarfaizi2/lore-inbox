Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWGLVqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWGLVqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWGLVqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:46:12 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28599 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751433AbWGLVqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:46:11 -0400
Subject: Re: [PATCH] tpm: interrupt clear fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>,
       akpm@osdl.org
In-Reply-To: <1152738113.5347.33.camel@localhost.localdomain>
References: <1152738113.5347.33.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Jul 2006 23:04:08 +0100
Message-Id: <1152741848.22943.105.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-07-12 am 14:01 -0700, ysgrifennodd Kylene Jo Hall:
> Under stress testing I found that the interrupt is not always cleared.
> This is a bug and this patch should go into 2.6.18 and 2.6.17.x.
> 
> Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
> ---
> --- tcg/tpmdd/drivers/char/tpm/tpm_tis.c	2006-06-07 11:37:08.000000000 -0700
> +++ linux-2.6.17/drivers/char/tpm/tpm_tis.c	2006-07-10 12:58:28.000000000 -0700
> @@ -424,6 +424,7 @@ static irqreturn_t tis_int_handler(int i
>  	iowrite32(interrupt,
>  		  chip->vendor.iobase +
>  		  TPM_INT_STATUS(chip->vendor.locality));
> +	mb();

NAK

This looks incorrect.

The iowrite32 will be posted for mmio. mb() may half hide the problem on
some processors but you should read from the same PCI device as per the
PCI spec.


