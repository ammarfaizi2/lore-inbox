Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTFCR3M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 13:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbTFCR3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 13:29:12 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:24951 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261561AbTFCR3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 13:29:10 -0400
Date: Tue, 3 Jun 2003 10:39:19 -0700
From: Andrew Morton <akpm@digeo.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm3
Message-Id: <20030603103919.454f1796.akpm@digeo.com>
In-Reply-To: <3EDCD20A.1070407@us.ibm.com>
References: <20030531013716.07d90773.akpm@digeo.com>
	<3EDCD20A.1070407@us.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jun 2003 17:42:38.0624 (UTC) FILETIME=[8678F200:01C329F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm3/
> > 
> Re run 50 fsx tests overnight again on mm3.  The tests are all 
> unresponsetive after running a while.  There are lots of disk errors and 
> one call back trace:
> 
> Any idea?
> 
> 
> SCSI disk error : <2 0 4 0> return code = 0x6000000
> end_request: I/O error, dev sdf, sector 14030152
> SCSI disk error : <2 0 0 0> return code = 0x6000000
> end_request: I/O error, dev sdb, sector 10526936
> SCSI disk error : <2 0 0 0> return code = 0x6000000
> end_request: I/O error, dev sdb, sector 10533048
> SCSI disk error : <2 0 0 0> return code = 0x6000000
> end_request: I/O error, dev sdb, sector 10536376

Sick disk, or sick SCSI driver.  Please swap some disks out and if it still
happens, send a report to linux-scsi@vger.kernel.org 

> buffer layer error at fs/buffer.c:2835
> Call Trace:
>   [<c015a760>] drop_buffers+0xc0/0xd0
>   [<c015a7bb>] try_to_free_buffers+0x4b/0xb0
>   [<c01a22ef>] journal_invalidatepage+0xdf/0x130
>   [<c0193123>] ext3_invalidatepage+0x43/0x50
>   [<c0141bb7>] do_invalidatepage+0x27/0x30
>   [<c0141c4e>] truncate_complete_page+0x8e/0x90

That's expected - block_prepare_write() marked the page not uptodate when
it saw the I/O error.  Although that is a fairly bogus thing to be doing.

