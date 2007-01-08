Return-Path: <linux-kernel-owner+w=401wt.eu-S1161193AbXAHIJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbXAHIJE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbXAHIJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:09:04 -0500
Received: from aun.it.uu.se ([130.238.12.36]:51320 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161189AbXAHIJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:09:01 -0500
Date: Mon, 8 Jan 2007 09:08:53 +0100 (MET)
Message-Id: <200701080808.l0888rBb001303@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: jeff@garzik.org
Subject: Re: [PATCH libata #promise-sata-pata] sata_promise: 2037x PATAPI support
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Jan 2007 20:47:35 -0500, Jeff Garzik wrote:
> Mikael Pettersson wrote:
> > @@ -789,8 +789,14 @@ static void pdc_exec_command_mmio(struct
> >  static int pdc_check_atapi_dma(struct ata_queued_cmd *qc)
> >  {
> >  	u8 *scsicmd = qc->scsicmd->cmnd;
> > +	struct ata_port *ap = qc->ap;
> > +	struct pdc_host_priv *hp = ap->host->private_data;
> >  	int pio = 1; /* atapi dma off by default */
> >  
> > +	/* First generation chips cannot use ATAPI DMA on SATA ports */
> > +	if (!(hp->flags & PDC_FLAG_GEN_II) && sata_scr_valid(ap))
> > +		return 1;
> > +
> >  	/* Whitelist commands that may use DMA. */
> >  	switch (scsicmd[0]) {
> >  	case WRITE_12:
> 
> 
> IMO creating a new check_atapi_dma function for first-gen chips would be 
> the preferred way to add this check.

Agreed. Will do.

/Mikael
