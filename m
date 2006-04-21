Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWDUNO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWDUNO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 09:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWDUNO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 09:14:59 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:9873 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932292AbWDUNO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 09:14:59 -0400
Date: Fri, 21 Apr 2006 15:14:07 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arnd Bergmann <arnd@arndb.de>
cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, davem@davemloft.net,
       Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] fix spu_callbacks BUILD_BUG_ON
In-Reply-To: <200604211245.27744.arnd@arndb.de>
Message-ID: <Pine.LNX.4.61.0604211512370.23180@yvahk01.tjqt.qr>
References: <20060421080239.GC4717@suse.de> <20060421022555.2d460805.akpm@osdl.org>
 <200604211241.36596.arnd@arndb.de> <200604211245.27744.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>--- linus-2.6.orig/arch/powerpc/platforms/cell/spu_callbacks.c
>+++ linus-2.6/arch/powerpc/platforms/cell/spu_callbacks.c
>@@ -317,17 +317,16 @@ void *spu_syscall_table[] = {
> 	[__NR_ppoll]			sys_ni_syscall, /* sys_ppoll */
> 	[__NR_unshare]			sys_unshare,
> 	[__NR_splice]			sys_splice,
>+	[__NR_tee]			sys_tee,

+      [__NR_syscalls] = NULL,

> };
> 
> long spu_sys_callback(struct spu_syscall_block *s)
> {
> 	long (*syscall)(u64 a1, u64 a2, u64 a3, u64 a4, u64 a5, u64 a6);
> 
>-	BUILD_BUG_ON(ARRAY_SIZE(spu_syscall_table) != __NR_syscalls);
>-
> 	syscall = spu_syscall_table[s->nr_ret];
> 
>-	if (s->nr_ret >= __NR_syscalls) {
>+	if (s->nr_ret >= ARRAY_SIZE(spu_syscall_table)) {

+       if(syscall == NULL) {



That way, syscalls could be added in the master table while spu does not 
break. Comments?


Jan Engelhardt
-- 
