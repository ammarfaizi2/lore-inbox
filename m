Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVEQGZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVEQGZv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 02:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVEQGZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 02:25:50 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:25252 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261219AbVEQGZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 02:25:42 -0400
Message-ID: <42898E61.3060304@yahoo.com.au>
Date: Tue, 17 May 2005 16:25:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: dino@in.ibm.com
CC: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/3] Dynamic sched domains (v0.6)
References: <20050517041031.GA4596@in.ibm.com> <20050517041219.GB4596@in.ibm.com>
In-Reply-To: <20050517041219.GB4596@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar Guniguntala wrote:
> o Patch2 has updated cpusets documentation and the core update_cpu_domains
>   function
> o I have also moved the dentry d_lock as discussed previously
> 

Hi Dinakar,
patch1 looks good. Just one tiny little minor thing:

> +
> +	lock_cpu_hotplug();
> +	partition_sched_domains(&pspan, &cspan);
> +	unlock_cpu_hotplug();
> +}
> +

I don't think the cpu hotplug lock isn't supposed to provide
synchronisation between readers (for example, it may be turned
into an rwsem), but only between the thread and the cpu hotplug
callbacks.

In that case, can you move this locking into kernel/sched.c, and
add the comment in partition_sched_domains that the callers must
take care of synchronisation (which without reading the code, I
assume you're doing with the cpuset sem?).

If you agree with that change, you can add an
Acked-by: Nick Piggin <nickpiggin@yahoo.com.au>
to patch 1 and send it to Andrew whenever you're ready (better
CC Ingo as well). If not, please discuss! :)

Thanks,
Nick

