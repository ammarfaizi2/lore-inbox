Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262093AbSJDTtc>; Fri, 4 Oct 2002 15:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262103AbSJDTtc>; Fri, 4 Oct 2002 15:49:32 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:11679 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262093AbSJDTtb>; Fri, 4 Oct 2002 15:49:31 -0400
Date: Fri, 4 Oct 2002 15:54:46 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200210041954.g94Jsku26979@devserv.devel.redhat.com>
To: Carlos E Gorges <carlos@techlinux.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.40 - DMA-mapping && misc
In-Reply-To: <mailman.1033712580.28994.linux-kernel2news@redhat.com>
References: <mailman.1033712580.28994.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.5.40/drivers/scsi/53c7,8xx.c	Tue Oct  1 04:06:15 2002
> +++ linux-2.5/drivers/scsi/53c7,8xx.c	Fri Oct  4 02:53:48 2002
> @@ -62,8 +62,6 @@
>   *  the fourth byte from 50 to 25.
>   */
>  
> -#error Please convert me to Documentation/DMA-mapping.txt
> -
>  #include <linux/config.h>
>  
>  #ifdef CONFIG_SCSI_NCR53C7xx_sync
> @@ -3788,7 +3786,9 @@
>      for (i = 0; cmd->use_sg ? (i < cmd->use_sg) : !i; cmd_datain += 4, 
>  	cmd_dataout += 4, ++i) {
>  	u32 buf = cmd->use_sg ? 
> -	    virt_to_bus(((struct scatterlist *)cmd->buffer)[i].address) :
> +	    virt_to_bus(
> +		page_address(((struct scatterlist *)cmd->buffer)[i].page) +
> +		((struct scatterlist *)cmd->buffer)[i].offset ) :
>  	    virt_to_bus(cmd->request_buffer);
>  	u32 count = cmd->use_sg ?
>  	    ((struct scatterlist *)cmd->buffer)[i].length :

These parts contradict. Remove virt_to_bus, then you can take the
#error out, but not before.

-- Pete
