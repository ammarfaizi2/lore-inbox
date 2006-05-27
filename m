Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWE0OuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWE0OuG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 10:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWE0OuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 10:50:05 -0400
Received: from main.gmane.org ([80.91.229.2]:53471 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751538AbWE0OuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 10:50:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sitsofe Wheler <sitsofe@yahoo.com>
Subject: skge killing off snd_via686 interrupts on Fedora Core 5
Date: Sat, 27 May 2006 15:43:30 +0100
Message-ID: <pan.2006.05.27.14.43.20.450376@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpc3-cwma2-0-0-cust739.swan.cable.ntl.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a few machines which have been upgraded to to D-Link System Inc
DGE-530T Gigabit Ethernet adaptors. The unfortunate news is that shortly
after this was done people found that programs were either going
into the D state or hanging while trying to access the soundcard using
ALSA. Looking in the logs turned up this message:

irq 11: nobody cared (try booting with the "irqpoll" option)
 [<c0139893>] __report_bad_irq+0x2b/0x69     [<c0139a54>] note_interrupt+0x183/0x1af
 [<c01393fa>] handle_IRQ_event+0x23/0x4c     [<c01394bd>] __do_IRQ+0x9a/0xcd
 [<c0104c2e>] do_IRQ+0x5c/0x77     =======================
 [<c01035b6>] common_interrupt+0x1a/0x20
 [<e08e6fd4>] skge_poll+0x20b/0x3fc [skge]     [<c028c1f7>] net_rx_action+0x78/0x13f
 [<c011f83a>] __do_softirq+0x35/0x7f     [<c0104c81>] do_softirq+0x38/0x3f
 =======================
 [<c011f8d7>] local_bh_enable+0x53/0x5e     [<c02ad51a>] tcp_recvmsg+0x317/0x6fb
 [<c02842c6>] sock_common_recvmsg+0x2f/0x45     [<c028250d>] sock_recvmsg+0xe9/0x104
 [<c012b10b>] autoremove_wake_function+0x0/0x2d     [<c02dd4b5>] _spin_unlock_irq+0x5/0x7
 [<c01c48b8>] vsnprintf+0x422/0x461     [<c0104c40>] do_IRQ+0x6e/0x77
 [<c02835a3>] sys_recvfrom+0xad/0x10c     [<c0151e25>] fd_install+0x24/0x50
 [<c02dd493>] _read_unlock_irq+0x5/0x7     [<c013a33a>] find_get_page+0x39/0x3f
 [<c0104c40>] do_IRQ+0x6e/0x77     [<c01035b6>] common_interrupt+0x1a/0x20
 [<c0104c40>] do_IRQ+0x6e/0x77     [<c01035b6>] common_interrupt+0x1a/0x20
 [<c028361b>] sys_recv+0x19/0x1d     [<c0283c47>] sys_socketcall+0x117/0x19e
 [<c0104c40>] do_IRQ+0x6e/0x77     [<c0102be9>] syscall_call+0x7/0xb
handlers:
[<e09dfca3>] (snd_via686_interrupt+0x0/0xcd [snd_via82xx])
Disabling IRQ #11

This has also been reported in the Red Hat bugzilla over here:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=192980
on a 2.6.16-1.2122_FC5 kernel. The problem is highly reproducible and
unloading/reloading the snd_via686 module temporarily fixes the problem
until the next big burst of network traffic.

