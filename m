Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbTDMBGE (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 21:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbTDMBGE (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 21:06:04 -0400
Received: from [12.47.58.73] ([12.47.58.73]:14974 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262675AbTDMBGD (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 21:06:03 -0400
Date: Sat, 12 Apr 2003 18:18:05 -0700
From: Andrew Morton <akpm@digeo.com>
To: J Sloan <joe@tmsusa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug: slab corruption in 2.5.67-mm1
Message-Id: <20030412181805.1b90bee8.akpm@digeo.com>
In-Reply-To: <3E988DA2.4080600@tmsusa.com>
References: <3E988DA2.4080600@tmsusa.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Apr 2003 01:17:44.0954 (UTC) FILETIME=[7CD53DA0:01C3015A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan <joe@tmsusa.com> wrote:
> 
> This may be of interest -
> 
> kernel: 2.5.67-mm1
> 
> Linux distro: Red Hat 8.0 + updates
> 
> Hardware:
> Celeron 1.2 Ghz on Intel Motherboard
> 512 MB RAM, 2x e100 ethernet

whoa.  Uniprocessor.

> ---- snip ----
> Freeing unused kernel memory: 312k freed
> EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
> Adding 514072k swap on /dev/hda2.  Priority:42 extents:1
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> Slab corruption: start=dfa2f320, expend=dfa2f97f, problemat=dfa2f328
> Data: ********6A 

Yes, this means that someone ran put_task_struct() against an already-freed
task_struct.  There's some deubg code in -mm which is supposed to trap this,
but it obviously didn't trigger for some reason.

Until someone finds a way to reproduce this we're a bit stuck.  A code audit
may find it.
