Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262747AbTCVMsi>; Sat, 22 Mar 2003 07:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262750AbTCVMsi>; Sat, 22 Mar 2003 07:48:38 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:60549 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S262747AbTCVMs1>;
	Sat, 22 Mar 2003 07:48:27 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.65-mm3 bad: scheduling while atomic! [SCSI]
References: <20030320235821.1e4ff308.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 22 Mar 2003 13:38:44 +0100
In-Reply-To: <20030320235821.1e4ff308.akpm@digeo.com>
Message-ID: <87el4z1sq3.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:
> 
> [SNIP]
> 

Here's a few more funnies caught while burning a CD:

leep+0x77/0xa6 [scsi_mod]
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6c5e>] scsi_sleep_done+0x0/0x14 [scsi_mod]
 [<f4d548e7>] idescsi_abort+0xf1/0xfa [ide_scsi]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a63bd>] scsi_try_to_abort_cmd+0x65/0x80 [scsi_mod]
 [<f08a6506>] scsi_eh_abort_cmds+0x41/0xdb [scsi_mod]
 [<f08a72f8>] scsi_unjam_host+0x165/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
bad: scheduling while atomic!
Call Trace:
 [<c0118b55>] schedule+0x3a4/0x3a9
 [<c011c8a4>] printk+0x11d/0x17b
 [<c0109bbe>] __down+0x91/0xf9
 [<c0118baa>] default_wake_function+0x0/0x12
 [<c010b1dd>] dump_stack+0x11/0x15
 [<c0109dcb>] __down_failed+0xb/0x14
 [<f08a76e8>] .text.lock.scsi_error+0x37/0x47 [scsi_mod]
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6c5e>] scsi_sleep_done+0x0/0x14 [scsi_mod]
 [<f4d548e7>] idescsi_abort+0xf1/0xfa [ide_scsi]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a63bd>] scsi_try_to_abort_cmd+0x65/0x80 [scsi_mod]
 [<f08a6506>] scsi_eh_abort_cmds+0x41/0xdb [scsi_mod]
 [<f08a72f8>] scsi_unjam_host+0x165/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c0119d92>] __might_sleep+0x5f/0x65
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6ce9>] scsi_sleep+0x77/0xa6 [scsi_mod]
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6c5e>] scsi_sleep_done+0x0/0x14 [scsi_mod]
 [<f4d548e7>] idescsi_abort+0xf1/0xfa [ide_scsi]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a63bd>] scsi_try_to_abort_cmd+0x65/0x80 [scsi_mod]
 [<f08a6506>] scsi_eh_abort_cmds+0x41/0xdb [scsi_mod]
 [<f08a72f8>] scsi_unjam_host+0x165/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
bad: scheduling while atomic!
Call Trace:
 [<c0118b55>] schedule+0x3a4/0x3a9
 [<c011c8a4>] printk+0x11d/0x17b
 [<c0109bbe>] __down+0x91/0xf9
 [<c0118baa>] default_wake_function+0x0/0x12
 [<c010b1dd>] dump_stack+0x11/0x15
 [<c0109dcb>] __down_failed+0xb/0x14
 [<f08a76e8>] .text.lock.scsi_error+0x37/0x47 [scsi_mod]
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6c5e>] scsi_sleep_done+0x0/0x14 [scsi_mod]
 [<f4d548e7>] idescsi_abort+0xf1/0xfa [ide_scsi]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a63bd>] scsi_try_to_abort_cmd+0x65/0x80 [scsi_mod]
 [<f08a6506>] scsi_eh_abort_cmds+0x41/0xdb [scsi_mod]
 [<f08a72f8>] scsi_unjam_host+0x165/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c0119d92>] __might_sleep+0x5f/0x65
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6ce9>] scsi_sleep+0x77/0xa6 [scsi_mod]
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6c5e>] scsi_sleep_done+0x0/0x14 [scsi_mod]
 [<f4d548e7>] idescsi_abort+0xf1/0xfa [ide_scsi]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a63bd>] scsi_try_to_abort_cmd+0x65/0x80 [scsi_mod]
 [<f08a6506>] scsi_eh_abort_cmds+0x41/0xdb [scsi_mod]
 [<f08a72f8>] scsi_unjam_host+0x165/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
bad: scheduling while atomic!
Call Trace:
 [<c0118b55>] schedule+0x3a4/0x3a9
 [<c011c8a4>] printk+0x11d/0x17b
 [<c0109bbe>] __down+0x91/0xf9
 [<c0118baa>] default_wake_function+0x0/0x12
 [<c010b1dd>] dump_stack+0x11/0x15
 [<c0109dcb>] __down_failed+0xb/0x14
 [<f08a76e8>] .text.lock.scsi_error+0x37/0x47 [scsi_mod]
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6c5e>] scsi_sleep_done+0x0/0x14 [scsi_mod]
 [<f4d548e7>] idescsi_abort+0xf1/0xfa [ide_scsi]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a63bd>] scsi_try_to_abort_cmd+0x65/0x80 [scsi_mod]
 [<f08a6506>] scsi_eh_abort_cmds+0x41/0xdb [scsi_mod]
 [<f08a72f8>] scsi_unjam_host+0x165/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c0119d92>] __might_sleep+0x5f/0x65
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6ce9>] scsi_sleep+0x77/0xa6 [scsi_mod]
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6c5e>] scsi_sleep_done+0x0/0x14 [scsi_mod]
 [<f4d548e7>] idescsi_abort+0xf1/0xfa [ide_scsi]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a63bd>] scsi_try_to_abort_cmd+0x65/0x80 [scsi_mod]
 [<f08a6506>] scsi_eh_abort_cmds+0x41/0xdb [scsi_mod]
 [<f08a72f8>] scsi_unjam_host+0x165/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
bad: scheduling while atomic!
Call Trace:
 [<c0118b55>] schedule+0x3a4/0x3a9
 [<c011c8a4>] printk+0x11d/0x17b
 [<c0109bbe>] __down+0x91/0xf9
 [<c0118baa>] default_wake_function+0x0/0x12
 [<c010b1dd>] dump_stack+0x11/0x15
 [<c0109dcb>] __down_failed+0xb/0x14
 [<f08a76e8>] .text.lock.scsi_error+0x37/0x47 [scsi_mod]
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6c5e>] scsi_sleep_done+0x0/0x14 [scsi_mod]
 [<f4d548e7>] idescsi_abort+0xf1/0xfa [ide_scsi]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a63bd>] scsi_try_to_abort_cmd+0x65/0x80 [scsi_mod]
 [<f08a6506>] scsi_eh_abort_cmds+0x41/0xdb [scsi_mod]
 [<f08a72f8>] scsi_unjam_host+0x165/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c0119d92>] __might_sleep+0x5f/0x65
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6ce9>] scsi_sleep+0x77/0xa6 [scsi_mod]
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6c5e>] scsi_sleep_done+0x0/0x14 [scsi_mod]
 [<f4d548e7>] idescsi_abort+0xf1/0xfa [ide_scsi]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a63bd>] scsi_try_to_abort_cmd+0x65/0x80 [scsi_mod]
 [<f08a6506>] scsi_eh_abort_cmds+0x41/0xdb [scsi_mod]
 [<f08a72f8>] scsi_unjam_host+0x165/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
bad: scheduling while atomic!
Call Trace:
 [<c0118b55>] schedule+0x3a4/0x3a9
 [<c011c8a4>] printk+0x11d/0x17b
 [<c0109bbe>] __down+0x91/0xf9
 [<c0118baa>] default_wake_function+0x0/0x12
 [<c010b1dd>] dump_stack+0x11/0x15
 [<c0109dcb>] __down_failed+0xb/0x14
 [<f08a76e8>] .text.lock.scsi_error+0x37/0x47 [scsi_mod]
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6c5e>] scsi_sleep_done+0x0/0x14 [scsi_mod]
 [<f4d548e7>] idescsi_abort+0xf1/0xfa [ide_scsi]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a63bd>] scsi_try_to_abort_cmd+0x65/0x80 [scsi_mod]
 [<f08a6506>] scsi_eh_abort_cmds+0x41/0xdb [scsi_mod]
 [<f08a72f8>] scsi_unjam_host+0x165/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c0119d92>] __might_sleep+0x5f/0x65
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6ce9>] scsi_sleep+0x77/0xa6 [scsi_mod]
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6c5e>] scsi_sleep_done+0x0/0x14 [scsi_mod]
 [<f4d548e7>] idescsi_abort+0xf1/0xfa [ide_scsi]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a63bd>] scsi_try_to_abort_cmd+0x65/0x80 [scsi_mod]
 [<f08a6506>] scsi_eh_abort_cmds+0x41/0xdb [scsi_mod]
 [<f08a72f8>] scsi_unjam_host+0x165/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
bad: scheduling while atomic!
Call Trace:
 [<c0118b55>] schedule+0x3a4/0x3a9
 [<c011c8a4>] printk+0x11d/0x17b
 [<c0109bbe>] __down+0x91/0xf9
 [<c0118baa>] default_wake_function+0x0/0x12
 [<c010b1dd>] dump_stack+0x11/0x15
 [<c0109dcb>] __down_failed+0xb/0x14
 [<f08a76e8>] .text.lock.scsi_error+0x37/0x47 [scsi_mod]
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6c5e>] scsi_sleep_done+0x0/0x14 [scsi_mod]
 [<f4d548e7>] idescsi_abort+0xf1/0xfa [ide_scsi]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a63bd>] scsi_try_to_abort_cmd+0x65/0x80 [scsi_mod]
 [<f08a6506>] scsi_eh_abort_cmds+0x41/0xdb [scsi_mod]
 [<f08a72f8>] scsi_unjam_host+0x165/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c0119d92>] __might_sleep+0x5f/0x65
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6ce9>] scsi_sleep+0x77/0xa6 [scsi_mod]
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6c5e>] scsi_sleep_done+0x0/0x14 [scsi_mod]
 [<f4d548e7>] idescsi_abort+0xf1/0xfa [ide_scsi]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a63bd>] scsi_try_to_abort_cmd+0x65/0x80 [scsi_mod]
 [<f08a6506>] scsi_eh_abort_cmds+0x41/0xdb [scsi_mod]
 [<f08a72f8>] scsi_unjam_host+0x165/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
bad: scheduling while atomic!
Call Trace:
 [<c0118b55>] schedule+0x3a4/0x3a9
 [<c011c8a4>] printk+0x11d/0x17b
 [<c0109bbe>] __down+0x91/0xf9
 [<c0118baa>] default_wake_function+0x0/0x12
 [<c010b1dd>] dump_stack+0x11/0x15
 [<c0109dcb>] __down_failed+0xb/0x14
 [<f08a76e8>] .text.lock.scsi_error+0x37/0x47 [scsi_mod]
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6c5e>] scsi_sleep_done+0x0/0x14 [scsi_mod]
 [<f4d548e7>] idescsi_abort+0xf1/0xfa [ide_scsi]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a63bd>] scsi_try_to_abort_cmd+0x65/0x80 [scsi_mod]
 [<f08a6506>] scsi_eh_abort_cmds+0x41/0xdb [scsi_mod]
 [<f08a72f8>] scsi_unjam_host+0x165/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c0119d92>] __might_sleep+0x5f/0x65
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6ce9>] scsi_sleep+0x77/0xa6 [scsi_mod]
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6c5e>] scsi_sleep_done+0x0/0x14 [scsi_mod]
 [<f4d548e7>] idescsi_abort+0xf1/0xfa [ide_scsi]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a63bd>] scsi_try_to_abort_cmd+0x65/0x80 [scsi_mod]
 [<f08a6506>] scsi_eh_abort_cmds+0x41/0xdb [scsi_mod]
 [<f08a72f8>] scsi_unjam_host+0x165/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
bad: scheduling while atomic!
Call Trace:
 [<c0118b55>] schedule+0x3a4/0x3a9
 [<c011c8a4>] printk+0x11d/0x17b
 [<c0109bbe>] __down+0x91/0xf9
 [<c0118baa>] default_wake_function+0x0/0x12
 [<c010b1dd>] dump_stack+0x11/0x15
 [<c0109dcb>] __down_failed+0xb/0x14
 [<f08a76e8>] .text.lock.scsi_error+0x37/0x47 [scsi_mod]
 [<f08ae5d9>] +0x2119/0x2c80 [scsi_mod]
 [<f08a6c5e>] scsi_sleep_done+0x0/0x14 [scsi_mod]
 [<f4d548e7>] idescsi_abort+0xf1/0xfa [ide_scsi]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a63bd>] scsi_try_to_abort_cmd+0x65/0x80 [scsi_mod]
 [<f08a6506>] scsi_eh_abort_cmds+0x41/0xdb [scsi_mod]
 [<f08a72f8>] scsi_unjam_host+0x165/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
ide-scsi: reset called for 12543
bad: scheduling while atomic!
Call Trace:
 [<c0118b55>] schedule+0x3a4/0x3a9
 [<c0122d9e>] add_timer+0x99/0xa5
 [<c01238e4>] schedule_timeout+0x5a/0xab
 [<c011c8a4>] printk+0x11d/0x17b
 [<c012387e>] process_timeout+0x0/0xc
 [<f4d549f8>] idescsi_reset+0x108/0x11e [ide_scsi]
 [<f4d54fa0>] +0x400/0x423 [ide_scsi]
 [<f08a65f7>] scsi_try_bus_device_reset+0x57/0x8d [scsi_mod]
 [<f08a66b0>] scsi_eh_bus_device_reset+0x83/0x17c [scsi_mod]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a7071>] scsi_eh_ready_devs+0x28/0x74 [scsi_mod]
 [<f08a7315>] scsi_unjam_host+0x182/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
hdc: DMA disabled
------------[ cut here ]------------
kernel BUG at kernel/timer.c:172!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0122da0>]    Not tainted
EFLAGS: 00010002 VLI
EIP is at add_timer+0x9b/0xa5
eax: 00000001   ebx: efc4a480   ecx: c02ffe80   edx: c03986f8
esi: e7000000   edi: efc4a4a4   ebp: e7001e58   esp: e7001e44
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_0 (pid: 4794, threadinfo=e7000000 task=e7082780)
Stack: c03986f8 c03986f8 efc4a480 e7000000 00000086 e7001e88 c0223fb8 efc4a4a4
       c022f45b c03986f8 c03986f8 00000000 00000032 c02240a6 00000000 00000000
       c03986f8 e7001eb8 c022468f c03986f8 c02240a6 00000032 00000000 efc4a480
Call Trace:
 [<c0223fb8>] ide_set_handler+0x5f/0xa0
 [<c022f45b>] __ide_dma_off+0x2b/0x32
 [<c02240a6>] atapi_reset_pollfunc+0x0/0x11a
 [<c022468f>] do_reset1+0x211/0x22e
 [<c02240a6>] atapi_reset_pollfunc+0x0/0x11a
 [<c02246dd>] ide_do_reset+0x31/0x84
 [<f4d549d1>] idescsi_reset+0xe1/0x11e [ide_scsi]
 [<f08a65f7>] scsi_try_bus_device_reset+0x57/0x8d [scsi_mod]
 [<f08a66b0>] scsi_eh_bus_device_reset+0x83/0x17c [scsi_mod]
 [<f4d547f6>] idescsi_abort+0x0/0xfa [ide_scsi]
 [<f08a7071>] scsi_eh_ready_devs+0x28/0x74 [scsi_mod]
 [<f08a7315>] scsi_unjam_host+0x182/0x217 [scsi_mod]
 [<c0117020>] do_page_fault+0x0/0x4bf
 [<f08a74fe>] scsi_error_handler+0x154/0x1c0 [scsi_mod]
 [<f08a73aa>] scsi_error_handler+0x0/0x1c0 [scsi_mod]
 [<c0108e69>] kernel_thread_helper+0x5/0xb
 
Code: e0 08 75 20 83 6e 14 01 8b 46 08 83 e0 08 75 08 83 c4 08 5b 5e 5f 5d c3 83 c4 08 5b 5e 5f 5d e9 c1 5d ff ff e8 bc 5d ff ff eb d9 <0f> 0b ac 00 2e 3f 2c c0 eb 8b 55 31 c0 89 e5 83 ec 14 89 7d fc
 <6>note: scsi_eh_0[4794] exited with preempt_count 3
hdc: ATAPI reset complete

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
