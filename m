Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWFKNOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWFKNOf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 09:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWFKNOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 09:14:35 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:2267 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751273AbWFKNOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 09:14:34 -0400
Message-ID: <448C1732.3060809@garzik.org>
Date: Sun, 11 Jun 2006 09:14:26 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: HighPoint Linux Team <linux@highpoint-tech.com>
CC: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] hptiop: HighPoint RocketRAID 3xxx controller driver
References: <200606111706.52930.linux@highpoint-tech.com>
In-Reply-To: <200606111706.52930.linux@highpoint-tech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HighPoint Linux Team wrote:
> --- a/drivers/scsi/hptiop.c
> +++ b/drivers/scsi/hptiop.c
> @@ -504,18 +504,10 @@ static int hptiop_queuecommand(struct sc
>  	BUG_ON(!done);
>  	scp->scsi_done = done;
>  
> -	/*
> -	 * hptiop_shutdown will flash controller cache.
> -	 */
> -	if (scp->cmnd[0] == SYNCHRONIZE_CACHE)  {
> -		scp->result = DID_OK<<16;
> -		goto cmd_done;
> -	}
> -
>  	_req = get_req(hba);
>  	if (_req == NULL) {
>  		dprintk("hptiop_queuecmd : no free req\n");
> -		scp->result = DID_BUS_BUSY << 16;
> +		scp->result = SCSI_MLQUEUE_HOST_BUSY;
>  		goto cmd_done;
>  	}

Close.  For the last bit of code quoted above, you should return 
SCSI_MLQUEUE_HOST_BUSY as your ->queuecommand() return code, rather than 
setting scp->result and calling the done() hook.

	Jeff



