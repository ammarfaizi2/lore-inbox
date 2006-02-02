Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWBBLqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWBBLqF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWBBLqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:46:05 -0500
Received: from [85.8.13.51] ([85.8.13.51]:37098 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750703AbWBBLqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:46:04 -0500
Message-ID: <43E1F0F3.3020801@drzeus.cx>
Date: Thu, 02 Feb 2006 12:45:55 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060128)
MIME-Version: 1.0
To: Tony Lindgren <tony@atomide.com>,
       Anderson Briglia <anderson.briglia@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/5] MMC OMAP driver
References: <43DF6750.1060505@indt.org.br> <20060201124434.GC3072@flint.arm.linux.org.uk> <20060201194724.GD15939@atomide.com> <20060202104022.GF5034@flint.arm.linux.org.uk>
In-Reply-To: <20060202104022.GF5034@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Here's a revised patch.  Pierre - could you look at the missing command
> types marked with /* ? */ in this patch please?
>
>   

*snip*

> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -211,7 +211,7 @@ int mmc_wait_for_app_cmd(struct mmc_host
>  
>  		appcmd.opcode = MMC_APP_CMD;
>  		appcmd.arg = rca << 16;
> -		appcmd.flags = MMC_RSP_R1;
> +		appcmd.flags = MMC_RSP_R1 | MMC_CMD_AC; /* ? */
>  		appcmd.retries = 0;
>  		memset(appcmd.resp, 0, sizeof(appcmd.resp));
>  		appcmd.data = NULL;
>   

Correct.

> @@ -358,7 +358,7 @@ static int mmc_select_card(struct mmc_ho
>  			struct mmc_command cmd;
>  			cmd.opcode = SD_APP_SET_BUS_WIDTH;
>  			cmd.arg = SD_BUS_WIDTH_4;
> -			cmd.flags = MMC_RSP_R1;
> +			cmd.flags = MMC_RSP_R1; /* ? */
>  
>  			err = mmc_wait_for_app_cmd(host, card->rca, &cmd,
>  				CMD_RETRIES);
>   

MMC_CMD_AC

> @@ -766,7 +766,7 @@ static int mmc_send_app_op_cond(struct m
>  
>  	cmd.opcode = SD_APP_OP_COND;
>  	cmd.arg = ocr;
> -	cmd.flags = MMC_RSP_R3;
> +	cmd.flags = MMC_RSP_R3; /* ? */
>  
>  	for (i = 100; i; i--) {
>  		err = mmc_wait_for_app_cmd(host, 0, &cmd, CMD_RETRIES);
>   

MMC_CMD_BCR

> @@ -835,7 +835,7 @@ static void mmc_discover_cards(struct mm
>  
>  			cmd.opcode = SD_SEND_RELATIVE_ADDR;
>  			cmd.arg = 0;
> -			cmd.flags = MMC_RSP_R6;
> +			cmd.flags = MMC_RSP_R6; /* ? */
>  
>  			err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
>  			if (err != MMC_ERR_NONE)
>   

MMC_CMD_BCR (feel free to update protocol.h since it's incorrect with 
regard to this opcode)

> @@ -920,7 +920,7 @@ static void mmc_read_scrs(struct mmc_hos
>  
>  		cmd.opcode = MMC_APP_CMD;
>  		cmd.arg = card->rca << 16;
> -		cmd.flags = MMC_RSP_R1;
> +		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC; /* ? */
>  
>  		err = mmc_wait_for_cmd(host, &cmd, 0);
>  		if ((err != MMC_ERR_NONE) || !(cmd.resp[0] & R1_APP_CMD)) {
>   

Correct.

> @@ -932,7 +932,7 @@ static void mmc_read_scrs(struct mmc_hos
>  
>  		cmd.opcode = SD_APP_SEND_SCR;
>  		cmd.arg = 0;
> -		cmd.flags = MMC_RSP_R1;
> +		cmd.flags = MMC_RSP_R1; /* ? */
>  
>  		memset(&data, 0, sizeof(struct mmc_data));
>   

MMC_CMD_ADTC

Rgds
Pierre

