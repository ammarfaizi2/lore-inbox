Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266348AbUFPU6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266348AbUFPU6e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 16:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUFPU4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 16:56:12 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:8622 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S264791AbUFPUyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 16:54:52 -0400
Subject: Re: IPMI hangup in 2.6.6-rc3
From: Alex Williamson <alex.williamson@hp.com>
To: Corey Minyard <minyard@acm.org>
Cc: Holger Kiehl <Holger.Kiehl@dwd.de>,
       Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <40D0B0D1.60804@acm.org>
References: <Pine.LNX.4.58.R0405040649310.15047@praktifix.dwd.de>
	 <20040525165335.GA28905@titan.lahn.de>  <40C0E2BF.3040705@acm.org>
	 <1086887543.4182.46.camel@tdi>
	 <Pine.LNX.4.58.0406161225210.17908@praktifix.dwd.de>
	 <40D056E2.4010605@acm.org> <40D05779.9080203@acm.org>
	 <Pine.LNX.4.58.0406161822280.13439@praktifix.dwd.de>
	 <Pine.LNX.4.58.0406161842180.13439@praktifix.dwd.de>
	 <40D0B0D1.60804@acm.org>
Content-Type: text/plain
Organization: LOSL
Message-Id: <1087419276.4274.97.camel@tdi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Jun 2004 14:54:36 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-16 at 14:42, Corey Minyard wrote:
> I cannot figure out from the traceback what is wrong, and I haven't been 
> able to reproduce this, even with ipmitool.
> 
> What kernel version are you running?  Can you verify that the attached 
> patch is in your code?
> 

   This fixed it for me.  I was running on stock 2.6.7, which does not
include the patch below.  My test program now works.  Thanks,

	Alex

> --- linux-2.6.7-rc3-full/drivers/char/ipmi/ipmi_devintf.c.orig	Wed Jun  9 12:08:23 2004
> +++ linux-2.6.7-rc3-full/drivers/char/ipmi/ipmi_devintf.c	Wed Jun  9 12:07:09 2004
> @@ -199,7 +199,7 @@ static int handle_send_req(ipmi_user_t  
>  			goto out;
>  		}
>  
> -		if (copy_from_user(&msgdata,
> +		if (copy_from_user(msgdata,
>  				   req->msg.data,
>  				   req->msg.data_len))
>  		{
> 
> 
> If that doesn't help, can you upgrade to 2.6.7-rc3-mm2 and re-try this 
> patch?
> 
> If that doesn't help, Can you turn on frame pointers and try again?  
> This will give a cleaner backtrace.
> 
> -Corey


