Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVAWO6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVAWO6D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 09:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVAWO6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 09:58:02 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:16859 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261313AbVAWO5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 09:57:55 -0500
Subject: Re: 2.6.11-rc2 complains badly aboud badness in local_bh_enable
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050123120114.GA1348@elf.ucw.cz>
References: <20050123120114.GA1348@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 23 Jan 2005 15:57:56 +0100
Message-Id: <1106492276.9269.14.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> -rc1 worked fine here. -rc2 complains a lot:
> 
> Jan 23 12:59:50 amd kernel: Badness in local_bh_enable at kernel/softirq.c:140
> Jan 23 12:59:50 amd kernel:  [local_bh_enable+137/144] local_bh_enable+0x89/0x90
> Jan 23 12:59:50 amd kernel:  [ppp_start_xmit+206/560] ppp_start_xmit+0xce/0x230
> Jan 23 12:59:50 amd kernel:  [qdisc_restart+107/368] qdisc_restart+0x6b/0x170
> Jan 23 12:59:50 amd kernel:  [ip_confirm+77/96] ip_confirm+0x4d/0x60
> Jan 23 12:59:50 amd kernel:  [dev_queue_xmit+526/688] dev_queue_xmit+0x20e/0x2b0
> Jan 23 12:59:50 amd kernel:  [ip_finish_output2+220/432] ip_finish_output2+0xdc/0x1b0
> Jan 23 12:59:50 amd kernel:  [ip_finish_output2+0/432] ip_finish_output2+0x0/0x1b0
> Jan 23 12:59:50 amd kernel:  [nf_hook_slow+225/272] nf_hook_slow+0xe1/0x110
> Jan 23 12:59:50 amd kernel:  [ip_finish_output2+0/432] ip_finish_output2+0x0/0x1b0
> Jan 23 12:59:50 amd kernel:  [dst_output+0/32] dst_output+0x0/0x20
> Jan 23 12:59:50 amd kernel:  [ip_finish_output+494/512] ip_finish_output+0x1ee/0x200
> Jan 23 12:59:50 amd kernel:  [ip_finish_output2+0/432] ip_finish_output2+0x0/0x1b0
> Jan 23 12:59:50 amd kernel:  [dst_output+0/32] dst_output+0x0/0x20
> Jan 23 12:59:50 amd kernel:  [dst_output+11/32] dst_output+0xb/0x20
> Jan 23 12:59:50 amd kernel:  [nf_hook_slow+225/272] nf_hook_slow+0xe1/0x110
> Jan 23 12:59:50 amd kernel:  [dst_output+0/32] dst_output+0x0/0x20
> Jan 23 12:59:50 amd kernel:  [ip_push_pending_frames+996/1088] ip_push_pending_frames+0x3e4/0x440
> Jan 23 12:59:50 amd kernel:  [dst_output+0/32] dst_output+0x0/0x20
> Jan 23 12:59:50 amd kernel:  [udp_push_pending_frames+361/672] udp_push_pending_frames+0x169/0x2a0
> Jan 23 12:59:50 amd kernel:  [udp_sendmsg+841/1728] udp_sendmsg+0x349/0x6c0
> Jan 23 12:59:50 amd kernel:  [inet_sendmsg+74/112] inet_sendmsg+0x4a/0x70
> Jan 23 12:59:50 amd kernel:  [sock_sendmsg+190/224] sock_sendmsg+0xbe/0xe0
> Jan 23 12:59:50 amd kernel:  [prep_new_page+85/96] prep_new_page+0x55/0x60
> Jan 23 12:59:50 amd kernel:  [buffered_rmqueue+204/496] buffered_rmqueue+0xcc/0x1f0
> Jan 23 12:59:50 amd kernel:  [prep_new_page+85/96] prep_new_page+0x55/0x60
> Jan 23 12:59:50 amd kernel:  [buffered_rmqueue+204/496] buffered_rmqueue+0xcc/0x1f0
> Jan 23 12:59:51 amd kernel:  [anon_vma_prepare+153/240] anon_vma_prepare+0x99/0xf0
> Jan 23 12:59:51 amd kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
> Jan 23 12:59:51 amd kernel:  [sys_sendto+192/224] sys_sendto+0xc0/0xe0
> Jan 23 12:59:51 amd kernel:  [convert_fxsr_from_user+21/224] convert_fxsr_from_user+0x15/0xe0
> Jan 23 12:59:51 amd kernel:  [sys_socketcall+389/592] sys_socketcall+0x185/0x250
> Jan 23 12:59:51 amd kernel:  [do_page_fault+0/1378] do_page_fault+0x0/0x562
> Jan 23 12:59:51 amd kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> 
> I probably provoke it with transmitting data over cellphone over bluetooth?

the problem is the PPP code (not Bluetooth btw.) like others reported so
far. I also see the same problem with the external MadWiFi driver.

Regards

Marcel


