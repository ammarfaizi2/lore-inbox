Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbTDLCM1 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 22:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTDLCM1 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 22:12:27 -0400
Received: from [12.47.58.73] ([12.47.58.73]:46102 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263076AbTDLCM0 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 22:12:26 -0400
Date: Fri, 11 Apr 2003 19:24:13 -0700
From: Andrew Morton <akpm@digeo.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, adilger@clusterfs.com
Subject: Re: 2.5.66: slow to friggin slow journal recover
Message-Id: <20030411192413.279f0574.akpm@digeo.com>
In-Reply-To: <20030412021638.GA650@zip.com.au>
References: <20030401100237.GA459@zip.com.au>
	<20030401022844.2dee1fe8.akpm@digeo.com>
	<20030412021638.GA650@zip.com.au>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2003 02:24:03.0735 (UTC) FILETIME=[95F54A70:01C3009A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT <cat@zip.com.au> wrote:
>
> On Tue, Apr 01, 2003 at 02:28:44AM -0800, Andrew Morton wrote:
> > If the journal recovery is still slow then try capturing the state when it is
> > stuck with sysrq-T.
> 
> It finally didn't kill it. This is what it's like when it's not doing
> anything (ie no disk access).
> ...
> fsck.ext3     R CF971E28 4293902656    40     37                     (NOTLB)
> Call Trace:
>  [<c0118a2e>] io_schedule+0xe/0x18
>  [<c012cde8>] wait_on_page_bit+0x9c/0xb8
>  [<c0119088>] autoremove_wake_function+0x0/0x3c
>  [<c0119088>] autoremove_wake_function+0x0/0x3c
>  [<c012d3a2>] do_generic_mapping_read+0x1be/0x328
>  [<c012d7a0>] __generic_file_aio_read+0x184/0x1a0
>  [<c012d50c>] file_read_actor+0x0/0x110
>  [<c012d887>] generic_file_read+0x7f/0x9c
>  [<c0138618>] handle_mm_fault+0x68/0xfc
>  [<c0116960>] do_page_fault+0x0/0x3fe
>  [<c01494ee>] blkdev_file_write+0x26/0x30
>  [<c0142f4e>] vfs_read+0xa2/0xd4
>  [<c014312a>] sys_read+0x2a/0x40
>  [<c0108cf3>] syscall_call+0x7/0xb

OK, you may be thrashing the VM.  fsck can use a lot of memory.

How large is the filesystem?

How many files are on the filesystem?

How much physical memory does the machine have?

Run ALT-sysrq-M during the fsck to get some stats.

