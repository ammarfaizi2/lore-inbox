Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbVKRSRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbVKRSRL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 13:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbVKRSRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 13:17:11 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:56998 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161049AbVKRSRK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 13:17:10 -0500
Subject: Re: 2.6.15-rc1-mm1 panic in ptrace_check_attach()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051118180743.GA3708@infradead.org>
References: <1132336600.24066.179.camel@localhost.localdomain>
	 <20051118180743.GA3708@infradead.org>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 10:17:04 -0800
Message-Id: <1132337824.24066.181.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 18:07 +0000, Christoph Hellwig wrote:
> On Fri, Nov 18, 2005 at 09:56:40AM -0800, Badari Pulavarty wrote:
> > Hi Andrew,
> > 
> > I am not sure if its already reported. I get panic in
> > ptrace_check_attach() while trying to run UML on 2.6.15-rc1-mm1.
> > 
> > Going to try 2.6.15-rc1-mm2 now. 
> 
> Looks like 2.6.15-rc1-mm1 has total crap in ptrace_get_task_struct
> (and it looks like my fault because I sent out a wrong patch).
> 
> The patch below should fix it:
> 
> Index: linux-2.6/kernel/ptrace.c
> ===================================================================
> --- linux-2.6.orig/kernel/ptrace.c	2005-11-18 10:25:35.000000000 +0100
> +++ linux-2.6/kernel/ptrace.c	2005-11-18 10:25:54.000000000 +0100
> @@ -459,7 +459,7 @@
>  	read_unlock(&tasklist_lock);
>  	if (!child)
>  		return ERR_PTR(-ESRCH);
> -	return 0;
> +	return child;
>  }
>  
>  #ifndef __ARCH_SYS_PTRACE
> 

Fixed the problem. I guess we need this for 2.6.15-rc1-mm2 also.

Thanks,
Badari

