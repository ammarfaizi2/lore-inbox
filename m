Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbTDIDUk (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 23:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTDIDUk (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 23:20:40 -0400
Received: from [12.47.58.221] ([12.47.58.221]:64777 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262005AbTDIDUk (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 23:20:40 -0400
Date: Tue, 8 Apr 2003 20:32:35 -0700
From: Andrew Morton <akpm@digeo.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: opost_block sleeping in illegal context.
Message-Id: <20030408203235.60103051.akpm@digeo.com>
In-Reply-To: <20030409011212.GB25834@suse.de>
References: <20030409011212.GB25834@suse.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Apr 2003 03:32:13.0830 (UTC) FILETIME=[9C9B0260:01C2FE48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> Not seen this one before.. 2.5.67
> 
> 		Dave
> 
> 
> Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
> Call Trace:
>  [<c0120d61>] __might_sleep+0x61/0x80
>  [<c011c3af>] do_page_fault+0x19f/0x4e4
>  [<c013104b>] specific_send_sig_info+0xeb/0x160
>  [<c03291f5>] opost_block+0xf5/0x1c0
>  [<c011c66d>] do_page_fault+0x45d/0x4e4
>  [<c011c210>] do_page_fault+0x0/0x4e4
>  [<c010b41d>] error_code+0x2d/0x40
>  [<c02e66d6>] __copy_to_user_ll+0x26/0x50
>  [<c010e967>] save_v86_state+0x1a7/0x1c0
>  [<c011c210>] do_page_fault+0x0/0x4e4
>  [<c010a4b6>] work_notifysig_v86+0x6/0x20
>  [<c010a457>] syscall_call+0x7/0xb

No, this isn't opost_block().  It's the vm86 stuff, but I can't see why.

Is do_page_fault+0x19f/0x4e4 a down_read()?  Which one?

If it's repeatable, please change __might_sleep() to display preempt_count()
and irqs_disabled().
