Return-Path: <linux-kernel-owner+w=401wt.eu-S1760782AbWLHRyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760782AbWLHRyV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 12:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760784AbWLHRyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 12:54:21 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:53664 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760782AbWLHRyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 12:54:20 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Patch] Add necessary #includes to asm-powerpc/spu.h
Date: Fri, 8 Dec 2006 18:54:12 +0100
User-Agent: KMail/1.9.5
Cc: Maynard Johnson <maynardj@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
References: <45799CA2.2090407@us.ibm.com>
In-Reply-To: <45799CA2.2090407@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612081854.13200.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 December 2006 18:10, Maynard Johnson wrote:
>  #define _SPU_H
>  #ifdef __KERNEL__
>  
> +#include <linux/fs.h>
> +#include <linux/notifier.h>
>  #include <linux/workqueue.h>
>  #include <linux/sysdev.h>
>  
Thanks for pointing this out. I'm fixing this in a different way though,
with by adding forward-declarations of the structures to spu.h in order
to avoid making the include hierarchy worse. I'll submit that in a clean
patch along with my next batch of fixes.

	Arnd <><
 
--- a/include/asm-powerpc/spu.h
+++ b/include/asm-powerpc/spu.h
@@ -161,6 +161,7 @@ struct spu_syscall_block {
 extern long spu_sys_callback(struct spu_syscall_block *s);
 
 /* syscalls implemented in spufs */
+struct file;
 extern struct spufs_calls {
 	asmlinkage long (*create_thread)(const char __user *name,
 					unsigned int flags, mode_t mode);
@@ -232,6 +233,7 @@ void spu_remove_sysdev_attr_group(struct
  * to object-id spufs file from user space and the notifer
  * function can assume that spu->ctx is valid.
  */
+struct notifier_block;
 int spu_switch_event_register(struct notifier_block * n);
 int spu_switch_event_unregister(struct notifier_block * n);
 
