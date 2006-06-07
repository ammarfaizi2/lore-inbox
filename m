Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWFGSHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWFGSHb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 14:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWFGSHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 14:07:31 -0400
Received: from [213.91.247.3] ([213.91.247.3]:9734 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id S1751185AbWFGSHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 14:07:30 -0400
Date: Wed, 7 Jun 2006 21:06:42 +0300
From: Alexander Atanasov <alex@ssi.bg>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] I2C block read
Message-Id: <20060607210642.5cd59aba.alex@ssi.bg>
In-Reply-To: <20060607194943.db8f1889.khali@linux-fr.org>
References: <20060607203357.64432ad8.alex@ssi.bg>
	<20060607194943.db8f1889.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.1.5 (GTK+ 2.6.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 19:49:43 +0200
Jean Delvare wrote:

> Hi Alexander,
> 
> > 	When doing i2c block read the lenght is passed as the first
> > byte of the buffer, so we must copy it from user otherwise temp is
> > uninitialized.
> 
> > --- drivers/i2c/i2c-dev.c.orig	2006-01-04 02:00:00.000000000
> > +0200 +++ drivers/i2c/i2c-dev.c	2006-06-07
> > 19:46:08.000000000 +0300 @@ -337,6 +337,7 @@
> >  
> >  		if ((data_arg.size == I2C_SMBUS_PROC_CALL) || 
> >  		    (data_arg.size == I2C_SMBUS_BLOCK_PROC_CALL)
> > || 
> > +		    (data_arg.size == I2C_SMBUS_BLOCK_DATA) ||
> >  		    (data_arg.read_write == I2C_SMBUS_WRITE)) {
> >  			if (copy_from_user(&temp, data_arg.data,
> > datasize)) return -EFAULT;
> 
> Nack. Firstly, your comment says I2C block read, but your code changes
> SMBus block read. These are two different transactions. Secondly, for
> SMBus block read, the master doesn't ask for a given number of bytes.
> Instead, the chip decides and returns the number of (following) bytes
> as the first byte of the read part of the transaction. Check the SMBus
> specification.
> 
> So your patch is not correct, sorry.


	10x. Here is the case:
I use SMBus block read with scx200_acb as a bus it uses the lenght
which is as i say uninitialized and tries to read a number of random bytes
from the board i use. And it doesn't return the lenght as a first byte,
so the drivers reads until it gets an oops. Which in turn makes me wonder
why with this patch i correcly receive the number of bytes i pass,
looking at the driver i can not see that it gets the lenght from the read data.
I don't know well SMBus/I2C specs but read with buffer and no lenght 
doesn't look sane to me. So how should this be fixed?

--
have fun,
alex

 

	
