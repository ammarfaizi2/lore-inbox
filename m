Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWH0CAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWH0CAA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 22:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWH0CAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 22:00:00 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59913 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750890AbWH0B77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 21:59:59 -0400
Date: Sun, 27 Aug 2006 03:59:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, christer@weinigel.se,
       Greg Kroah-Hartman <gregkh@suse.de>, i2c@lm-sensors.org
Subject: [-mm patch] drivers/i2c/busses/scx200_i2c.c: update struct scx200_i2c_data
Message-ID: <20060827015957.GN4765@stusta.de>
References: <20060826160922.3324a707.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060826160922.3324a707.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 04:09:22PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc4-mm2:
>...
> +gregkh-i2c-i2c-algo-bit-kill-mdelay.patch
>...
>  I2C tree updates
>...

drivers/i2c/busses/scx200_i2c.c was forgotten:

<--  snip  -->

...
  CC      drivers/i2c/busses/scx200_i2c.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/drivers/i2c/busses/scx200_i2c.c:79: warning: excess elements in struct initializer
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm3/drivers/i2c/busses/scx200_i2c.c:79: warning: (near initialization for ‘scx200_i2c_data’)
...

<--  snip  -->

While fixing it, I also converted the struct to C99 initializers.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm3/drivers/i2c/busses/scx200_i2c.c.old	2006-08-27 03:57:50.000000000 +0200
+++ linux-2.6.18-rc4-mm3/drivers/i2c/busses/scx200_i2c.c	2006-08-27 03:51:50.000000000 +0200
@@ -71,12 +71,12 @@
  */
 
 static struct i2c_algo_bit_data scx200_i2c_data = {
-	NULL,
-	scx200_i2c_setsda,
-	scx200_i2c_setscl,
-	scx200_i2c_getsda,
-	scx200_i2c_getscl,
-	10, 10, 100,		/* waits, timeout */
+	.setsda		= scx200_i2c_setsda,
+	.setscl		= scx200_i2c_setscl,
+	.getsda		= scx200_i2c_getsda,
+	.getscl		= scx200_i2c_getscl,
+	.udelay		= 10,
+	.timeout	= 100,
 };
 
 static struct i2c_adapter scx200_i2c_ops = {

