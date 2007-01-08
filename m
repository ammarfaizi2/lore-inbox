Return-Path: <linux-kernel-owner+w=401wt.eu-S1030441AbXAHBri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbXAHBri (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 20:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbXAHBri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 20:47:38 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:51518 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030431AbXAHBrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 20:47:37 -0500
Message-ID: <45A1A2B7.8000601@garzik.org>
Date: Sun, 07 Jan 2007 20:47:35 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH libata #promise-sata-pata] sata_promise: 2037x PATAPI
 support
References: <200701072239.l07Mdju7028895@harpo.it.uu.se>
In-Reply-To: <200701072239.l07Mdju7028895@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> @@ -789,8 +789,14 @@ static void pdc_exec_command_mmio(struct
>  static int pdc_check_atapi_dma(struct ata_queued_cmd *qc)
>  {
>  	u8 *scsicmd = qc->scsicmd->cmnd;
> +	struct ata_port *ap = qc->ap;
> +	struct pdc_host_priv *hp = ap->host->private_data;
>  	int pio = 1; /* atapi dma off by default */
>  
> +	/* First generation chips cannot use ATAPI DMA on SATA ports */
> +	if (!(hp->flags & PDC_FLAG_GEN_II) && sata_scr_valid(ap))
> +		return 1;
> +
>  	/* Whitelist commands that may use DMA. */
>  	switch (scsicmd[0]) {
>  	case WRITE_12:


IMO creating a new check_atapi_dma function for first-gen chips would be 
the preferred way to add this check.

	Jeff


