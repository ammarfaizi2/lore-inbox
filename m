Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbTETJLm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 05:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbTETJLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 05:11:42 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:9786 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263642AbTETJLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 05:11:41 -0400
Date: Tue, 20 May 2003 02:27:01 -0700
From: Andrew Morton <akpm@digeo.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dentry/inode accounting for vm_enough_mem()
Message-Id: <20030520022701.406a0d4e.akpm@digeo.com>
In-Reply-To: <1053391863.12309.2.camel@nighthawk>
References: <1053391863.12309.2.camel@nighthawk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2003 09:24:36.0333 (UTC) FILETIME=[A174B1D0:01C31EB1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
>   struct dentry_stat_t {
>   	int nr_dentry;
>   	int nr_unused;
>  +	atomic_t nr_alloced;
>   	int age_limit;          /* age in seconds */
>   	int want_pages;         /* pages requested by system */
>   	int dummy[2];

We're not at liberty to do this because /proc/sys/fs/dentry-state and
inode-state are implemented assuming that these structs are an array of
integers.  It'll screw up if the architecture's "int" and "atomic_t"
representations are different.

Probably you can just make this an integer and add a spinlock for it, or
not place it in dentry_stat.

Seems otherwise OK though.  Thanks.
