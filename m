Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268924AbTCDAeI>; Mon, 3 Mar 2003 19:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268925AbTCDAeI>; Mon, 3 Mar 2003 19:34:08 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:52694 "EHLO
	albatross.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S268924AbTCDAeG>; Mon, 3 Mar 2003 19:34:06 -0500
Date: Mon, 3 Mar 2003 19:50:14 -0500
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63-mm2
Message-ID: <20030304005014.GA197@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.63-mm2 gave the oops below running dbench 192.

Quad P3 Xeon
3.75 GB Ram
ext3 filesystems for most things.
ext2 filesystem for testing.
SCSI disks.
Using anticipatory scheduler.

kernel BUG at drivers/block/as-iosched.c:188!
invalid operand: 0000
CPU:    1
EIP:    0060:[put_as_io_context+17/64]    Not tainted
EIP:    0060:[<c0257191>]    Not tainted
EFLAGS: 00010046
EIP is at put_as_io_context+0x11/0x40
eax: 00000000   ebx: f7e5c968   ecx: 00000000   edx: f6c08500
esi: f7e5c968   edi: 00000000   ebp: 00000001   esp: c3671f10
ds: 007b   es: 007b   ss: 0068
Process events/1 (pid: 11, threadinfo=c3670000 task=c36772e0)
Stack: f6c08760 c0257267 f7e5c968 c372f278 f7e5c8c0 c0257937 f7e5c968 c372f290
       f7e5c8c0 c372f278 00000000 c0258091 f7e5c8c0 c372f278 c37c1200 00000287
       f7fe20a0 c37c1200 c02581e6 f7e5c8c0 c02510ce c37c1200 c0252905 c37c1200
Call Trace:
 [copy_as_io_context+39/48] copy_as_io_context+0x27/0x30
 [<c0257267>] copy_as_io_context+0x27/0x30
 [as_move_to_dispatch+71/144] as_move_to_dispatch+0x47/0x90
 [<c0257937>] as_move_to_dispatch+0x47/0x90
 [as_dispatch_request+417/432] as_dispatch_request+0x1a1/0x1b0
 [<c0258091>] as_dispatch_request+0x1a1/0x1b0
 [as_queue_notready+38/64] as_queue_notready+0x26/0x40
 [<c02581e6>] as_queue_notready+0x26/0x40
 [elv_queue_empty+14/32] elv_queue_empty+0xe/0x20
 [<c02510ce>] elv_queue_empty+0xe/0x20
 [generic_unplug_device+69/112] generic_unplug_device+0x45/0x70
 [<c0252905>] generic_unplug_device+0x45/0x70
 [worker_thread+458/656] worker_thread+0x1ca/0x290
 [<c01281ba>] worker_thread+0x1ca/0x290
 [blk_unplug_work+0/16] blk_unplug_work+0x0/0x10
 [<c0252930>] blk_unplug_work+0x0/0x10
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0117680>] default_wake_function+0x0/0x20
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [<c0108e5e>] ret_from_fork+0x6/0x14
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0117680>] default_wake_function+0x0/0x20
 [worker_thread+0/656] worker_thread+0x0/0x290
 [<c0127ff0>] worker_thread+0x0/0x290
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
 [<c01070e5>] kernel_thread_helper+0x5/0x10

Code: 0f 0b bc 00 73 69 35 c0 f0 ff 0a 0f 94 c0 84 c0 74 14 f0 ff

dbench 64 completed 5 times before this.  The first dbench 192
completed okay too (based on logfile).  Oops came during 2nd dbench
192 run.

After rebooting, I noticed a load average while the system was 
supposed to be idle:

$ uptime
  4:30pm  up 50 min,  2 users,  load average: 4.00, 3.97, 3.82

$ ps aux|grep D[W]
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         2  0.0  0.0     0    0 ?        DW   15:40   0:00 [migration/0]
root         4  0.0  0.0     0    0 ?        DW   15:40   0:00 [migration/1]
root         6  0.0  0.0     0    0 ?        DW   15:40   0:00 [migration/2]
root         8  0.0  0.0     0    0 ?        DW   15:40   0:00 [migration/3]


Things in .config that were not in 2.5.62-mm2: (2.5.62-mm2 was fine on this machine)
CONFIG_JFS_FS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS=y
CONFIG_NR_SIBLINGS_0=y
CONFIG_XFS_FS=y

No jfs or xfs filesystems were mounted at the time of oops nor
when migration/N was in DW state.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

