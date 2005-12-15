Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbVLOTzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbVLOTzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbVLOTzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:55:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30410 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750966AbVLOTzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:55:05 -0500
To: janak@us.ibm.com
Cc: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/9] unshare system call: system call handler
 function
References: <1134513959.11972.167.camel@hobbs.atlanta.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 15 Dec 2005 12:52:53 -0700
In-Reply-To: <1134513959.11972.167.camel@hobbs.atlanta.ibm.com> (JANAK
 DESAI's message of "Tue, 13 Dec 2005 17:54:34 -0500")
Message-ID: <m1k6e687e2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JANAK DESAI <janak@us.ibm.com> writes:

> [PATCH -mm 1/9] unshare system call: system call handler function 
>
> sys_unshare system call handler function accepts the same flags as
> clone system call, checks constraints on each of the flags and invokes
> corresponding unshare functions to disassociate respective process
> context if it was being shared with another task. 
>
> Changes since the first submission of this patch on 12/12/05:
> 	- Moved cleaning up of old shared structures outside of the
> 	  block that holds task_lock (12/13/05)
>  
> Signed-off-by: Janak Desai <janak@us.ibm.com>
>  
> ---
>  
>  fork.c | 232 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 232 insertions(+)
>  
> diff -Naurp 2.6.15-rc5-mm2/kernel/fork.c 2.6.15-rc5-mm2+patch/kernel/fork.c
> --- 2.6.15-rc5-mm2/kernel/fork.c	2005-12-12 03:05:59.000000000 +0000
> +++ 2.6.15-rc5-mm2+patch/kernel/fork.c	2005-12-13 18:38:26.000000000 +0000
> @@ -1330,3 +1330,235 @@ void __init proc_caches_init(void)
>  			sizeof(struct mm_struct), 0,
>  			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
>  }
> +
> +
> +/*
> + * Check constraints on flags passed to the unshare system call and
> + * force unsharing of additional process context as appropriate.
> + */

If it isn't legal how about we deny the unshare call.
Then we can share this code with clone.

Eric
