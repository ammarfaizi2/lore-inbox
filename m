Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbTHZP0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbTHZP0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:26:12 -0400
Received: from smtp.urbanet.ch ([195.202.193.135]:2021 "HELO
	anniviers.urbanet.ch") by vger.kernel.org with SMTP id S261509AbTHZP0H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:26:07 -0400
Subject: oops is when suspending ide-default driver
From: Sylvain Pasche <sylvain_pasche@yahoo.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061911572.1128.8.camel@highscreen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 26 Aug 2003 17:26:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've got an ide cdrom on my system, which uses the ide-cd module. If I
try to suspend the system when the ide-cd module is not loaded, kernel
oopses:

[<c01f4e26>] start_request+0x11c/0x25e
[<c01f51b1>] ide_do_request+0x226/0x3f7
[<c01f59d3>] ide_do_drive_cmd+0xd1/0x126
[<c01fdd18>] generic_ide_suspend+0x82/0x8f
[<c01e7b23>] suspend_device+0x77/0xbd
[<c01e7bc4>] device_suspend+0x5b/0x76
[<c012e58c>] suspend_prepare+0x44/0x91
[<c012e654>] enter_state+0x42/0x77
[<c0124c66>] sys_reboot+0x2e0/0x33d
[<c013f7d4>] handle_mm_fault+0xd8/0x169
[<c0113f22>] do_page_fault+0x25e/0x4a4
[<c01d09d7>] write_chan+0x0/0x224
[<c01cb44f>] tty_write+0x0/0x2f2
[<c014c3cb>] vfs_write+0xba/0x10c
[<c014c4b9>] sys_write+0x3f/0x5d
[<c0113cc4>] do_page_fault+0x0/0x4a4
[<c0109117>] syscall_call+0x7/0xb

If found out with some printk that it is because the
DRIVER(drive)->start_power_step pointer is NULL is start_request when
called with the ide-default subdriver.

As soon as I load ide-cd, there's no oops anymore. I guess the fix might
be not to run the suspend stuff if the driver has no start_power_step
defined.

Regards,
Sylvain Pasche
