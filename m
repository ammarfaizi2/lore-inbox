Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTE1XRl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 19:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbTE1XRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 19:17:41 -0400
Received: from services.erkkila.org ([24.97.94.217]:39111 "EHLO erkkila.org")
	by vger.kernel.org with ESMTP id S261566AbTE1XRj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 19:17:39 -0400
Message-ID: <3ED54685.5020706@erkkila.org>
Date: Wed, 28 May 2003 23:30:13 +0000
From: "Paul E. Erkkila" <pee@erkkila.org>
Reply-To: pee@erkkila.org
Organization: ErkkilaDotOrg
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030520
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, neilb@cse.unsw.edu.au
Subject: Re: 2.5.70-mm1 bootcrash, possibly RAID-1
References: <20030408042239.053e1d23.akpm@digeo.com> <3ED49A14.2020704@aitel.hist.no> <20030528111345.GU8978@holomorphy.com> <3ED49EB8.1080506@aitel.hist.no> <20030528113544.GV8978@holomorphy.com> <20030528225913.GA1103@hh.idb.hist.no>
In-Reply-To: <20030528225913.GA1103@hh.idb.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I'm having a similar problem here with 2.5.70. I can't
seem to get the entire stack trace though, but with a
stripped down kernel config it seems to be when during
the time MD starts working.

Machine is an asus p4c8000, intel ich5, using the IDE
part not sata. I'm also using /dev/md0 as my root
partition.

Hope that helps, i'm trying to find a null modem to
get a real capture ;).

-pee

Helge Hafting wrote:

>On Wed, May 28, 2003 at 04:35:44AM -0700, William Lee Irwin III wrote:
>  
>
>>This is unusual; I'm having trouble very close to this area. There is
>>a remote chance it could be the same problem.
>>
>>Could you log this to serial and get the rest of the oops/BUG? If it's
>>where I think it is, I've been looking at end_page_writeback() and so
>>might have an idea or two.
>>    
>>
>
>I tried 2.5.70-mm1 on the dual celeron at home.  This one has
>scsi instead of ide, so I guess it is a RAID-1 problem.
>This machine has root on raid-1 too.  I believe there where
>several oopses in a row, I captured all of the last one
>thanks to a framebuffer with a small font. Here it is:
>
>Unable to handle kernel paging request at virtual address 8a8a8ab6
>*pde=0 OOPS 0000 [#1]
>EIP at put_all_bios+0x47/0x80
>(edx was the register containing 8a8a8a8a)
>Process swapper pid=0 threadinfo c1352000 task=c13f52d0
>Call trace:
>raid_end_bio_io
>raid1_end_request
>scsi_request_fn
>bio_endio
>_end_that_request_first
>scsi_end_request
>__wake_up
>scsi_io_completion
>scsi_delete_timer
>sd_rw_intr
>sym_wakeup_done
>scsi_finish_command
>scsi_softirq
>timer_interrupt
>do_softirq
>do_IRQ
>default_idle
>default_idle
>common_interrupt
>default_idle
>default_idle
>default_idle
>cpu_idle
>printk
><0> Kernel panic:fatal exception in interrupt
>in interrupt - not syncing
>reboot in 300 seconds
>
>This looks very similiar to the partial trace
>from the ide machine,
>it had everything from _end_that_request_first
>down to the three default_idles, but with ide
>instead of scsi functions.
>
>Helge Hafting
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

