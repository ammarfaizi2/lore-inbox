Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266395AbUFUShU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266395AbUFUShU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 14:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUFUShU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 14:37:20 -0400
Received: from [80.72.36.106] ([80.72.36.106]:4487 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S266395AbUFUSgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 14:36:46 -0400
Date: Mon, 21 Jun 2004 20:36:40 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: network related(?) kernel panic (2.6.7-bk4)
In-Reply-To: <Pine.LNX.4.58.0406191040170.6178@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0406212019460.28702@alpha.polcom.net>
References: <20040426013944.49a105a8.akpm@osdl.org>
 <Pine.LNX.4.58.0404270105200.2304@donald.themaw.net>
 <Pine.LNX.4.58.0404261917120.24825@alpha.polcom.net>
 <Pine.LNX.4.58.0404261102280.19703@ppc970.osdl.org>
 <Pine.LNX.4.58.0404262350450.3003@alpha.polcom.net>
 <Pine.LNX.4.58.0406191841050.6160@alpha.polcom.net>
 <Pine.LNX.4.58.0406191040170.6178@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am testing 2.6.7-bk4 + timer fix + vesafb-tng patch. This time without 
debuging compiled in. Everything worked perfectly before I got:

bad: scheduling while atomic!
schedule+0x466/0x470
do_page_fault+0x104/0x4c1
ip_route_output_flow+0x22/0x70
sys_sched_yield+0x3f/0x50
coredump_wait+0x31/0xa0
do_coredump+0xf1/0x1af
sockfd_lookup+0x16/0x80
do_page_fault+0x0/0x4c1
error_code+0x2d/0x38
__dequeue_signal+0xc6/0x160
dequeue_signal+0x23/0x80
get_signal_to_deriver+0x246/0x330
do_signal+0x85/0x100
__sock_create+0x191/0x260
sys_send+0x37/0x40
sys_socketcall+0x12f/0x250
copy_to_user+0x32/0x50
do_page_fault+0x0/0x4c1
do_notify_resume+0x35/0x38
work_notifysig+0x13/0x15
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

(sorry for any mistakes - I copied it by hand).

The kernel was not tainted. I can reproduce the same every time I want to 
connect to the network. I use speedtouch kernel driver. I have script that 
first executes modem_run then pppd then wget to change DNS entries to new 
IP adress. This happens after pppd setups connection and gets IP. I think 
that this happens in wget. This works with 2.6.7, so some recent bk change 
is probably the cause.

Can you help me?


Thanks,

Grzegorz Kulewski

