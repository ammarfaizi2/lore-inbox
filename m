Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbTDUSQc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTDUSQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:16:31 -0400
Received: from [12.47.58.203] ([12.47.58.203]:31077 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261839AbTDUSQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:16:30 -0400
Date: Mon, 21 Apr 2003 11:28:58 -0700
From: Andrew Morton <akpm@digeo.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: nr_threads locking
Message-Id: <20030421112858.35e2d7b5.akpm@digeo.com>
In-Reply-To: <3EA3F153.3000106@colorfullife.com>
References: <3EA3F153.3000106@colorfullife.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Apr 2003 18:28:28.0893 (UTC) FILETIME=[CDFF70D0:01C30833]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> Hi Andrew,
> 
> According to the comments, nr_threads is protected by lock_kernel, but 
> do_fork() runs without the bkl for ages.
> Would it be possible to use your percpu_counters for nr_threads? It 
> seems to be used only to guard against fork bombs and for i_nlink of /proc.
> 

It would be possible, yes.

But thread creation is a "rare" event compared to pagefaults and syscalls. 
An atomic_t will be OK there.
