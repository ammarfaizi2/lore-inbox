Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTDKXPO (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbTDKXPN (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:15:13 -0400
Received: from [12.47.58.73] ([12.47.58.73]:23549 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262120AbTDKXO5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 19:14:57 -0400
Date: Fri, 11 Apr 2003 16:26:39 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: cat@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: ext3 weirdness
Message-Id: <20030411162639.04ddb83d.akpm@digeo.com>
In-Reply-To: <20030411170352.S26054@schatzie.adilger.int>
References: <20030411170655.GA10449@zip.com.au>
	<20030411113941.O26054@schatzie.adilger.int>
	<20030411154006.7b4d511c.akpm@digeo.com>
	<20030411170352.S26054@schatzie.adilger.int>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Apr 2003 23:26:36.0684 (UTC) FILETIME=[CBD23CC0:01C30081]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> wrote:
>
> On Apr 11, 2003  15:40 -0700, Andrew Morton wrote:
> > Andreas Dilger <adilger@clusterfs.com> wrote:
> > > Because you can't reallocate in-use blocks until the dirty bitmaps have
> > > been committed to disk in a transaction.
> > 
> > Also, in 2.5 pdflush will take a ref on the inode while writing it out.  So
> > an unlink while pdflush is writing back the inode's pages will be magically
> > instantaneous, and pdflush actually does the truncate.
> 
> It should be possible to have pdflush check for i_nlink == 0 and i_count == 1
> periodically, indicating it is the only one that has a reference and then
> immediately iput the node (truncating the pages instead of writing them out).
> 

Yes.  It is supposed to iput() the inode every sync_writeback_pages() (up to
1024 pages) anyway, partly for this reason.

But I have a vague feeling that this is not working.  I'll take a look.

