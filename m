Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264372AbTCXSuA>; Mon, 24 Mar 2003 13:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264358AbTCXStB>; Mon, 24 Mar 2003 13:49:01 -0500
Received: from packet.digeo.com ([12.110.80.53]:56723 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264365AbTCXSsT>;
	Mon, 24 Mar 2003 13:48:19 -0500
Date: Mon, 24 Mar 2003 10:59:36 -0800
From: Andrew Morton <akpm@digeo.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.65 interactivity
Message-Id: <20030324105936.559a03d1.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.51.0303241931360.11544@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0303221929350.28558@dns.toxicfilms.tv>
	<20030322132551.75ff8ab8.akpm@digeo.com>
	<Pine.LNX.4.51.0303241931360.11544@dns.toxicfilms.tv>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Mar 2003 18:59:16.0149 (UTC) FILETIME=[777B5650:01C2F237]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:
>
> > First thing we need to work out is whether it is a CPU scheduler thing
> > or if it is a VM/MM/block/fs latency problem.
> OK

It is a VM/MM/block/latency problem.

> > - How much memory do you have?
> 128 MB

Your machine is swapping and paging like crazy.  Bits of your X server get
paged out to disk and take ages to come back because the heavy write streams
are starving reads from disk.

> > - Try setting /proc/sys/vm/swappiness to zero
> i will try.
> 
> > - Try decreasing /proc/sys/vm/dirty_ratio to 15
> will try that too.
> 

These things should help - possibly the defaults are wrong.

Also the anticipatory IO scheduler in -mm kernels might help reduce the disk
read latency.

