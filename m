Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbTAPBs1>; Wed, 15 Jan 2003 20:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbTAPBs0>; Wed, 15 Jan 2003 20:48:26 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46833 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266965AbTAPBsZ>; Wed, 15 Jan 2003 20:48:25 -0500
Date: Thu, 16 Jan 2003 02:57:18 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: tariq.shureih@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error compiling ieee1394/pcilynx.c (2.5.54)
Message-ID: <20030116015718.GF2333@fs.tum.de>
References: <34072.10.10.213.14.1042675870.squirrel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34072.10.10.213.14.1042675870.squirrel@linux.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 04:11:10PM -0800, Tariq Shureih wrote:
>...
> The pcilynx.c driver will not compile giving the following error.
> I enabled I2C bit-bangin options as required by the driver.
> 
> Seems that the driver requires porting to 2.5.x since the i2c structures
> and implementation has changed in 2.5.x.
> 
> Anyone working on this?  I can't proceed with my work not having this
> compile.

Below is the fix (already sent to Ben Collins).

> Thanx

cu
Adrian

--- linux-2.5.54/drivers/ieee1394/pcilynx.c.old	2003-01-03 06:58:52.000000000 +0100
+++ linux-2.5.54/drivers/ieee1394/pcilynx.c	2003-01-03 07:02:47.000000000 +0100
@@ -127,23 +127,20 @@
 }
 
 static struct i2c_algo_bit_data bit_data = {
-	NULL,
-	bit_setsda,
-	bit_setscl,
-	bit_getsda,
-	bit_getscl,
-	5, 5, 100,		/*	waits, timeout */
+	.setsda			= bit_setsda,
+	.setscl			= bit_setscl,
+	.getsda			= bit_getsda,
+	.getscl			= bit_getscl,
+	.udelay			= 5,
+	.mdelay			= 5,
+	.timeout		= 100,
 }; 
 
 static struct i2c_adapter bit_ops = {
-	"PCILynx I2C adapter",
-	0xAA, //FIXME: probably we should get an id in i2c-id.h
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	bit_reg,
-	bit_unreg,
+	.name			= "PCILynx I2C adapter",
+	.id 			= 0xAA, //FIXME: probably we should get an id in i2c-id.h
+	.client_register	= bit_reg,
+	.client_unregister	= bit_unreg,
 };
 
 
