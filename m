Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbVJ3Ux0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbVJ3Ux0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 15:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVJ3Ux0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 15:53:26 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:4483 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750967AbVJ3UxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 15:53:25 -0500
Date: Sun, 30 Oct 2005 12:53:45 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, dwmw2@infradead.org, linux-audit@redhat.com,
       faith@redhat.com, george@mvista.com, netdev@vger.kernel.org
Subject: Re: [2.6 patch] kernel/: small cleanups
Message-ID: <20051030205345.GA32111@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051030010200.GT4180@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030010200.GT4180@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 02:02:00AM +0100, Adrian Bunk wrote:
> This patch contains the following cleanups:
> - make needlessly global functions static

Good catch on rcu_torture_alloc()!

							Thanx, Paul

> - every file should include the headers containing the prototypes for
>   it's global functions

Acked-by: <paulmck@us.ibm.com>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  kernel/audit.c      |    2 +-
>  kernel/irq/proc.c   |    2 ++
>  kernel/rcutorture.c |    2 +-
>  kernel/timer.c      |    1 +
>  4 files changed, 5 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.14-rc5-mm1-full/kernel/timer.c.old	2005-10-30 02:27:36.000000000 +0200
> +++ linux-2.6.14-rc5-mm1-full/kernel/timer.c	2005-10-30 02:27:56.000000000 +0200
> @@ -33,6 +33,7 @@
>  #include <linux/posix-timers.h>
>  #include <linux/cpu.h>
>  #include <linux/syscalls.h>
> +#include <linux/delay.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/unistd.h>
> --- linux-2.6.14-rc5-mm1-full/kernel/irq/proc.c.old	2005-10-30 02:31:31.000000000 +0200
> +++ linux-2.6.14-rc5-mm1-full/kernel/irq/proc.c	2005-10-30 02:31:48.000000000 +0200
> @@ -10,6 +10,8 @@
>  #include <linux/proc_fs.h>
>  #include <linux/interrupt.h>
>  
> +#include "internals.h"
> +
>  static struct proc_dir_entry *root_irq_dir, *irq_dir[NR_IRQS];
>  
>  #ifdef CONFIG_SMP
> --- linux-2.6.14-rc5-mm1-full/kernel/audit.c.old	2005-10-30 02:33:08.000000000 +0200
> +++ linux-2.6.14-rc5-mm1-full/kernel/audit.c	2005-10-30 02:33:15.000000000 +0200
> @@ -272,7 +272,7 @@
>  	return old;
>  }
>  
> -int kauditd_thread(void *dummy)
> +static int kauditd_thread(void *dummy)
>  {
>  	struct sk_buff *skb;
>  
> --- linux-2.6.14-rc5-mm1-full/kernel/rcutorture.c.old	2005-10-30 02:33:35.000000000 +0200
> +++ linux-2.6.14-rc5-mm1-full/kernel/rcutorture.c	2005-10-30 02:33:53.000000000 +0200
> @@ -99,7 +99,7 @@
>  /*
>   * Allocate an element from the rcu_tortures pool.
>   */
> -struct rcu_torture *
> +static struct rcu_torture *
>  rcu_torture_alloc(void)
>  {
>  	struct list_head *p;
> 
> 
