Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262958AbTDBKAk>; Wed, 2 Apr 2003 05:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262959AbTDBKAk>; Wed, 2 Apr 2003 05:00:40 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:59878 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S262958AbTDBKAj>; Wed, 2 Apr 2003 05:00:39 -0500
Date: Wed, 2 Apr 2003 12:11:57 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] PATCH: dpt_i2o memory leak comments
Message-ID: <20030402101157.GB2661@wohnheim.fh-wedel.de>
References: <200304012105.h31L5vG11354@hera.kernel.org> <20030401131504.5d25020b.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030401131504.5d25020b.rddunlap@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 April 2003 13:15:04 +0000, Randy.Dunlap wrote:
> 
> | @@ -1318,7 +1318,9 @@
> |  	while(*status == 0){
> |  		if(time_after(jiffies,timeout)){
> |  			printk(KERN_WARNING"%s: IOP Reset Timeout\n",pHba->name);
> | -			kfree(status);
> | +			/* We loose 4 bytes of "status" here, but we cannot
> | +			   free these because controller may awake and corrupt
> | +			   those bytes at any time */
> s/loose/lose/
> 
> | @@ -1336,6 +1338,9 @@
> |  			}
> |  			if(time_after(jiffies,timeout)){
> |  				printk(KERN_ERR "%s:Timeout waiting for IOP Reset.\n",pHba->name);
> | +			/* We loose 4 bytes of "status" here, but we cannot
> | +			   free these because controller may awake and corrupt
> | +			   those bytes at any time */
> s/loose/lose/

It might also be nice to point out, that we lose the 4 bytes once per
*boot*, not continuously. Some people like me have a much easier time
to accept the loss then. :)

Jörn

-- 
It's just what we asked for, but not what we want!
-- anonymous
