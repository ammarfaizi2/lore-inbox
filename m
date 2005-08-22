Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVHVTxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVHVTxi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 15:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVHVTxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 15:53:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:59555 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750752AbVHVTxh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 15:53:37 -0400
Message-ID: <430A2D33.2000308@austin.ibm.com>
Date: Mon, 22 Aug 2005 14:53:23 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: boutcher@cs.umn.edu, Andrew Morton <akpm@osdl.org>
CC: linux-scsi@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] ibmvscsi timeout fix
References: <20050822193826.GA2455@cs.umn.edu>
In-Reply-To: <20050822193826.GA2455@cs.umn.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch fixes a long term borkenness in
> ibmvscsi where we were using the wrong timeout
> field from the scsi command (and using the 
> wrong units.)  Now broken by the fact that the
> scsi_cmnd timeout field is gone entirely.
> This only worked before because all the SCSI
> targets assumed that 0 was default.

That was fast.  I report the error to you and get a patch next time I 
look at my mail.  This does fix the build break I saw in a 
2.6.13-rc6-mm1 defconfig on ppc64.

Adding Andrew Morton to the distribution list since somebody else is 
bound to notice that ppc64 -mm doesn't compile anymore.

Acked-by: Joel Schopp <jschopp@austin.ibm.com>

> 
> Signed-off-by: Dave Boutcher <boutcher@us.ibm.com>
> 
> --- linux-2.6.13-rc6-mm1-orig/drivers/scsi/ibmvscsi/ibmvscsi.c	2005-08-22 13:54:20.111955197 -0500
> +++ linux-2.6.13-rc6-mm1/drivers/scsi/ibmvscsi/ibmvscsi.c	2005-08-22 14:22:56.265042174 -0500
> @@ -594,7 +594,7 @@
>  	init_event_struct(evt_struct,
>  			  handle_cmd_rsp,
>  			  VIOSRP_SRP_FORMAT,
> -			  cmnd->timeout);
> +			  cmnd->timeout_per_command/HZ);
>  
>  	evt_struct->cmnd = cmnd;
>  	evt_struct->cmnd_done = done;
> 
> 

