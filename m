Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbTFFG4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 02:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265347AbTFFG4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 02:56:38 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:5639 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265337AbTFFG4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 02:56:36 -0400
Message-ID: <3EE03F64.70501@aitel.hist.no>
Date: Fri, 06 Jun 2003 09:14:44 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: 2.5.70-bk10 oops when trying to mount root from raid-1 device
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.70-bk10 has some raid fixes, but raid-1 still fails unlike
2.5.70-mm4.

bk10 successfully discovers raid-1 and raid-0 arrays,
but this happens when the kernel tries to mount root:

<lots of ordinary boot messages>
md ... autorun DONE
<this is where I normally get VFS: Mounted root (ext2 filesystem) readonly.
  I got this instead:>
unable to handle kernel paging request at 5a5a5a86
EIP at put_all_bios+0x047/0x80
process swapper
raid_end_bio_io
deadline_next_request
raid1_end_request
scsi_request_fn
bio_endio
__end_that_request_first
scsi_end_request
scsi_io_completion
sd_rw_intr
scsi_finish_command
scsi_softirq
do_softirq
do_IRQ
default_idle
common_interrupt
default_idle
default_idle
cpu_idle
rest_init
start_kernel
unknown_bootoption
<0> kernel panic, exception in interrupt

This is a dual celeron with two scsi disks, with
two raid-1 arrays and one raid-0.  The
kernel is compiled with preempt and devfs,
using gcc-3.3

Helge Hafting

