Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264563AbUDTWqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbUDTWqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264562AbUDTWqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:46:53 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:9928 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S264518AbUDTWVq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 18:21:46 -0400
Subject: Re: kernel/softirq.c issues under 2.6.5
From: Rusty Russell <rusty@rustcorp.com.au>
To: aivils@unibanka.lv
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200404201058.12830.aivils@unibanka.lv>
References: <200404201058.12830.aivils@unibanka.lv>
Content-Type: text/plain
Message-Id: <1082499674.16618.3.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 21 Apr 2004 08:21:18 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-20 at 17:58, Aivils wrote:
> Hi all!
> 
> 	My 2.6.5 will not start until i applay patch bellow:
> --- linux-2.6.5/kernel/softirq.c        2004-04-04 06:36:47.000000000 +0300
> +++ linux-2.6.5/kernel/softirq.chg.c    2004-04-20 10:48:28.000000000 +0300
> @@ -409,8 +409,8 @@ static int __devinit cpu_callback(struct
> 
>         switch (action) {
>         case CPU_UP_PREPARE:
> -               BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
> -               BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
> +               per_cpu(tasklet_vec, cpu).list = NULL;
> +               per_cpu(tasklet_hi_vec, cpu).list = NULL;
>                 p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
>                 if (IS_ERR(p)) {
>                         printk("ksoftirqd for %i failed\n", hotcpu);

This patch should be completely unnecessary.

One possibility is that your compiler isn't obeying the section
attribute for some reason.  Please send .config and output of "gcc -v".

Thanks!
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

