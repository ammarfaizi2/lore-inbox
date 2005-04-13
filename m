Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262959AbVDMAWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbVDMAWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVDMAVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 20:21:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:19362 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262123AbVDMASG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 20:18:06 -0400
Date: Tue, 12 Apr 2005 17:18:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hangcheck-timer: Update to 0.9.0.
Message-Id: <20050412171801.444df4bc.akpm@osdl.org>
In-Reply-To: <20050412235033.GI31163@ca-server1.us.oracle.com>
References: <20050412235033.GI31163@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> +#if defined(__i386__) || defined(__x86_64__)
> +# define HAVE_MONOTONIC
> +# define TIMER_FREQ 1000000000ULL
> +#elif defined(__s390__)
> +/* FA240000 is 1 Second in the IBM time universe (Page 4-38 Principles of Op for zSeries */
> +# define TIMER_FREQ 0xFA240000ULL
> +#elif defined(__ia64__)
> +# define TIMER_FREQ ((unsigned long long)local_cpu_data->itc_freq)
> +#elif defined(__powerpc64__)
> +# define TIMER_FREQ (HZ*loops_per_jiffy)
> +#endif  /* __s390__ */

It's not very important, but it would be a bit more conventional to use
CONFIG_X86, CONFIG_ARCH_S390, CONFIG_IA64 and CONFIG_PPC64 for those cases
where such an ifdef is to be used.

In the above case specifically, no ifdefs should be needed - you can simply
define CONFIG_HANGCHECK_TIMER_FREQ in arch/*/Kconfig.

