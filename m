Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264647AbUHCAQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbUHCAQA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbUHCAPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:15:04 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:2695 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S264530AbUHCAOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:14:16 -0400
Subject: Re: CPU hotplug broken in 2.6.8-rc2 ?
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, V Srivatsa <vatsa@in.ibm.com>,
       Joel Schopp <jschopp@austin.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <1091475519.29556.4.camel@pants.austin.ibm.com>
References: <20040802094907.GA3945@in.ibm.com>
	 <20040802095741.GA4599@in.ibm.com>
	 <1091475519.29556.4.camel@pants.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1091492027.424.96.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 03 Aug 2004 10:13:49 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-03 at 05:38, Nathan Lynch wrote:
> diff -puN kernel/sched.c~check-for-cpu-offline-in-load_balance kernel/sched.c
> --- 2.6.8-rc2-mm2/kernel/sched.c~check-for-cpu-offline-in-load_balance	2004-08-02 13:12:04.000000000 -0500
> +++ 2.6.8-rc2-mm2-nathanl/kernel/sched.c	2004-08-02 13:12:58.000000000 -0500
> @@ -1405,6 +1405,9 @@ static int load_balance(int this_cpu, ru
>  
>  	spin_lock(&this_rq->lock);
>  
> +	if (unlikely(cpu_is_offline(this_cpu)))
> +		goto out_balanced;
> +

cpu_is_offline() is "unlikely" already.  Please just use "if
(cpu_is_offline(this_cpu))"

Thanks,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

