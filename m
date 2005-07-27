Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVG0KA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVG0KA0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 06:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVG0KA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 06:00:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10719 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261207AbVG0KAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 06:00:24 -0400
Date: Wed, 27 Jul 2005 02:59:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/23] reboot-fixes
Message-Id: <20050727025923.7baa38c9.akpm@osdl.org>
In-Reply-To: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My fairly ordinary x86 test box gets stuck during reboot on the
wait_for_completion() in ide_do_drive_cmd():


(gdb) thread 73
[Switching to thread 73 (Thread 2906)]#0  ide_do_drive_cmd (drive=0xc072dd10, rq=0x0, 
    action=ide_wait) at drivers/ide/ide-io.c:1671
1671                    rq->waiting = NULL;
(gdb) bt
#0  ide_do_drive_cmd (drive=0xc072dd10, rq=0x0, action=ide_wait) at drivers/ide/ide-io.c:1671
#1  0xc02e64c0 in ide_diag_taskfile (drive=0xc072dd10, args=0xcc0c1e20, data_size=0, buf=0x0)
    at drivers/ide/ide-taskfile.c:503
#2  0xc02e64e6 in ide_raw_taskfile (drive=0x0, args=0x0, buf=0x0) at drivers/ide/ide-taskfile.c:508
#3  0xc02eab6d in do_idedisk_flushcache (drive=0x0) at drivers/ide/ide-disk.c:831
#4  0xc02eb232 in ide_cacheflush_p (drive=0xc072dd10) at drivers/ide/ide-disk.c:1027
#5  0xc02eb2e4 in ide_device_shutdown (dev=0xc072ddf4) at drivers/ide/ide-disk.c:1083
#6  0xc02af75c in device_shutdown () at drivers/base/power/shutdown.c:45
#7  0xc0128bfe in kernel_restart (cmd=0x0) at kernel/sys.c:375
#8  0xc0128dea in sys_reboot (magic1=-18751827, magic2=672274793, cmd=19088743, arg=0x0)
    at kernel/sys.c:484
#9  0xc0102ba3 in sysenter_past_esp () at arch/i386/kernel/semaphore.c:177
