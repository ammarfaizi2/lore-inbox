Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbTEFG2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 02:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTEFG2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 02:28:38 -0400
Received: from [12.47.58.20] ([12.47.58.20]:24337 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262378AbTEFG2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 02:28:37 -0400
Date: Mon, 5 May 2003 23:42:48 -0700
From: Andrew Morton <akpm@digeo.com>
To: davem@redhat.com, rusty@rustcorp.com.au, dipankar@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-Id: <20030505234248.7cc05f43.akpm@digeo.com>
In-Reply-To: <20030505224815.07e5240c.akpm@digeo.com>
References: <20030506040856.8B3712C36E@lists.samba.org>
	<20030505.204002.08338116.davem@redhat.com>
	<20030505220250.213417f6.akpm@digeo.com>
	<20030505.211606.28803580.davem@redhat.com>
	<20030505224815.07e5240c.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2003 06:41:02.0055 (UTC) FILETIME=[75E83770:01C3139A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> - DEFINE_PER_CPU and kmalloc_percpu() work in core kernel, and use the 32k
>   pool.

except sizeof(struct disk_stats)=44, so we run out of percpu space at 744
disks.

Can't think of anything very clever there, except to go and un-percpuify the
disk stats.  I think that's best, really - disk requests only come in at 100
to 200 per second - atomic_t's or int-plus-per-disk-spinlock will be fine.

