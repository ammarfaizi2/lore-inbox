Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVFUPGC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVFUPGC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVFUPGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:06:02 -0400
Received: from mail.dvmed.net ([216.237.124.58]:35495 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262066AbVFUPFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:05:49 -0400
Message-ID: <42B82CC8.3020702@pobox.com>
Date: Tue, 21 Jun 2005 11:05:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bobl <bobl@turbolinux.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: a trival bug of megaraid in patch 2.6.12-mm1
References: <42B7E5F2.2060409@turbolinux.com>
In-Reply-To: <42B7E5F2.2060409@turbolinux.com>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bobl wrote:
> Hi, Andrew Morton:
> 
>    In 2.6.12-mm1 patch, there are some lines as follow:
> 
> 300379 +static int
> 300380 +megaraid_reset(Scsi_Cmnd *cmd)
> 300381 +{
> 300382 +       adapter = (adapter_t *)cmd->device->host->hostdata;
> 300383 +       int rc;
> 300384 +
> 300385 +       spin_lock_irq(&adapter->lock);
> 300386 +       rc = __megaraid_reset(cmd);
> 300387 +       spin_unlock_irq(&adapter->lock);
> 300388 +
> 300389 +       return rc;
> 300390 +}
> 
>    I think between line 300381 and 300382 should add follow line:
> 
>       adapter_t       *adapter;
> 
>    The attachment is the patch, please confirm it.
> 
>    Best Regards
>  
>    Bob
> 
> 
> 
> ------------------------------------------------------------------------
> 
> diff -purN linux-2.6.12/drivers/scsi/megaraid.c linux-2.6.12.new/drivers/scsi/megaraid.c
> --- linux-2.6.12/drivers/scsi/megaraid.c	2005-06-21 18:49:50.118732304 +0900
> +++ linux-2.6.12.new/drivers/scsi/megaraid.c	2005-06-21 18:57:55.266978560 +0900
> @@ -1975,6 +1975,7 @@ __megaraid_reset(Scsi_Cmnd *cmd)
>  static int
>  megaraid_reset(Scsi_Cmnd *cmd)
>  {
> +	adapter_t	*adapter;
>  	adapter = (adapter_t *)cmd->device->host->hostdata;
>  	int rc;
>  

I think this is my screw-up.  I'll get the fix in...

	Jeff



