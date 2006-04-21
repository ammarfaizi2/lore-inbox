Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWDUJ1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWDUJ1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 05:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWDUJ1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 05:27:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62155 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932218AbWDUJ1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 05:27:04 -0400
Date: Fri, 21 Apr 2006 02:25:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, davem@davemloft.net
Subject: Re: [PATCH] sys_vmsplice
Message-Id: <20060421022555.2d460805.akpm@osdl.org>
In-Reply-To: <20060421092158.GE4717@suse.de>
References: <20060421080239.GC4717@suse.de>
	<20060421021702.20049dcd.akpm@osdl.org>
	<20060421092158.GE4717@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
>  > long spu_sys_callback(struct spu_syscall_block *s)
>  > {
>  > 	long (*syscall)(u64 a1, u64 a2, u64 a3, u64 a4, u64 a5, u64 a6);
>  > 
>  > 	BUILD_BUG_ON(ARRAY_SIZE(spu_syscall_table) != __NR_syscalls);
> 
>  I'll leave the ppc syscall update out of it.

It might be better to just stick the new entry into the spufs table, make
sure that the powerpc guys see it go in.  That way, ppc64 people (Linus,
maybe you?) can test it.

I guess mapping it onto sys_ni_syscall would be safest.

(It's been broken since sys_tee went in, btw).
