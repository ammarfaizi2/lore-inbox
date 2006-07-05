Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWGEJhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWGEJhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 05:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWGEJhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 05:37:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1948 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932414AbWGEJhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 05:37:03 -0400
Date: Wed, 5 Jul 2006 02:36:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [CPUFREQ] Fix implicit declarations in ondemand.
Message-Id: <20060705023641.21507b34.akpm@osdl.org>
In-Reply-To: <20060705092254.GA30744@redhat.com>
References: <20060705092254.GA30744@redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 05:22:54 -0400
Dave Jones <davej@redhat.com> wrote:

> drivers/cpufreq/cpufreq_ondemand.c: In function ‘dbs_check_cpu’:
> drivers/cpufreq/cpufreq_ondemand.c:238: error: implicit declaration of function ‘jiffies64_to_cputime64’
> drivers/cpufreq/cpufreq_ondemand.c:239: error: implicit declaration of function ‘cputime64_sub’
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6/drivers/cpufreq/cpufreq_ondemand.c~	2006-07-05 05:19:26.000000000 -0400
> +++ linux-2.6/drivers/cpufreq/cpufreq_ondemand.c	2006-07-05 05:20:01.000000000 -0400
> @@ -18,6 +18,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/kernel_stat.h>
>  #include <linux/mutex.h>
> +#include <asm/cputime.h>
>  

But kernel_stat.h already includes cputime.h, as does sched.h, and pretty
much everything pulls in sched.h.

It's not bad to avoid a dependency upon nested includes, but I do wonder
how this error came about??
