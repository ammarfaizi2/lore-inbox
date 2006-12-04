Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759200AbWLDIcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759200AbWLDIcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 03:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759213AbWLDIcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 03:32:23 -0500
Received: from smtp.osdl.org ([65.172.181.25]:14050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1759200AbWLDIcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 03:32:22 -0500
Date: Mon, 4 Dec 2006 00:32:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Fengguang Wu <fengguang.wu@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: drop_pagecache: Possible circular locking dependency
Message-Id: <20061204003217.c0f05e00.akpm@osdl.org>
In-Reply-To: <365219737.01594@ustc.edu.cn>
References: <365219737.01594@ustc.edu.cn>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006 16:09:02 +0800
Fengguang Wu <fengguang.wu@gmail.com> wrote:

> Got the following message when doing some benchmarks.
> I guess we should not hold inode_lock on calling invalidate_inode_pages().
> Any ideas?
> 
> Fengguang Wu
> 
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> 2.6.19-rc6-mm2 #3
> -------------------------------------------------------
> rabench.sh/7467 is trying to acquire lock:
>  (&journal->j_list_lock){--..}, at: [<ffffffff8113bdbc>] journal_try_to_free_buffers+0xdc/0x1c0
> 
> but task is already holding lock:
>  (inode_lock){--..}, at: [<ffffffff810fe857>] drop_pagecache+0x67/0x120
> 
> which lock already depends on the new lock.
> 

drat, I was afraid someone would notice.

It's Hard To Fix.  Removing /proc/sys/vm/drop_pagecache would in fact be 
my preferred fix.
