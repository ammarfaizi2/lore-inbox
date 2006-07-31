Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWGaUmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWGaUmG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWGaUmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:42:06 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:59303 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030291AbWGaUmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:42:04 -0400
Message-ID: <44CE6AE7.8020304@watson.ibm.com>
Date: Mon, 31 Jul 2006 16:41:11 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Balbir Singh <balbir@in.ibm.com>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>
Subject: Re: [patch 3/3] convert CONFIG tag for a few accounting data used
 by CSA
References: <44CE58AF.7030200@sgi.com>
In-Reply-To: <44CE58AF.7030200@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:
> There were a few accounting data/macros that are used in CSA
> but are #ifdef'ed inside CONFIG_BSD_PROCESS_ACCT. This patch is
> to change those ifdef's from CONFIG_BSD_PROCESS_ACCT to
> CONFIG_CSA_ACCT. A few defines are moved from kernel/acct.c and
> include/linux/acct.h to kernel/csa.c and include/linux/csa_kern.h.
> 
> 
> Signed-off-by:  Jay Lan <jlan@sgi.com>
> 
> 
> ------------------------------------------------------------------------
> 
> Index: linux/include/linux/acct.h
> ===================================================================
> --- linux.orig/include/linux/acct.h	2006-07-20 11:38:51.956204769 -0700
> +++ linux/include/linux/acct.h	2006-07-20 11:45:32.469053105 -0700
> @@ -124,16 +124,12 @@ extern void acct_auto_close(struct super
>  extern void acct_init_pacct(struct pacct_struct *pacct);
>  extern void acct_collect(long exitcode, int group_dead);
>  extern void acct_process(void);
> -extern void acct_update_integrals(struct task_struct *tsk);
> -extern void acct_clear_integrals(struct task_struct *tsk);
>  #else
>  #define acct_auto_close_mnt(x)	do { } while (0)
>  #define acct_auto_close(x)	do { } while (0)
>  #define acct_init_pacct(x)	do { } while (0)
>  #define acct_collect(x,y)	do { } while (0)
>  #define acct_process()		do { } while (0)
> -#define acct_update_integrals(x)		do { } while (0)
> -#define acct_clear_integrals(task)	do { } while (0)
>  #endif
>  
>  /*
> Index: linux/include/linux/csa_kern.h
> ===================================================================
> --- linux.orig/include/linux/csa_kern.h	2006-07-20 11:44:05.079993220 -0700
> +++ linux/include/linux/csa_kern.h	2006-07-20 11:47:16.266315471 -0700
> @@ -28,4 +28,12 @@ extern void csa_add_tsk(struct taskstats
>   */
>  #define REV_CSA		07000	/* Kernel: CSA base record */
>  
> +#ifdef CONFIG_CSA_ACCT
> +extern void acct_update_integrals(struct task_struct *tsk);
> +extern void acct_clear_integrals(struct task_struct *tsk);
> +#else
> +#define acct_update_integrals(x)	do { } while (0)
> +#define acct_clear_integrals(task)	do { } while (0)
> +#endif
> +

static inlines preferred

>  #endif	/* _CSA_KERN_H */
> Index: linux/kernel/acct.c
> ===================================================================
> --- linux.orig/kernel/acct.c	2006-07-20 11:38:51.956204769 -0700
> +++ linux/kernel/acct.c	2006-07-20 11:45:32.477053203 -0700
> @@ -598,33 +598,3 @@ void acct_process(void)
>  	do_acct_process(file);
>  	fput(file);

<snip>

