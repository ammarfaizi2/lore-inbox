Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbUANGfw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 01:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUANGfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 01:35:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:42422 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263639AbUANGfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 01:35:51 -0500
Date: Tue, 13 Jan 2004 22:36:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Horacio de Oro <hgdeoro@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [2.6.1-mm2] Badness in futex_wait at kernel/futex.c:509
Message-Id: <20040113223612.4fe709d9.akpm@osdl.org>
In-Reply-To: <20040114024234.015eaf21.hgdeoro@yahoo.com>
References: <20040114024234.015eaf21.hgdeoro@yahoo.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horacio de Oro <hgdeoro@yahoo.com> wrote:
>
> Hi!
> 
> This happen every time I switch from X to console:
> 
> Badness in futex_wait at kernel/futex.c:509
> Call Trace:
>  [futex_wait+434/448] futex_wait+0x1b2/0x1c0
>  [default_wake_function+0/32] default_wake_function+0x0/0x20
>  [default_wake_function+0/32] default_wake_function+0x0/0x20
>  [do_futex+112/128] do_futex+0x70/0x80
>  [sys_futex+292/320] sys_futex+0x124/0x140
>  [syscall_call+7/11] syscall_call+0x7/0xb
> 

	/* A spurious wakeup should never happen. */
	WARN_ON(!signal_pending(current));

(looks at Rusty)

