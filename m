Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbVHOVrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbVHOVrL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbVHOVrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:47:11 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:64174 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964989AbVHOVrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:47:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Ha17iS1db24ohH+45U7k5F3lDtoQu80NUEUM+j+pCkQp9OTQ98Jn/pfNxMtB8zIlrZ4Ib1tLusEpf0f6jreJTMvaShovINEoF82qGZ80L4ycOM85k5YV3Lo2Y8q8KLus1vt7nRfiZaU/5V3GtmVLmoqGiGnubPxYS2J5Rni1S5w=
Date: Tue, 16 Aug 2005 01:55:49 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: mikem <mikem@beardog.cca.cpqcorp.net>
Cc: marcelo.tosatti@cyclades.com, axboe@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 4/4] cciss 2.4: fixes a warning from cciss_scsi.c during compile
Message-ID: <20050815215549.GA27758@mipter.zuzino.mipt.ru>
References: <20050815212425.GE12760@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815212425.GE12760@beardog.cca.cpqcorp.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 04:24:25PM -0500, mikem wrote:
> This patch fixes a warning during compile.

> --- lx2431-p003/drivers/block/cciss_scsi.c
> +++ lx2431/drivers/block/cciss_scsi.c
> @@ -220,8 +220,7 @@ scsi_cmd_stack_free(int ctlr)
>  		printk( "cciss: %d scsi commands are still outstanding.\n",
>  			CMD_STACK_SIZE - stk->top);
>  		// BUG();
> -		printk("WE HAVE A BUG HERE!!! stk=0x%08x\n",
> -			(unsigned int) stk);
> +		printk("WE HAVE A BUG HERE!!! stk=0x%p\n", stk);

If we have a BUG() here why it's commented out? If we don't, remove
printk() together with BUG().

