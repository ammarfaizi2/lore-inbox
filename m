Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032134AbWLGMZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032134AbWLGMZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 07:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032132AbWLGMZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 07:25:57 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:37400 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032130AbWLGMZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 07:25:56 -0500
Message-ID: <45780851.3020002@garzik.org>
Date: Thu, 07 Dec 2006 07:25:53 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: htejun@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-git7] sata_promise: new EH conversion, take 2
References: <200612062306.kB6N6p0t009272@harpo.it.uu.se>
In-Reply-To: <200612062306.kB6N6p0t009272@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> This patch converts sata_promise to use new-style libata error
> handling on Promise SATA chips, for both SATA and PATA ports.
> 
> * ATA_FLAG_SRST is no longer set
> * ->phy_reset is no longer set as it is unused when ->error_handler
>    is present, and pdc_sata_phy_reset() has been removed
> * pdc_freeze() masks interrupts and halts DMA via PDC_CTLSTAT
> * pdc_thaw() clears interrupt status in PDC_INT_SEQMASK and then
>   unmasks interrupts in PDC_CTLSTAT
> * pdc_error_handler() reinitialises the port if it isn't frozen,
>   and then invokes ata_do_eh() with standard {s,}ata reset methods
> * pdc_post_internal_cmd() resets the port in case of errors
> * the PATA-only 20619 chip continues to use old-style EH:
>   not by necessity but simply because I don't have documentation
>   for it or any way to test it
> 
> Since the previous version pdc_error_handler() has been rewritten
> and it now mostly matches ahci and sata_sil24. In case anyone
> wonders: the call to pdc_reset_port() isn't a heavy-duty reset,
> it's a light-weight reset to quickly put a port into a sane state.
> 
> The discussion about the PCI flushes in pdc_freeze() and pdc_thaw()
> seemed to end with a consensus that the flushes are OK and not
> obviously redundant, so I decided to keep them for now.
> 
> This patch was prepared against 2.6.19-git7, but it also applies
> to 2.6.19 + libata #upstream, with or without the revised sata_promise
> cleanup patch I recently submitted.
> 
> This patch does conflict with the #promise-sata-pata patch:
> this patch removes pdc_sata_phy_reset() while #promise-sata-pata
> modifies it. The correct patch resolution is to remove the function.
> 
> Tested on 2037x and 2057x chips, with PATA patches on top and disks
> on both SATA and PATA ports.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

applied

Now that new EH is in place, I bet hotplug support would be easy....

	Jeff



