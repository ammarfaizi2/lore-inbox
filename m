Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310806AbSDDThf>; Thu, 4 Apr 2002 14:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310637AbSDDThU>; Thu, 4 Apr 2002 14:37:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42757 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310917AbSDDTgt>;
	Thu, 4 Apr 2002 14:36:49 -0500
Message-ID: <3CACAB58.2090702@mandrakesoft.com>
Date: Thu, 04 Apr 2002 14:36:56 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stelian Pop <stelian.pop@fr.alcove.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        p_gortmaker@yahoo.com
Subject: Re: [PATCH 2.5.8-pre1] pcnet_cs compile fixes
In-Reply-To: <20020404135411.GF9820@come.alcove-fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> This patch makes pcnet_cs compile again (removal of dev->rmem_start
> and dev->rmem_end).
> 
> It compiles and works for me as intended, but maybe there is a cleaner
> fix by someone who understands better the netdevice internals...
> 
> 
> ===== drivers/net/pcmcia/pcnet_cs.c 1.7 vs edited =====
> --- 1.7/drivers/net/pcmcia/pcnet_cs.c	Tue Feb  5 08:55:16 2002
> +++ edited/drivers/net/pcmcia/pcnet_cs.c	Thu Apr  4 11:27:47 2002
> @@ -1460,7 +1460,8 @@
>  			       struct e8390_pkt_hdr *hdr,
>  			       int ring_page)
>  {
> -    void *xfer_start = (void *)(dev->rmem_start + (ring_page << 8)
> +    void *xfer_start = (void *)(dev->mem_start + (TX_PAGES<<8) 
> +		    		+ (ring_page << 8) 
>  				- (ei_status.rx_start_page << 8));


the earlier poster was more correct:  don't remove rmem_start, replacing 
it with ei_status.rmem_{start,end}

Anyway, this patch is long completed already, and sent to Linus already.

	Jeff




