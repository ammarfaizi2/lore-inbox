Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263745AbUFQUMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbUFQUMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 16:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUFQUMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 16:12:22 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:24007 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262337AbUFQUMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 16:12:20 -0400
Subject: Re: Proposal for new generic device API: dma_get_required_mask()
From: James Bottomley <James.Bottomley@steeleye.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20040617152818.GZ20511@parcelfarce.linux.theplanet.co.uk>
References: <1087481331.2210.27.camel@mulgrave> 
	<20040617152818.GZ20511@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 17 Jun 2004 15:12:17 -0500
Message-Id: <1087503138.1795.60.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-17 at 10:28, Matthew Wilcox wrote:
> So let's look at the sym2 implementation to see how this would work.
> A straight diff -u is not terribly helpful, So let's try a more verbose
> context diff:

actually, no.  I'm proposing an additional API, not a modification to
dma_set_mask(), so the new code would read

       struct pci_dev *pdev = &np->s.device;
 
        if (np->features & FE_DAC) {
               if (dma_set_mask(&pdev->dev, 0xffffffffffULL))
	               if (dma_get_required_mask(&pdev->dev) > 0xffffffffUL)
        	               goto use_dac;
		
        }
 
       dma_set_mask(&pdev->dev, 0xffffffffUL);
        return 0;
  
  use_dac:
       np->use_dac = 1;
       printf_info("%s: using 64 bit DMA addressing\n", sym_name(np));
       return 0;

James


