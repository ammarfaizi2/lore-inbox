Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTDKW22 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTDKW21 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:28:27 -0400
Received: from [12.47.58.73] ([12.47.58.73]:29684 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261872AbTDKW20 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 18:28:26 -0400
Date: Fri, 11 Apr 2003 15:40:06 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: cat@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: ext3 weirdness
Message-Id: <20030411154006.7b4d511c.akpm@digeo.com>
In-Reply-To: <20030411113941.O26054@schatzie.adilger.int>
References: <20030411170655.GA10449@zip.com.au>
	<20030411113941.O26054@schatzie.adilger.int>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Apr 2003 22:40:03.0501 (UTC) FILETIME=[4AF455D0:01C3007B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> wrote:
>
> Because you can't reallocate in-use blocks until the dirty bitmaps have
> been committed to disk in a transaction.

Also, in 2.5 pdflush will take a ref on the inode while writing it out.  So
an unlink while pdflush is writing back the inode's pages will be magically
instantaneous, and pdflush actually does the truncate.

This is pretty ugly, because it is reasonable to expect that if you know
there are no other refs to the inode, your disk space should be available
when the unlink returns.

I don't know what to do about it though.  The userspace workaround is to run
sync before rm.
