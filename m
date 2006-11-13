Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755137AbWKMPcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbWKMPcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755138AbWKMPcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:32:31 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:138 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1755137AbWKMPcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:32:31 -0500
Message-ID: <45589008.1080001@garzik.org>
Date: Mon, 13 Nov 2006 10:32:24 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: John Fremlin <not@just.any.name>,
       kernel list <linux-kernel@vger.kernel.org>, htejun@gmail.com,
       jim.kardach@intel.com, ak@suse.de
Subject: Re: AHCI power saving (was Re: Ten hours on X60s)
References: <87k639u55l.fsf-genuine-vii@john.fremlin.org> <20061009215221.GC30702@elf.ucw.cz> <87ods6loe8.fsf-genuine-vii@john.fremlin.org> <20061025070920.GG5851@elf.ucw.cz> <87y7r3xlif.fsf-genuine-vii@john.fremlin.org> <20061026204655.GA1767@elf.ucw.cz> <87slgv6ccz.fsf-genuine-vii@john.fremlin.org> <20061112183614.GA5081@ucw.cz> <87hcx3adcd.fsf-genuine-vii@john.fremlin.org> <20061113142219.GA2703@elf.ucw.cz>
In-Reply-To: <20061113142219.GA2703@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -148,6 +148,8 @@ enum {
>  				  PORT_IRQ_PIOS_FIS | PORT_IRQ_D2H_REG_FIS,
>  
>  	/* PORT_CMD bits */
> +	PORT_CMD_ALPE		= (1 << 27), /* Aggressive Link Power Management Enable */
> +	PORT_CMD_ASP		= (1 << 26), /* Aggressive entrance to Slumber or Partial power management states */
>  	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
>  	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
>  	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
> @@ -486,7 +488,7 @@ static void ahci_power_up(void __iomem *
>  	}
>  
>  	/* wake up link */
> -	writel(cmd | PORT_CMD_ICC_ACTIVE, port_mmio + PORT_CMD);
> +	writel(cmd | PORT_CMD_ICC_ACTIVE | PORT_CMD_ALPE | PORT_CMD_ASP, port_mmio + PORT_CMD);


Therein lies a key problem.  Turning on all of AHCI's aggressive power 
management features DOES save a lot of power.  But at the same time, it 
shortens the life of your hard drive, particularly hard drives that are 
really PATA, but have a PATA<->SATA bridge glued on the drive to enable 
connection to SATA controllers.

	Jeff


