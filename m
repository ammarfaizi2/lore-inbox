Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTKEKyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 05:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbTKEKyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 05:54:45 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:31697 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S262813AbTKEKyn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 05:54:43 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Jens Axboe <axboe@suse.de>, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Date: Wed, 5 Nov 2003 05:54:38 -0500
User-Agent: KMail/1.5.1
Cc: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       linux-kernel@vger.kernel.org
References: <3FA69CDF.5070908@gmx.de> <3FA8D059.7010204@cyberone.com.au> <20031105102904.GK1477@suse.de>
In-Reply-To: <20031105102904.GK1477@suse.de>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311050554.38147.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.62.77] at Wed, 5 Nov 2003 04:54:41 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 November 2003 05:29, Jens Axboe wrote:
>On Wed, Nov 05 2003, Nick Piggin wrote:
>> Prakash K. Cheemplavam wrote:
>> >SOmething else I noticed with new 2.6tes9-mm2 kernel: Now the
>> > mouse stutters slighty when burning (in atapi mode). I am now
>> > using as sheduler. Shoudl I try deadline or do you this it is
>> > something else? Should I open a new topic?
>>
>> This is more likely to be the CPU scheduler or something holding
>> interrupts for too long. Are you running anything at a modified
>
>                 ^^^^^^^^
>
>precisely, that's why the actual interface that cdrecord uses is the
>primary key to knowing what the problem is.

Similar problem here Jens.

I have the emulation stuff turned on, and use /dev/scd0 to access my
12/10/32 Creative burner.  I failed to complete an iso burn yesterday,
useing test9-mm1, and the initial logged message indicate an IRQ timeout.

Using k3b, how do I determine the answer to the above, or did I just do that?

Here is the first few lines of the log, there were many:
Nov  4 09:28:40 coyote kernel: hdc: irq timeout: status=0xd8 { Busy }
Nov  4 09:28:40 coyote kernel: hdc: DMA disabled
Nov  4 09:28:40 coyote kernel: ide-scsi: abort called for 9691
Nov  4 09:28:40 coyote kernel: Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
Nov  4 09:28:40 coyote kernel: in_atomic():1, irqs_disabled():1
Nov  4 09:28:40 coyote kernel: Call Trace:
Nov  4 09:28:40 coyote kernel:  [<c011c048>] __might_sleep+0xb8/0xf0
Nov  4 09:28:40 coyote kernel:  [<c026e7dc>] scsi_sleep+0x6c/0x90
Nov  4 09:28:40 coyote kernel:  [<c026e750>] scsi_sleep_done+0x0/0x20
Nov  4 09:28:40 coyote kernel:  [<c027f11f>] idescsi_abort+0xef/0x100
Nov  4 09:28:40 coyote kernel:  [<c026e0c2>] scsi_try_to_abort_cmd+0x62/0x80
Nov  4 09:28:40 coyote kernel:  [<c026e1f0>] scsi_eh_abort_cmds+0x40/0x80
Nov  4 09:28:40 coyote kernel:  [<c026ebe3>] scsi_unjam_host+0xa3/0xd0
Nov  4 09:28:40 coyote kernel:  [<c026ecea>] scsi_error_handler+0xda/0x120
Nov  4 09:28:40 coyote kernel:  [<c026ec10>] scsi_error_handler+0x0/0x120
Nov  4 09:28:40 coyote kernel:  [<c0109349>] kernel_thread_helper+0x5/0xc
Nov  4 09:28:40 coyote kernel:
Nov  4 09:28:40 coyote kernel: bad: scheduling while atomic!
Nov  4 09:28:40 coyote kernel: Call Trace:
Nov  4 09:28:40 coyote kernel:  [<c011a9eb>] schedule+0x57b/0x580
Nov  4 09:28:40 coyote kernel:  [<c011ed2d>] printk+0x12d/0x190
Nov  4 09:28:40 coyote kernel:  [<c010a2ac>] __down+0x8c/0x130
Nov  4 09:28:40 coyote kernel:  [<c011aa50>] default_wake_function+0x0/0x30
Nov  4 09:28:40 coyote kernel:  [<c010b5be>] dump_stack+0x1e/0x20
Nov  4 09:28:40 coyote kernel:  [<c010a51f>] __down_failed+0xb/0x14
Nov  4 09:28:40 coyote kernel:  [<c026ef42>] .text.lock.scsi_error+0x37/0x75
Nov  4 09:28:40 coyote kernel:  [<c026e750>] scsi_sleep_done+0x0/0x20
Nov  4 09:28:40 coyote kernel:  [<c027f11f>] idescsi_abort+0xef/0x100
Nov  4 09:28:40 coyote kernel:  [<c026e0c2>] scsi_try_to_abort_cmd+0x62/0x80
Nov  4 09:28:40 coyote kernel:  [<c026e1f0>] scsi_eh_abort_cmds+0x40/0x80
Nov  4 09:28:40 coyote kernel:  [<c026ebe3>] scsi_unjam_host+0xa3/0xd0
Nov  4 09:28:40 coyote kernel:  [<c026ecea>] scsi_error_handler+0xda/0x120
Nov  4 09:28:40 coyote kernel:  [<c026ec10>] scsi_error_handler+0x0/0x120
Nov  4 09:28:40 coyote kernel:  [<c0109349>] kernel_thread_helper+0x5/0xc

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

