Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbUCTQlY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUCTQlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:41:24 -0500
Received: from 69-90-55-107.fastdsl.ca ([69.90.55.107]:6332 "EHLO
	TMA-1.brad-x.com") by vger.kernel.org with ESMTP id S263479AbUCTQlH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:41:07 -0500
Subject: Re: badness in kernel/softirq.c
From: Brad Laue <brad@brad-x.com>
Reply-To: brad@brad-x.com
To: linux-kernel@vger.kernel.org
In-Reply-To: <1079800804.13796.5.camel@Discovery.brad-x.com>
References: <1079800804.13796.5.camel@Discovery.brad-x.com>
Content-Type: multipart/mixed; boundary="=-TcNOZNaJz3YGGxxUlIo1"
Organization: brad-x.com
Message-Id: <1079800910.13796.7.camel@Discovery.brad-x.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 20 Mar 2004 11:41:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TcNOZNaJz3YGGxxUlIo1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2004-03-20 at 11:40, Brad Laue wrote:
> This is a followup to my earlier mail 'ksoftirqd using mysteriously high
> amounts of CPU time'. After working briefly with Andrew Morton on the
> issue we seem to have identified the 'pppoe' userspace program as the
> culprit for that issue.
> 
> After some playing with kernel options I switched my PPPoE connection
> options from asynctty to synctty, and observed almost no usage of
> ksoftirqd/0 at all, as it should be.
> 
> However, the pppoe process maintains an extreme amount of CPU
> utilization, cutting off the machines ability to send and receive at its
> fastest possible rate. Additionally the attached error fills dmesg after
> a couple of days (vanilla 2.6.3 kernel).
> 
> I'm hoping the PPP stuff in the kernel is well enough maintained that a
> problem/solution can be identified..
> 
> Thanks in advance!
> 
> Brad

I apparently need to be reminded to actually attach attachments. :-)

--=-TcNOZNaJz3YGGxxUlIo1
Content-Disposition: attachment; filename=dmesg.log
Content-Type: text/plain; name=dmesg.log; charset=
Content-Transfer-Encoding: 7bit

Badness in local_bh_enable at kernel/softirq.c:126
Call Trace:
 [<c0121d46>] local_bh_enable+0x86/0x90
 [<d087ac3b>] ppp_sync_push+0x5b/0x170 [ppp_synctty]
 [<d087a63d>] ppp_sync_wakeup+0x2d/0x60 [ppp_synctty]
 [<c024363a>] do_tty_hangup+0x3ea/0x460
 [<c0244bcd>] release_dev+0x62d/0x660
 [<c0142d53>] unmap_page_range+0x43/0x70
 [<c0168b62>] dput+0x22/0x210
 [<c0244faa>] tty_release+0x2a/0x60
 [<c0152ec0>] __fput+0x100/0x120
 [<c0151529>] filp_close+0x59/0x90
 [<c011f594>] put_files_struct+0x54/0xc0
 [<c01201fd>] do_exit+0x18d/0x410
 [<c012051a>] do_group_exit+0x3a/0xb0
 [<c0109387>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:126
Call Trace:
 [<c0121d46>] local_bh_enable+0x86/0x90
 [<d087ac3b>] ppp_sync_push+0x5b/0x170 [ppp_synctty]
 [<d087a63d>] ppp_sync_wakeup+0x2d/0x60 [ppp_synctty]
 [<c024363a>] do_tty_hangup+0x3ea/0x460
 [<c0244bcd>] release_dev+0x62d/0x660
 [<c0142d53>] unmap_page_range+0x43/0x70
 [<c0168b62>] dput+0x22/0x210
 [<c0244faa>] tty_release+0x2a/0x60
 [<c0152ec0>] __fput+0x100/0x120
 [<c0151529>] filp_close+0x59/0x90
 [<c011f594>] put_files_struct+0x54/0xc0
 [<c01201fd>] do_exit+0x18d/0x410
 [<c012051a>] do_group_exit+0x3a/0xb0
 [<c0109387>] syscall_call+0x7/0xb


--=-TcNOZNaJz3YGGxxUlIo1--

