Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVCWRJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVCWRJi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVCWRJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:09:38 -0500
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:31275 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261672AbVCWRJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:09:36 -0500
X-SBRSScore: None
X-IronPort-AV: i="3.91,115,1110150000"; 
   d="scan'208"; a="6656712:sNHT23129892"
Message-ID: <4241A2C0.2050206@fujitsu-siemens.com>
Date: Wed, 23 Mar 2005 18:09:20 +0100
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: blaisorblade@yahoo.it
CC: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [patch 02/12] uml: cpu_relax fix
References: <20050322162121.4295D2125C@zion>
In-Reply-To: <20050322162121.4295D2125C@zion>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade@yahoo.it wrote:
> Use rep_nop instead of barrier for cpu_relax, following $(SUBARCH)'s doing
> that (i.e. i386 and x86_64).

IIRC, Jeff had the idea, to use sched_yield() for this (from a discussion on #uml).
S390 does something similar using a special DIAG-opcode that gives permission to zVM,
that another Guest might run.

On a host running many UMLs, this might improve performance.

So, I would like to have the small patch below (it's not tested, just an idea).

		Bodo


> diff -puN include/asm-um/processor-generic.h~uml-cpu_relax include/asm-um/processor-generic.h
> --- linux-2.6.11/include/asm-um/processor-generic.h~uml-cpu_relax	2005-03-22 16:52:25.000000000 +0100
> +++ linux-2.6.11-paolo/include/asm-um/processor-generic.h	2005-03-22 16:54:41.000000000 +0100
> @@ -16,7 +16,8 @@ struct task_struct;
>  
>  struct mm_struct;
>  
> -#define cpu_relax()   barrier()
> +#include "kern.h"
> +#define cpu_relax()   sched_yield()
>  
>  struct thread_struct {
>  	int forking;
