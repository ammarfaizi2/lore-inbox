Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWC3QAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWC3QAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWC3QAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:00:11 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:60123 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932151AbWC3QAK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:00:10 -0500
Subject: Re: [Patch 3/8] cpu delays
From: Dave Hansen <haveblue@us.ibm.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <442B2967.6010704@watson.ibm.com>
References: <442B271D.10208@watson.ibm.com>
	 <442B2967.6010704@watson.ibm.com>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 08:00:02 -0800
Message-Id: <1143734402.9731.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-29 at 19:42 -0500, Shailabh Nagar wrote:
> 
> -#ifdef CONFIG_SCHEDSTATS
> -       memset(&p->sched_info, 0, sizeof(p->sched_info));
> +#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
> +       if (unlikely(sched_info_on()))
> +               memset(&p->sched_info, 0, sizeof(p->sched_info));
>  #endif 

If you unconditionally define sched_info_on(), you can get get rid of
this #ifdef.

+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
+
+static inline int sched_info_on(void)
+{
+ #ifdef CONFIG_SCHEDSTATS
+       return 1;
+#elif defined(CONFIG_TASK_DELAY_ACCT)
+       return delayacct_on;
+#else
+	return 0;
+#endif
+}

Might as well hide the junk in a header.

-- Dave

