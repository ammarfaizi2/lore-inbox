Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWFGRto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWFGRto (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWFGRto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:49:44 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:25872 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1750889AbWFGRtn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:49:43 -0400
Date: Wed, 7 Jun 2006 19:49:43 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Alexander Atanasov <alex@ssi.bg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] I2C block read
Message-Id: <20060607194943.db8f1889.khali@linux-fr.org>
In-Reply-To: <20060607203357.64432ad8.alex@ssi.bg>
References: <20060607203357.64432ad8.alex@ssi.bg>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

> 	When doing i2c block read the lenght is passed as the first byte of the buffer,
> so we must copy it from user otherwise temp is uninitialized.

> --- drivers/i2c/i2c-dev.c.orig	2006-01-04 02:00:00.000000000 +0200
> +++ drivers/i2c/i2c-dev.c	2006-06-07 19:46:08.000000000 +0300
> @@ -337,6 +337,7 @@
>  
>  		if ((data_arg.size == I2C_SMBUS_PROC_CALL) || 
>  		    (data_arg.size == I2C_SMBUS_BLOCK_PROC_CALL) || 
> +		    (data_arg.size == I2C_SMBUS_BLOCK_DATA) ||
>  		    (data_arg.read_write == I2C_SMBUS_WRITE)) {
>  			if (copy_from_user(&temp, data_arg.data, datasize))
>  				return -EFAULT;

Nack. Firstly, your comment says I2C block read, but your code changes
SMBus block read. These are two different transactions. Secondly, for
SMBus block read, the master doesn't ask for a given number of bytes.
Instead, the chip decides and returns the number of (following) bytes as
the first byte of the read part of the transaction. Check the SMBus
specification.

So your patch is not correct, sorry.

-- 
Jean Delvare
