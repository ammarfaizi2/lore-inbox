Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbTFXQNo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 12:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTFXQNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 12:13:43 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:57094 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262498AbTFXQNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 12:13:01 -0400
Subject: Large backwards time steps panic 2.5.73
From: James Bottomley <James.Bottomley@steeleye.com>
To: johnstul@us.ibm.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Jun 2003 11:26:58 -0500
Message-Id: <1056472020.2085.81.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got one of those fun machines with a failing bios batter that
always boots up with the BIOS clock about a year into the future.

2.5.73 always panics around the time ntpdate sets the clock back to its
normal value with:

kernel BUG at kernel/timer.c:377!
Kernel addresses on the stack:
 [<10129510>] .L1641+0x0/0x38
 [<10105be4>] dump_stack+0x18/0x24
 [<101309fc>] .L996+0x0/0x58
 [<10147e7c>] .L1188+0x18/0x48
 [<10131130>] run_timer_softirq+0x15c/0x1b8
 [<10131210>] do_timer+0x68/0x118
 [<1012ccec>] __crc_scsi_put_command+0x8d/0xe9
 [<101738cc>] locate_fd+0xd0/0x15c
 [<1010737c>] do_cpu_irq_mask+0x90/0xf0
 [<10334f24>] start_kernel+0x4/0x1fc
 [<1010a068>] intr_return+0x0/0x14
 [<10161a7c>] get_empty_filp+0x64/0xfc
 [<101107a8>] .L894+0x14/0x18
 [<10161a7c>] get_empty_filp+0x64/0xfc
 [<10160044>] .L1853+0x94/0xcc
 [<101738cc>] locate_fd+0xd0/0x15c
 [<10334f24>] start_kernel+0x4/0x1fc
 [<1011077c>] .L892+0x0/0x18
 [<103350dc>] start_kernel+0x1bc/0x1fc

Reverting the patch

ChangeSet 1.1348.6.16 2003/06/20 22:13:39 akpm@digeo.com
  [PATCH] revert adjtimex changes
  
  From: John Stultz, George Anzinger, Eric Piel
 
Fixes the problem for me.

The above trace is from a HP PA-RISC machine running 2.5.73-pa1.

James


