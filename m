Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbTFEPVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 11:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264718AbTFEPVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 11:21:53 -0400
Received: from morgon.mae.cornell.edu ([128.253.249.166]:33675 "EHLO
	morgon.mae.cornell.edu") by vger.kernel.org with ESMTP
	id S264677AbTFEPVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 11:21:52 -0400
Date: Thu, 5 Jun 2003 10:50:16 -0400
From: Andrey Klochko <andrey@morgon.mae.cornell.edu>
To: NeilBrown <neilb@cse.unsw.edu.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  Add module_kernel_thread for threads that live in modules.
Message-ID: <20030605105016.A9587@morgon.mae.cornell.edu>
References: <E19NkWO-0005i0-00@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E19NkWO-0005i0-00@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Thu, Jun 05, 2003 at 12:30:32PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil,

On Thu, Jun 05, 2003 at 12:30:32PM +1000, NeilBrown wrote:

>  	struct svc_serv	*serv = rqstp->rq_server;
> @@ -88,7 +88,6 @@ lockd(struct svc_rqst *rqstp)
>  	unsigned long grace_period_expire;
>  
>  	/* Lock module and set up kernel thread */
> -	MOD_INC_USE_COUNT;
>  	lock_kernel();
>  
>  	/*
> @@ -181,9 +180,7 @@ lockd(struct svc_rqst *rqstp)
>  	/* release rpciod */
>  	rpciod_down();
>  
> -	/* Release module */
> -	unlock_kernel();

You've locked the kernel and didn't unlock it.
 
> -	MOD_DEC_USE_COUNT;
> +	return 0;
> 
  
Andrey

-- 
-------------------------------------------------------------
Andrey Klochko
System Administrator
Sibley School of Mechanical and Aerospace Engineering
288 Grumman Hall
Cornell University
Ithaca, NY 14853

e-mail: andrey@mae.cornell.edu
phone: 607-255-0360
