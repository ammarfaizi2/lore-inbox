Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbVAQHJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbVAQHJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 02:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbVAQHJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 02:09:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:31197 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262714AbVAQHJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 02:09:58 -0500
Date: Sun, 16 Jan 2005 23:09:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: torvalds@osdl.org, mingo@elte.hu, cw@f00f.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: Horrible regression with -CURRENT from "Don't busy-lock-loop in
 preemptable spinlocks" patch
Message-Id: <20050116230922.7274f9a2.akpm@osdl.org>
In-Reply-To: <20050117055044.GA3514@taniwha.stupidest.org>
References: <20050117055044.GA3514@taniwha.stupidest.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:
>
> Linus,
> 
> The change below is causing major problems for me on a dual K7 with
> CONFIG_PREEMPT enabled (cset -x and rebuilding makes the machine
> usable again).
> 
> ...
> +BUILD_LOCK_OPS(spin, spinlock_t, spin_is_locked);
> +BUILD_LOCK_OPS(read, rwlock_t, rwlock_is_locked);
> +BUILD_LOCK_OPS(write, rwlock_t, spin_is_locked);

If you replace the last line with

	BUILD_LOCK_OPS(write, rwlock_t, rwlock_is_locked);

does it help?
