Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbUBZT41 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbUBZT41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:56:27 -0500
Received: from imf17aec.mail.bellsouth.net ([205.152.59.65]:51598 "EHLO
	imf17aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262969AbUBZT4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:56:24 -0500
Message-ID: <403E4F63.9090301@jcwren.com>
Date: Thu, 26 Feb 2004 14:56:19 -0500
From: "J.C. Wren" <jcwren@jcwren.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sleeping function called from invalid context in 2.6.3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I keep getting the following error whenever I attempt to use k3b (CD 
burning software).  Kernel 2.6.3, /dev/hdc is a Hewlett-Packard DVD 
Writer 200, ATAPI CD/DVD-ROM drive.  I've posted my .config, lilo.conf, 
dmesg log, gcc version, and a copy of the error message at 
http://tinymicros.com/kernel, rather than attaching all of it.  hdc=scsi 
is on the append line for lilo.

    --jc


Debug: sleeping function called from invalid context at 
include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011989b>] __might_sleep+0xab/0xd0
 [<c02bd2ac>] scsi_sleep+0x6c/0x90
 [<c02bd220>] scsi_sleep_done+0x0/0x20
 [<c02e0178>] idescsi_abort+0xd8/0xf0
 [<c02bcbb9>] scsi_try_to_abort_cmd+0x59/0x80
 [<c02bccf0>] scsi_eh_abort_cmds+0x40/0x80
 [<c02bd6d2>] scsi_unjam_host+0xa2/0xd0
 [<c02bd7da>] scsi_error_handler+0xda/0x120
 [<c02bd700>] scsi_error_handler+0x0/0x120
 [<c0107069>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c0118469>] schedule+0x579/0x580
 [<c011c436>] printk+0x136/0x190
 [<c0107f25>] __down+0x85/0x100
 [<c01184c0>] default_wake_function+0x0/0x20
 [<c01095fe>] dump_stack+0x1e/0x20
 [<c010813f>] __down_failed+0xb/0x14
 [<c02bda42>] .text.lock.scsi_error+0x37/0x75
 [<c02bd220>] scsi_sleep_done+0x0/0x20
 [<c02e0178>] idescsi_abort+0xd8/0xf0
 [<c02bcbb9>] scsi_try_to_abort_cmd+0x59/0x80
 [<c02bccf0>] scsi_eh_abort_cmds+0x40/0x80
 [<c02bd6d2>] scsi_unjam_host+0xa2/0xd0
 [<c02bd7da>] scsi_error_handler+0xda/0x120
 [<c02bd700>] scsi_error_handler+0x0/0x120
 [<c0107069>] kernel_thread_helper+0x5/0xc

ide-scsi: reset called for 59
bad: scheduling while atomic!
Call Trace:
 [<c0118469>] schedule+0x579/0x580
 [<c0118511>] __wake_up_common+0x31/0x60
 [<c01243ce>] schedule_timeout+0x5e/0xb0
 [<c0124360>] process_timeout+0x0/0x10
 [<c02e0287>] idescsi_reset+0xf7/0x110
 [<c02bcd82>] scsi_try_bus_device_reset+0x52/0x90
 [<c02bce1d>] scsi_eh_bus_device_reset+0x5d/0xe0
 [<c02bd568>] scsi_eh_ready_devs+0x28/0x70
 [<c02bd6ef>] scsi_unjam_host+0xbf/0xd0
 [<c02bd7da>] scsi_error_handler+0xda/0x120
 [<c02bd700>] scsi_error_handler+0x0/0x120
 [<c0107069>] kernel_thread_helper+0x5/0xc

hdc: ATAPI reset complete
SCSI error : <1 0 0 0> return code = 0x6000000

