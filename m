Return-Path: <linux-kernel-owner+w=401wt.eu-S1426145AbWLHTaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426145AbWLHTaI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 14:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426150AbWLHTaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:30:07 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:38546 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426145AbWLHTaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:30:06 -0500
Date: Fri, 8 Dec 2006 11:23:30 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       shaggy@austin.ibm.com
Subject: Re: [PATCH] fs/jfs: fix error due to PF_* undeclared
Message-Id: <20061208112330.7e8d4e88.randy.dunlap@oracle.com>
In-Reply-To: <4579B554.5010701@student.ltu.se>
References: <Pine.LNX.4.64.0611291411300.3513@woody.osdl.org>
	<4579B554.5010701@student.ltu.se>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2006 19:56:20 +0100 Richard Knutsson wrote:

>   CC [M]  fs/jfs/jfs_txnmgr.o
> In file included from fs/jfs/jfs_txnmgr.c:49:
> include/linux/freezer.h: In function ‘frozen’:
> include/linux/freezer.h:9: error: dereferencing pointer to incomplete type
> include/linux/freezer.h:9: error: ‘PF_FROZEN’ undeclared (first use in this function)
> <snip>
> fs/jfs/jfs_txnmgr.c: In function ‘freezing’:
> include/linux/freezer.h:18: warning: control reaches end of non-void function
> make[2]: *** [fs/jfs/jfs_txnmgr.o] Error 1
> make[1]: *** [fs/jfs] Error 2
> make: *** [fs] Error 2
> 
> Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
> 
> ---
> 
> Guess this is the desired fix, since including linux/sched.h in linux/freezer.h
> make little sense.

Why do you say that?  freezer.h is what uses those #defined values,
and freezer.h is what uses struct task_struct fields as well,
so it needs sched.h.


> 
> diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
> index d558e51..2aee0a8 100644
> --- a/fs/jfs/jfs_txnmgr.c
> +++ b/fs/jfs/jfs_txnmgr.c
> @@ -46,6 +46,7 @@ #include <linux/fs.h>
>  #include <linux/vmalloc.h>
>  #include <linux/smp_lock.h>
>  #include <linux/completion.h>
> +#include <linux/sched.h>
>  #include <linux/freezer.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> 
> -

---
~Randy
