Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbUKKWQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbUKKWQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbUKKWQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:16:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:18910 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262374AbUKKWOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:14:12 -0500
Date: Thu, 11 Nov 2004 14:14:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5
Message-Id: <20041111141403.757ea983.akpm@osdl.org>
In-Reply-To: <111920000.1100210158@flay>
References: <20041111012333.1b529478.akpm@osdl.org>
	<20041111030837.12a2090b.akpm@osdl.org>
	<111920000.1100210158@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> ipc/shm.c:171: error: `shmem_set_policy' undeclared here (not in a function)
>  ipc/shm.c:171: error: initializer element is not constant
>  ipc/shm.c:171: error: (near initialization for `shm_vm_ops.set_policy')
>  ipc/shm.c:172: error: `shmem_get_policy' undeclared here (not in a function)
>  ipc/shm.c:172: error: initializer element is not constant
>  ipc/shm.c:172: error: (near initialization for `shm_vm_ops.get_policy')

hm, I'd have thought that -linus would have the same problem...

--- 25/ipc/shm.c~ipc-numa-build-fix	2004-11-11 14:12:11.874421600 -0800
+++ 25-akpm/ipc/shm.c	2004-11-11 14:12:27.949977744 -0800
@@ -167,7 +167,7 @@ static struct vm_operations_struct shm_v
 	.open	= shm_open,	/* callback for a new vm-area open */
 	.close	= shm_close,	/* callback for when the vm-area is released */
 	.nopage	= shmem_nopage,
-#ifdef CONFIG_NUMA
+#if defined(CONFIG_NUMA) && defined(CONFIG_SHMEM)
 	.set_policy = shmem_set_policy,
 	.get_policy = shmem_get_policy,
 #endif
_

