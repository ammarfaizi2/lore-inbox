Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUIVQXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUIVQXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 12:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUIVQXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 12:23:24 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:36775 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266204AbUIVQXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 12:23:13 -0400
Date: Wed, 22 Sep 2004 09:22:18 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: kj <kernel-janitors@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-kjt1 rio_linux compile error
Message-ID: <20040922162218.GB1924@us.ibm.com>
References: <20040921221307.GG4260@stro.at> <20040922112157.GB27364@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922112157.GB27364@fs.tum.de>
X-Operating-System: Linux 2.6.8.1 (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 01:21:58PM +0200, Adrian Bunk wrote:
> On Wed, Sep 22, 2004 at 12:13:07AM +0200, maximilian attems wrote:
> >...
> > added since 2.6.9-rc1-kjt1
> >...
> > msleep-drivers_char_rio_linux.patch
> >   From: Nishanth Aravamudan <nacc@us.ibm.com>
> >   Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 20/33] char/rio_linux: replace 	schedule_timeout() with msleep()/msleep_interruptible()
> >...
> 
> This doesn't compile (obvious typo):

Thanks for catching this! Here is the fixed patch:


--- 2.6.9-rc2-vanilla/drivers/char/rio/rio_linux.c	2004-09-13 17:15:47.000000000 -0700
+++ 2.6.9-rc2/drivers/char/rio/rio_linux.c	2004-09-22 09:20:56.000000000 -0700
@@ -330,8 +330,7 @@ int RIODelay (struct Port *PortP, int nj
   func_enter ();
 
   rio_dprintk (RIO_DEBUG_DELAY, "delaying %d jiffies\n", njiffies);  
-  current->state = TASK_INTERRUPTIBLE;
-  schedule_timeout(njiffies);
+  msleep_interruptible(jiffies_to_msecs(njiffies));
   func_exit();
 
   if (signal_pending(current))
@@ -347,8 +346,7 @@ int RIODelay_ni (struct Port *PortP, int
   func_enter ();
 
   rio_dprintk (RIO_DEBUG_DELAY, "delaying %d jiffies (ni)\n", njiffies);  
-  current->state = TASK_UNINTERRUPTIBLE;
-  schedule_timeout(njiffies);
+  msleep(jiffies_to_msecs(njiffies));
   func_exit();
   return !RIO_FAIL;
 }
