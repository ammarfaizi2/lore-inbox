Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWFGTx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWFGTx3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 15:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWFGTx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 15:53:29 -0400
Received: from amdext3.amd.com ([139.95.251.6]:17569 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1750818AbWFGTx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 15:53:28 -0400
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Date: Wed, 7 Jun 2006 13:53:21 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Jean Delvare" <khali@linux-fr.org>
cc: "Alexander Atanasov" <alex@ssi.bg>, linux-kernel@vger.kernel.org
Subject: Re: I2C block read
Message-ID: <20060607195321.GK5250@cosmic.amd.com>
References: <20060607203357.64432ad8.alex@ssi.bg>
 <20060607194943.db8f1889.khali@linux-fr.org>
 <20060607210642.5cd59aba.alex@ssi.bg>
 <20060607205025.b2529800.khali@linux-fr.org>
MIME-Version: 1.0
In-Reply-To: <20060607205025.b2529800.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 07 Jun 2006 19:52:49.0705 (UTC)
 FILETIME=[F4A25190:01C68A6B]
X-WSS-ID: 6899F1182L86843625-02-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/06 20:50 +0200, Jean Delvare wrote:
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/i2c/busses/scx200_acb.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.17-rc6.orig/drivers/i2c/busses/scx200_acb.c	2006-06-07 18:13:53.000000000 +0200
> +++ linux-2.6.17-rc6/drivers/i2c/busses/scx200_acb.c	2006-06-07 20:29:27.000000000 +0200
> @@ -308,6 +308,12 @@
>  		break;
>  
>  	case I2C_SMBUS_BLOCK_DATA:
> +		/* Sanity check */
> +		if (rw == I2C_SMBUS_READ) {
> +			dev_warn(&adapter->dev, "SMBus block read is not "
> +				 "supported!\n");
> +			return -EINVAL;
> +		}
>  		len = data->block[0];
>  		buffer = &data->block[1];
>  		break;
> @@ -372,7 +378,7 @@
>  {
>  	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
>  	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
> -	       I2C_FUNC_SMBUS_BLOCK_DATA;
> +	       I2C_FUNC_SMBUS_WRITE_BLOCK_DATA;
>  }
>  
>  /* For now, we only handle combined mode (smbus) */
> 

ACKed (if my opinion matters).  It will take some more thinking to handle
block reads, and they're really not very interesting anyway.  At the very
least, this will keep implementations from freaking out, and thats a 
Good Thing (TM).

Jordan

--
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>

