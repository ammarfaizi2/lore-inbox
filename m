Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267635AbUIAXVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267635AbUIAXVu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267971AbUIAXUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:20:17 -0400
Received: from baikonur.stro.at ([213.239.196.228]:64209 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267851AbUIAXP4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:15:56 -0400
Subject: [patch 03/14] 
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Thu, 02 Sep 2004 01:15:55 +0200
Message-ID: <E1C2eKZ-0002lZ-KX@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







On Tue, Jul 27, 2004 at 09:10:52AM -0700, Nishanth Aravamudan wrote:

<snip>

> Here is this patch:
> 
> 
> 
> Description: Uses msleep() instead of my_wait() to guarantee the time
> delay. Removes definition of my_wait().
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

Sorry, this previous patch will not compile due to a typo. Find the
correct version below, thanks.



---

 linux-2.6.9-rc1-bk7-max/drivers/media/common/saa7146_i2c.c |   21 ++++---------
 1 files changed, 7 insertions(+), 14 deletions(-)

diff -puN drivers/media/common/saa7146_i2c.c~msleep-drivers_media_common_saa7146_i2c drivers/media/common/saa7146_i2c.c
--- linux-2.6.9-rc1-bk7/drivers/media/common/saa7146_i2c.c~msleep-drivers_media_common_saa7146_i2c	2004-09-01 19:34:56.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/media/common/saa7146_i2c.c	2004-09-01 19:34:56.000000000 +0200
@@ -1,13 +1,6 @@
 #include <linux/version.h>
 #include <media/saa7146_vv.h>
 
-/* helper function */
-static void my_wait(struct saa7146_dev *dev, long ms)
-{
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout((((ms+10)/10)*HZ)/1000);
-}
-
 u32 saa7146_i2c_func(struct i2c_adapter *adapter)
 {
 //fm	DEB_I2C(("'%s'.\n", adapter->name));
@@ -136,12 +129,12 @@ static int saa7146_i2c_reset(struct saa7
 		/* set "ABORT-OPERATION"-bit (bit 7)*/
 		saa7146_write(dev, I2C_STATUS, (dev->i2c_bitrate | MASK_07));
 		saa7146_write(dev, MC2, (MASK_00 | MASK_16));
-		my_wait(dev,SAA7146_I2C_DELAY);
+		msleep(SAA7146_I2C_DELAY);
 
 		/* clear all error-bits pending; this is needed because p.123, note 1 */
 		saa7146_write(dev, I2C_STATUS, dev->i2c_bitrate);
 		saa7146_write(dev, MC2, (MASK_00 | MASK_16));
-		my_wait(dev,SAA7146_I2C_DELAY);
+		msleep(SAA7146_I2C_DELAY);
  	}
 
 	/* check if any error is (still) present. (this can be necessary because p.123, note 1) */
@@ -155,18 +148,18 @@ static int saa7146_i2c_reset(struct saa7
 		   after serious protocol errors caused by e.g. the SAA7740 */
 		saa7146_write(dev, I2C_STATUS, (dev->i2c_bitrate | MASK_07));
 		saa7146_write(dev, MC2, (MASK_00 | MASK_16));
-		my_wait(dev,SAA7146_I2C_DELAY);
+		msleep(SAA7146_I2C_DELAY);
 
 		/* clear all error-bits pending */
 		saa7146_write(dev, I2C_STATUS, dev->i2c_bitrate);
 		saa7146_write(dev, MC2, (MASK_00 | MASK_16));
-		my_wait(dev,SAA7146_I2C_DELAY);
+		msleep(SAA7146_I2C_DELAY);
 
 		/* the data sheet says it might be necessary to clear the status
 		   twice after an abort */
 		saa7146_write(dev, I2C_STATUS, dev->i2c_bitrate);
 		saa7146_write(dev, MC2, (MASK_00 | MASK_16));
-		my_wait(dev,SAA7146_I2C_DELAY);
+		msleep(SAA7146_I2C_DELAY);
      	}
 
 	/* if any error is still present, a fatal error has occured ... */
@@ -243,7 +236,7 @@ static int saa7146_i2c_writeout(struct s
 			if ((++trial < 20) && short_delay)
 				udelay(10);
 			else
-			my_wait(dev,1);
+			msleep(1);
 		}
 	}
 
@@ -345,7 +338,7 @@ int saa7146_i2c_transfer(struct saa7146_
 		}
 	        
 	        /* delay a bit before retrying */
-	        my_wait(dev, 10);
+	        msleep(10);
 		
 	} while (err != num && retries--);
 

_
