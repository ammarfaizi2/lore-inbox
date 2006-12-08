Return-Path: <linux-kernel-owner+w=401wt.eu-S1947398AbWLHV7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947398AbWLHV7H (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 16:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947413AbWLHV7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 16:59:07 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:58874 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947398AbWLHV7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 16:59:05 -0500
Subject: Re: [PATCH] fs/jfs: fix error due to PF_* undeclared
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4579D941.9040607@student.ltu.se>
References: <Pine.LNX.4.64.0611291411300.3513@woody.osdl.org>
	 <4579B554.5010701@student.ltu.se>
	 <20061208112330.7e8d4e88.randy.dunlap@oracle.com>
	 <4579D941.9040607@student.ltu.se>
Content-Type: text/plain
Date: Fri, 08 Dec 2006 15:59:01 -0600
Message-Id: <1165615141.8575.7.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-08 at 22:29 +0100, Richard Knutsson wrote:
> Randy Dunlap wrote:
> > On Fri, 08 Dec 2006 19:56:20 +0100 Richard Knutsson wrote:

> >> Guess this is the desired fix, since including linux/sched.h in linux/freezer.h
> >> make little sense.
> >>     
> >
> > Why do you say that?  freezer.h is what uses those #defined values,
> > and freezer.h is what uses struct task_struct fields as well,
> > so it needs sched.h.
> >   
> Oh, an error of thought when I read the patch 
> 7dfb71030f7636a0d65200158113c37764552f93 made that statement. After more 
> checking, sched.h is apperarently included in suspend.h from swap.h so 
> the direct include of sched.h in most drivers was/is not nessecary.
> 
> Do you agree with the patch below then? This was how I first fixed it 
> but found it strange no-one hit it before, and from there it went on... 
> Thanks for the help. (Sign it?)

Randy had already submitted a similar patch to lkml.

http://marc.theaimsgroup.com/?l=linux-kernel&m=116561219801397&w=2

> ---
> 
> Compile-tested only.
> 
> 
> diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> index 6e05e3e..f616c0c 100644
> --- a/include/linux/freezer.h
> +++ b/include/linux/freezer.h
> @@ -1,3 +1,4 @@
> +#include <linux/sched.h>
>  /* Freezer declarations */
> 
>  #ifdef CONFIG_PM

Thanks anyway,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

