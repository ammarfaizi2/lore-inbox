Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbTKZNqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 08:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263873AbTKZNqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 08:46:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:54676 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263870AbTKZNqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 08:46:16 -0500
Date: Wed, 26 Nov 2003 05:52:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christian Schlittchen <corwin@amber.kn-bremen.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.0-test10: Badness in local_bh_enable at
 kernel/softirq.c:121
Message-Id: <20031126055258.7526a09d.akpm@osdl.org>
In-Reply-To: <20031126104243.GA1395@amber.kn-bremen.de>
References: <20031126104243.GA1395@amber.kn-bremen.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schlittchen <corwin@amber.kn-bremen.de> wrote:
>
> 
> When trying to establish a ppp/pppoe connection I get the following
> and the connection fails:
> 
> Badness in local_bh_enable at kernel/softirq.c:121
> Call Trace:
> [<c011feac>] local_bh_enable+0x8c/0x90
> [<e096ccae>] ppp_sync_push+0x6e/0x1a0 [ppp_synctty]
> [<c015cdc0>] __lookup_hash+0x70/0xd0
> [<e096c651>] ppp_sync_wakeup+0x31/0x70 [ppp_synctty]
> [<c0207b79>] pty_unthrottle+0x59/0x60
> [<c02043ba>] check_unthrottle+0x3a/0x40
> [<c0204463>] n_tty_flush_buffer+0x13/0x60
> [<c0207f6d>] pty_flush_buffer+0x6d/0x70
> [<c0200c0e>] do_tty_hangup+0x3fe/0x460

The warning is a pest, and is due to do_tty_hangup() bogusly disabling
interrupts in the hope that it does something useful.  It needs to be fixed
up.

But it is unrelated to the PPP failure.  I'm afraid it is so long since I
used PPP and pppd that I cannot suggest how you should set about gathering
extra info on that.

