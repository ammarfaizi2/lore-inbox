Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267222AbTBUHdq>; Fri, 21 Feb 2003 02:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbTBUHdq>; Fri, 21 Feb 2003 02:33:46 -0500
Received: from packet.digeo.com ([12.110.80.53]:19906 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267222AbTBUHdo>;
	Fri, 21 Feb 2003 02:33:44 -0500
Date: Thu, 20 Feb 2003 23:45:22 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange performance change 59 -> 61/62
Message-Id: <20030220234522.185f3f6c.akpm@digeo.com>
In-Reply-To: <17930000.1045812486@[10.10.2.4]>
References: <32720000.1045671824@[10.10.2.4]>
	<20030219101957.05088aa1.akpm@digeo.com>
	<17280000.1045811967@[10.10.2.4]>
	<17930000.1045812486@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 07:43:43.0379 (UTC) FILETIME=[F5433630:01C2D97C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> Some more stats ... which look rather suspicious. 600% increase for
> dentry_open and __mark_inode_dirty? Hmmmmm.

__mark_inode_dirty() just got itself an smp_mb().  Would be instructive to
disable that.

dentry_open(): don't know - fs/open.c hasn't changed at all.  Perhaps
dcache_rcu has caused additional pingpong?


