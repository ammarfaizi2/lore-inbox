Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263550AbUCTVxR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 16:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbUCTVxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 16:53:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:21973 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263550AbUCTVxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 16:53:16 -0500
Date: Sat, 20 Mar 2004 13:53:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: brad@brad-x.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: badness in kernel/softirq.c
Message-Id: <20040320135317.544622f8.akpm@osdl.org>
In-Reply-To: <1079800910.13796.7.camel@Discovery.brad-x.com>
References: <1079800804.13796.5.camel@Discovery.brad-x.com>
	<1079800910.13796.7.camel@Discovery.brad-x.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Laue <brad@brad-x.com> wrote:
>
> Badness in local_bh_enable at kernel/softirq.c:126
>  Call Trace:
>   [<c0121d46>] local_bh_enable+0x86/0x90
>   [<d087ac3b>] ppp_sync_push+0x5b/0x170 [ppp_synctty]
>   [<d087a63d>] ppp_sync_wakeup+0x2d/0x60 [ppp_synctty]
>   [<c024363a>] do_tty_hangup+0x3ea/0x460
>   [<c0244bcd>] release_dev+0x62d/0x660
>   [<c0142d53>] unmap_page_range+0x43/0x70
>   [<c0168b62>] dput+0x22/0x210
>   [<c0244faa>] tty_release+0x2a/0x60
>   [<c0152ec0>] __fput+0x100/0x120
>   [<c0151529>] filp_close+0x59/0x90
>   [<c011f594>] put_files_struct+0x54/0xc0
>   [<c01201fd>] do_exit+0x18d/0x410
>   [<c012051a>] do_group_exit+0x3a/0xb0
>   [<c0109387>] syscall_call+0x7/0xb

This is reminding us that nobody has fixed the tty locking yet.  It's
generally harmless in practice.
