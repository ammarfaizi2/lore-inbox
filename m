Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWHIIqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWHIIqx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbWHIIqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:46:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49363 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964909AbWHIIqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:46:52 -0400
Date: Wed, 9 Aug 2006 01:30:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] possible recursive locking detected (blkdev_open)
Message-Id: <20060809013034.ac15526a.akpm@osdl.org>
In-Reply-To: <200608090757.32006.eike-kernel@sf-tec.de>
References: <200608090757.32006.eike-kernel@sf-tec.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006 07:57:31 +0200
Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:

> =============================================
> [ INFO: possible recursive locking detected ]
> ---------------------------------------------
> parted/7929 is trying to acquire lock:
>  (&bdev->bd_mutex){--..}, at: [<c105eb8d>] __blkdev_put+0x1e/0x13c
> 
> but task is already holding lock:
>  (&bdev->bd_mutex){--..}, at: [<c105eec6>] do_open+0x72/0x3a8
> 
> other info that might help us debug this:
> 1 lock held by parted/7929:
>  #0:  (&bdev->bd_mutex){--..}, at: [<c105eec6>] do_open+0x72/0x3a8
> stack backtrace:
>  [<c1003aad>] show_trace_log_lvl+0x58/0x15b
>  [<c100495f>] show_trace+0xd/0x10
>  [<c1004979>] dump_stack+0x17/0x1a
>  [<c102dee5>] __lock_acquire+0x753/0x99c
>  [<c102e3b0>] lock_acquire+0x4a/0x6a
>  [<c1204501>] mutex_lock_nested+0xc8/0x20c
>  [<c105eb8d>] __blkdev_put+0x1e/0x13c
>  [<c105ecc4>] blkdev_put+0xa/0xc
>  [<c105f18a>] do_open+0x336/0x3a8
>  [<c105f21b>] blkdev_open+0x1f/0x4c
>  [<c1057b40>] __dentry_open+0xc7/0x1aa
>  [<c1057c91>] nameidata_to_filp+0x1c/0x2e
>  [<c1057cd1>] do_filp_open+0x2e/0x35
>  [<c1057dd7>] do_sys_open+0x38/0x68
>  [<c1057e33>] sys_open+0x16/0x18
>  [<c1002845>] sysenter_past_esp+0x56/0x8d
> DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
> Leftover inexact backtrace:
>  [<c100495f>] show_trace+0xd/0x10
>  [<c1004979>] dump_stack+0x17/0x1a
>  [<c102dee5>] __lock_acquire+0x753/0x99c
>  [<c102e3b0>] lock_acquire+0x4a/0x6a
>  [<c1204501>] mutex_lock_nested+0xc8/0x20c
>  [<c105eb8d>] __blkdev_put+0x1e/0x13c
>  [<c105ecc4>] blkdev_put+0xa/0xc
>  [<c105f18a>] do_open+0x336/0x3a8
>  [<c105f21b>] blkdev_open+0x1f/0x4c
>  [<c1057b40>] __dentry_open+0xc7/0x1aa
>  [<c1057c91>] nameidata_to_filp+0x1c/0x2e
>  [<c1057cd1>] do_filp_open+0x2e/0x35
>  [<c1057dd7>] do_sys_open+0x38/0x68
>  [<c1057e33>] sys_open+0x16/0x18
>  [<c1002845>] sysenter_past_esp+0x56/0x8d
> 

kernel version?
