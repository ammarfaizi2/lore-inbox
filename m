Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbVIMRs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVIMRs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbVIMRs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:48:56 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:38844 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S964938AbVIMRsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:48:55 -0400
Message-ID: <432710FB.1000802@cs.wisc.edu>
Date: Tue, 13 Sep 2005 12:48:43 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Thelin <Timothy.Thelin@wdc.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.13] scsi: sd fails to copy cmd_len on SG_IO
References: <CA45571DE57E1C45BF3552118BA92C9D69BDD8@WDSCEXBECL03.sc.wdc.com>
In-Reply-To: <CA45571DE57E1C45BF3552118BA92C9D69BDD8@WDSCEXBECL03.sc.wdc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Thelin wrote:
> This fixes an issue when doing SG_IO on an sd device: the
> sd driver fails to copy the request's cmd_len to the scsi
> command's cmd_len when initializing the command.
> 

Do you need the same fix to st, sr, and scsi_lib (in the 
scsi_generic_done path)?

> Signed-off-by: Timothy Thelin <timothy.thelin@wdc.com>
> 
> --- linux-2.6.13.orig/drivers/scsi/sd.c	2005-08-28 16:41:01.000000000 -0700
> +++ linux-2.6.13/drivers/scsi/sd.c	2005-09-13 09:39:06.000000000 -0700
> @@ -236,6 +236,7 @@ static int sd_init_command(struct scsi_c
>  			return 0;
>  
>  		memcpy(SCpnt->cmnd, rq->cmd, sizeof(SCpnt->cmnd));
> +		SCpnt->cmd_len = rq->cmd_len;
>  		if (rq_data_dir(rq) == WRITE)
>  			SCpnt->sc_data_direction = DMA_TO_DEVICE;
>  		else if (rq->data_len)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

