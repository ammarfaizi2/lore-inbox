Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbTLABbt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 20:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTLABbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 20:31:49 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.29]:32852 "EHLO
	mwinf0201.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262913AbTLABbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 20:31:47 -0500
Subject: Re: PROBLEM: 2.6test11 kernel panic on "head -1 /proc/net/tcp"
From: Thomas Cataldo <tomc@compaqnet.fr>
To: lkml-031128@amos.mailshell.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031129170034.10522.qmail@mailshell.com>
References: <20031128170138.9513.qmail@mailshell.com>
	 <87d6bc2yvq.fsf@devron.myhome.or.jp>
	 <20031129170034.10522.qmail@mailshell.com>
Content-Type: text/plain
Message-Id: <1070242158.1110.150.camel@buffy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 01 Dec 2003 02:29:18 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-11-29 at 18:00, lkml-031128@amos.mailshell.com wrote:
> Partially.  It seems to trigger ppp failure later.
[...]
> This gives me tons of messages like the following:
> 
> Badness in local_bh_enable at kernel/softirq.c:121
> Call Trace:
>   [<c011df25>] local_bh_enable+0x85/0x90
>   [<c02315e2>] ppp_async_push+0xa2/0x180
>   [<c0230efd>] ppp_asynctty_wakeup+0x2d/0x60
>   [<c0202638>] pty_unthrottle+0x58/0x60
>   [<c01ff0fd>] check_unthrottle+0x3d/0x40
>   [<c01ff1a3>] n_tty_flush_buffer+0x13/0x60
>   [<c0202a47>] pty_flush_buffer+0x67/0x70
>   [<c01fba41>] do_tty_hangup+0x3f1/0x460
>   [<c01fcfbc>] release_dev+0x62c/0x660
>   [<c013dfab>] zap_pmd_range+0x4b/0x70
>   [<c013e013>] unmap_page_range+0x43/0x70
>   [<c01622a2>] dput+0x22/0x210
>   [<c01fd38a>] tty_release+0x2a/0x60
>   [<c014ccf8>] __fput+0x108/0x120
>   [<c014b359>] filp_close+0x59/0x90
>   [<c011b874>] put_files_struct+0x54/0xc0
>   [<c011c47d>] do_exit+0x15d/0x3e0
>   [<c011c79a>] do_group_exit+0x3a/0xb0
>   [<c01091b7>] syscall_call+0x7/0xb

I just looked at my logs and realised I add a similar oops in my log. It
happened a few days ago on 2.6.0-test10 (I failed to notice because
everything seems to work fine).

Here is what I have :

Badness in local_bh_enable at kernel/softirq.c:121
Call Trace:
 [<c01251d3>] local_bh_enable+0x93/0xa0
 [<f997dced>] ppp_async_push+0xbd/0x1b0 [ppp_async]
 [<f997d58e>] ppp_asynctty_wakeup+0x2e/0x70 [ppp_async]
 [<c01cc619>] pty_unthrottle+0x59/0x60
 [<c01c8c1b>] check_unthrottle+0x3b/0x40
 [<c01c8cd3>] n_tty_flush_buffer+0x13/0x60
 [<c01cca2d>] pty_flush_buffer+0x6d/0x70
 [<c01cc9c0>] pty_flush_buffer+0x0/0x70
 [<c01c4ee3>] do_tty_hangup+0x4e3/0x580
 [<c01c6752>] release_dev+0x742/0x780
 [<c013f82c>] __pagevec_free+0x1c/0x30
 [<c014487e>] release_pages+0x7e/0x1a0
 [<c0171bb1>] dput+0x31/0x270
 [<c01c6b7b>] tty_release+0x3b/0x90
 [<c015a3db>] __fput+0x10b/0x120
 [<c01588e9>] filp_close+0x59/0x90
 [<c0122634>] put_files_struct+0x64/0xd0
 [<c01233cf>] do_exit+0x19f/0x4c0
 [<c01237c2>] do_group_exit+0x42/0xe0
 [<c0109539>] sysenter_past_esp+0x52/0x71
 
The previous line in my logs was from my TI acx100 wifi card. It runs
with the experimental driver from http://acx100.sf.net. So if this oops
can be caused by bad driver behaviour, please ignore.

I am using ppp with pppoe on a ne2k-pci network board.

I have smp (dual-p3) and preemption enabled. The kernel is compiled with
gcc 3.3.1-2 from debian sid.


