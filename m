Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264556AbTLCMto (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 07:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264558AbTLCMto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 07:49:44 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:41416 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264556AbTLCMtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 07:49:39 -0500
Date: Wed, 3 Dec 2003 18:23:20 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Raj <raju@mailandnews.com>
Cc: linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net,
       manfred@colorfullife.com
Subject: Re: kernel BUG at kernel/exit.c:792!
Message-ID: <20031203182319.D14999@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20031203153858.C14999@in.ibm.com> <3FCDCEA3.1020209@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FCDCEA3.1020209@mailandnews.com>; from raju@mailandnews.com on Wed, Dec 03, 2003 at 05:23:07PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Dec 03, 2003 at 05:23:07PM +0530, Raj wrote:
> 
> >Does it make sense to check for leader_task being alive
> >after the tasklist lock is grabbed and return immediately
> >if it is not alive (as the patch below does)?
> >
> >  
> >
> maybe i am wrong, but wouldnt a 'break' in the do-while suffice rather 
> than a goto ?
> 

I was not sure if the pid_alive check inside the do-while loop
is for leader_task only or for non-leader tasks also. 
If that check is for non-leader tasks also, then we would
like to retain it still ..

> /Raj

> --- base.c	2003-10-26 00:13:57.000000000 +0530
> +++ base.c.fix	2003-12-03 17:20:18.877679360 +0530
> @@ -1669,7 +1669,7 @@
>  	do {
>  		int tid = task->pid;
>  		if (!pid_alive(task))
> -			continue;
> +			break;
>  		if (--index >= 0)
>  			continue;
>  		tids[nr_tids] = tid;


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560033
