Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262521AbTCMSqk>; Thu, 13 Mar 2003 13:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262523AbTCMSqk>; Thu, 13 Mar 2003 13:46:40 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:37028 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262521AbTCMSqj>;
	Thu, 13 Mar 2003 13:46:39 -0500
Date: Thu, 13 Mar 2003 21:56:28 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       deanna_bonds@adaptec.com
Subject: Re: dpt_i2o.c fix for possibly memory corruption on reset timeout
Message-ID: <20030313185628.GA2485@linuxhacker.ru>
References: <20030313182819.GA2213@linuxhacker.ru> <1047584663.25948.75.camel@irongate.swansea.linux.org.uk> <20030313184107.GA2334@linuxhacker.ru> <20030313105125.1548d67c.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030313105125.1548d67c.rddunlap@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Mar 13, 2003 at 10:51:25AM -0800, Randy.Dunlap wrote:
> | Ok, so please consider applying this patch instead (appies to both
> | 2.4 and 2.5)

Ok, here's the one with spelling fix from Randy ;)

Bye,
    Oleg

===== drivers/scsi/dpt_i2o.c 1.9 vs edited =====
--- 1.9/drivers/scsi/dpt_i2o.c	Wed Jan  8 18:26:13 2003
+++ edited/drivers/scsi/dpt_i2o.c	Thu Mar 13 21:55:08 2003
@@ -1318,7 +1318,9 @@
 	while(*status == 0){
 		if(time_after(jiffies,timeout)){
 			printk(KERN_WARNING"%s: IOP Reset Timeout\n",pHba->name);
-			kfree(status);
+			/* We lose 4 bytes of "status" here, but we cannot
+			   free these because controller may awake and corrupt
+			   those bytes at any time */
 			return -ETIMEDOUT;
 		}
 		rmb();
@@ -1336,6 +1338,9 @@
 			}
 			if(time_after(jiffies,timeout)){
 				printk(KERN_ERR "%s:Timeout waiting for IOP Reset.\n",pHba->name);
+			/* We lose 4 bytes of "status" here, but we cannot
+			   free these because controller may awake and corrupt
+			   those bytes at any time */
 				return -ETIMEDOUT;
 			}
 		} while (m == EMPTY_QUEUE);
