Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbTARIFa>; Sat, 18 Jan 2003 03:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbTARIF3>; Sat, 18 Jan 2003 03:05:29 -0500
Received: from packet.digeo.com ([12.110.80.53]:1418 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263333AbTARIF1>;
	Sat, 18 Jan 2003 03:05:27 -0500
Date: Sat, 18 Jan 2003 00:15:46 -0800
From: Andrew Morton <akpm@digeo.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: recent change to exit_mmap
Message-Id: <20030118001546.7df35e13.akpm@digeo.com>
In-Reply-To: <15913.2330.891678.16666@napali.hpl.hp.com>
References: <20030118060522.GE7800@krispykreme>
	<20030117224444.08c48290.akpm@digeo.com>
	<15913.1396.22808.83238@napali.hpl.hp.com>
	<20030117235317.01ad6b7b.akpm@digeo.com>
	<15913.2330.891678.16666@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2003 08:14:21.0408 (UTC) FILETIME=[9AC4AE00:01C2BEC9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> I don't know why SET_PERSONALITY() came to be where it is now, but it
> does make some sense to me.  One thing that comes to mind: on ia64, we
> normally don't map data segments with execute permission but for
> backwards-compatibility, we need to do that for x86 binaries.  I think
> there might be a problem with that if SET_PERSONALITY() was done too
> late.  Certainly something that could be fixed, but I suspect a
> similar ordering issue (perhaps on SPARC?) might have triggered the
> current placement of SET_PERSONALITY().
> 

hmm.  Seems that all the activities between the two first SET_PERSONALITY()
calls and the flush_old_exec() are pretty innocuous.  And no mappings could
be set up there, because flush_old_exec() would remove them again.

I'll ask Dave about it.


