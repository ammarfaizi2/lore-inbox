Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754306AbWKMJ0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306AbWKMJ0D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754313AbWKMJ0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:26:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27299 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754301AbWKMJZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:25:59 -0500
Subject: Re: [patch 2/4] permission mapping for sys_syslog operations
From: Arjan van de Ven <arjan@infradead.org>
To: Zack Weinberg <zackw@panix.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       jmorris@namei.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061113064058.779558000@panix.com>
References: <20061113064043.264211000@panix.com>
	 <20061113064058.779558000@panix.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 13 Nov 2006 10:25:18 +0100
Message-Id: <1163409918.15249.111.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-12 at 22:40 -0800, Zack Weinberg wrote:
> plain text document attachment (map_perms.diff)
> As suggested by Stephen Smalley: map the various sys_syslog operations
> to a smaller set of privilege codes before calling security modules.
> This patch changes the security module interface!  There should be no
> change in the actual security semantics enforced by dummy, capability,
> nor SELinux (with one exception, clearly marked in sys_syslog).
> 
> zw
> 
> 
> Index: linux-2.6/include/linux/klog.h
> ===================================================================
> --- linux-2.6.orig/include/linux/klog.h	2006-11-10 13:48:52.000000000 -0800
> +++ linux-2.6/include/linux/klog.h	2006-11-10 14:08:57.000000000 -0800
> @@ -23,4 +23,16 @@
>  	KLOG_GET_SIZE        = 10  /* return size of log buffer */
>  };
>  
> +#ifdef __KERNEL__
> +
> +/*
> + * Constants passed by do_syslog to security_syslog to indicate which
> + * privilege is requested.
> + */
> +#define KLOGSEC_READ	  0  /* read current messages (klogd) */
> +#define KLOGSEC_READHIST  1  /* read message history (dmesg) */
> +#define KLOGSEC_CLEARHIST 2  /* clear message history (dmesg -c) */
> +#define KLOGSEC_CONSOLE   3  /* set console log level */
> +
> +#endif /* __KERNEL__ */

Hi,

you had such a nice userspace/kernel shared header.. and now you mix it
with kernel privates again... can you consider making this a second
header? Eg have a pure userspace clean header and a separate for-kernel
header (which #can include the user header for all I care)... that's
nicer for sure!

Greetings,
   Arjan van de Ven

