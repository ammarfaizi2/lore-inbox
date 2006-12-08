Return-Path: <linux-kernel-owner+w=401wt.eu-S1424626AbWLHObP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424626AbWLHObP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 09:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425521AbWLHObP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 09:31:15 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:40441 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424626AbWLHObO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 09:31:14 -0500
Subject: Re: [PATCH] freezer.h uses task_struct fields
From: Dave Kleikamp <shaggy@ltc.vnet.ibm.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
In-Reply-To: <20061207221343.82271a53.randy.dunlap@oracle.com>
References: <20061207221343.82271a53.randy.dunlap@oracle.com>
Content-Type: text/plain
Date: Fri, 08 Dec 2006 08:31:11 -0600
Message-Id: <1165588271.8686.8.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-07 at 22:13 -0800, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> freezer.h uses task_struct fields so it should include sched.h.
> 
>   CC [M]  fs/jfs/jfs_txnmgr.o
> In file included from fs/jfs/jfs_txnmgr.c:49:
> include/linux/freezer.h: In function 'frozen':
> include/linux/freezer.h:9: error: dereferencing pointer to incomplete type
> include/linux/freezer.h:9: error: 'PF_FROZEN' undeclared (first use in this function)
> include/linux/freezer.h:9: error: (Each undeclared identifier is reported only once
> include/linux/freezer.h:9: error: for each function it appears in.)
> include/linux/freezer.h: In function 'freezing':
> include/linux/freezer.h:17: error: dereferencing pointer to incomplete type
> include/linux/freezer.h:17: error: 'PF_FREEZE' undeclared (first use in this function)
> include/linux/freezer.h: In function 'freeze':
> include/linux/freezer.h:26: error: dereferencing pointer to incomplete type
> include/linux/freezer.h:26: error: 'PF_FREEZE' undeclared (first use in this function)
> include/linux/freezer.h: In function 'do_not_freeze':
> include/linux/freezer.h:34: error: dereferencing pointer to incomplete type
> include/linux/freezer.h:34: error: 'PF_FREEZE' undeclared (first use in this function)
> include/linux/freezer.h: In function 'thaw_process':
> include/linux/freezer.h:43: error: dereferencing pointer to incomplete type
> include/linux/freezer.h:43: error: 'PF_FROZEN' undeclared (first use in this function)
> include/linux/freezer.h:44: warning: implicit declaration of function 'wake_up_process'
> include/linux/freezer.h: In function 'frozen_process':
> include/linux/freezer.h:55: error: dereferencing pointer to incomplete type
> include/linux/freezer.h:55: error: dereferencing pointer to incomplete type
> include/linux/freezer.h:55: error: 'PF_FREEZE' undeclared (first use in this function)
> include/linux/freezer.h:55: error: 'PF_FROZEN' undeclared (first use in this function)
> fs/jfs/jfs_txnmgr.c: In function 'freezing':
> include/linux/freezer.h:18: warning: control reaches end of non-void function
> make[2]: *** [fs/jfs/jfs_txnmgr.o] Error 1

Defining CONFIG_SMP or CONFIG_PREEMPT masks this problem (at least in
jfs), since smp_lock.h will include sched.h when CONFIG_LOCK_KERNEL is
defined, and smp_lock.h happens to be included by jfs_txngmr.c before
freezer.h.

> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Acked-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

> ---
>  include/linux/freezer.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-2.6.19-git11.orig/include/linux/freezer.h
> +++ linux-2.6.19-git11/include/linux/freezer.h
> @@ -1,5 +1,7 @@
>  /* Freezer declarations */
> 
> +#include <linux/sched.h>
> +
>  #ifdef CONFIG_PM
>  /*
>   * Check if a process has been frozen
> 
> 


