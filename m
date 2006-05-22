Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWEVPqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWEVPqI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWEVPqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:46:08 -0400
Received: from xenotime.net ([66.160.160.81]:23256 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750716AbWEVPqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:46:07 -0400
Date: Mon, 22 May 2006 08:48:40 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add user taint flag
Message-Id: <20060522084840.42437af2.rdunlap@xenotime.net>
In-Reply-To: <E1FhwyO-0001YQ-O1@candygram.thunk.org>
References: <E1FhwyO-0001YQ-O1@candygram.thunk.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 May 2006 19:04:32 -0400 Theodore Ts'o wrote:

> 
> Allow taint flags to be set from userspace by writing to
> /proc/sys/kernel/tainted, and add a new taint flag, TAINT_USER, to be
> used when userspace is potentially doing something naughty that might
> compromise the kernel.  This will allow support personnel to ask further
> questions about what may have caused the user taint flag to have been
> set.  (For example, by examining the logs of the JVM to determine what
> evil things might have been lurking in the hearts of Java programs.  :-)
> 
> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
> 
> 
> Index: linux-2.6/kernel/sysctl.c
> ===================================================================
> --- linux-2.6.orig/kernel/sysctl.c	2006-03-25 21:26:38.000000000 -0500
> +++ linux-2.6/kernel/sysctl.c	2006-05-21 19:00:15.000000000 -0400
> @@ -1835,6 +1835,23 @@
>  				do_proc_dointvec_bset_conv,&op);
>  }
>  
> +/*
> + *	Taint values can only be increased
> + */
> +int proc_dointvec_taint(ctl_table *table, int write, struct file *filp,
> +			void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int op;
> +
> +	if (!capable(CAP_SYS_ADMIN)) {
> +		return -EPERM;
> +	}

no braces.

> +
> +	op = OP_OR;
> +	return do_proc_dointvec(table,write,filp,buffer,lenp,ppos,
> +				do_proc_dointvec_bset_conv,&op);

find/use that spacebar (after commas).

> +}
> +
>  struct do_proc_dointvec_minmax_conv_param {
>  	int *min;
>  	int *max;


---
~Randy
