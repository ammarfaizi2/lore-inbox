Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262868AbTDAVDY>; Tue, 1 Apr 2003 16:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262872AbTDAVDY>; Tue, 1 Apr 2003 16:03:24 -0500
Received: from air-2.osdl.org ([65.172.181.6]:12758 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262868AbTDAVDW>;
	Tue, 1 Apr 2003 16:03:22 -0500
Date: Tue, 1 Apr 2003 13:15:04 +0000
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] PATCH: dpt_i2o memory leak comments
Message-Id: <20030401131504.5d25020b.rddunlap@osdl.org>
In-Reply-To: <200304012105.h31L5vG11354@hera.kernel.org>
References: <200304012105.h31L5vG11354@hera.kernel.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| @@ -1318,7 +1318,9 @@
|  	while(*status == 0){
|  		if(time_after(jiffies,timeout)){
|  			printk(KERN_WARNING"%s: IOP Reset Timeout\n",pHba->name);
| -			kfree(status);
| +			/* We loose 4 bytes of "status" here, but we cannot
| +			   free these because controller may awake and corrupt
| +			   those bytes at any time */
s/loose/lose/

| @@ -1336,6 +1338,9 @@
|  			}
|  			if(time_after(jiffies,timeout)){
|  				printk(KERN_ERR "%s:Timeout waiting for IOP Reset.\n",pHba->name);
| +			/* We loose 4 bytes of "status" here, but we cannot
| +			   free these because controller may awake and corrupt
| +			   those bytes at any time */
s/loose/lose/

or is this a Brit vs. Amer difference?  (not that I know of)

--
~Randy
