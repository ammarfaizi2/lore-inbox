Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbUKPTS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUKPTS0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbUKPTQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:16:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:643 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262097AbUKPTPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:15:46 -0500
Date: Tue, 16 Nov 2004 11:15:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robin Holt <holt@sgi.com>
Cc: holt@sgi.com, linux-kernel@vger.kernel.org, dev@sw.ru, wli@holomorphy.com,
       steiner@sgi.com, sandeen@sgi.com
Subject: Re: 21 million inodes is causing severe pauses.
Message-Id: <20041116111532.3202e4e2.akpm@osdl.org>
In-Reply-To: <20041116163224.GB5594@lnx-holt.americas.sgi.com>
References: <20041115195551.GA15380@lnx-holt.americas.sgi.com>
	<20041115145714.3f757012.akpm@osdl.org>
	<20041116163224.GB5594@lnx-holt.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt <holt@sgi.com> wrote:
>
>  On Mon, Nov 15, 2004 at 02:57:14PM -0800, Andrew Morton wrote:
>  > Robin Holt <holt@sgi.com> wrote:
>  > >
>  > > One significant problem we are running into is autofs trying to umount the
>  > > file systems.  This results in the umount grabbing the BKL and inode_lock,
>  > > holding it while it scans through the inode_list and others looking for
>  > > inodes used by this super block and attempting to free them.
>  > 
>  > You'll need invalidate_inodes-speedup.patch and
>  > break-latency-in-invalidate_list.patch (or an equivalent).
> 
>  With these patches and a new test where I periodically put on mild
>  but diminishing memory pressure, I have been able to get the number
>  of inodes up to 31 Million.  I would really like to find a way to
>  reduce limit the number of inodes or am I seeing a problem where
>  none exists?  After putting on constant mild memory pressure, I have
>  seen then number of inodes stabilize at 17-18 Million.

There shouldn't be anything wrong with that per-se.  You have a big system,
and a workload which touches a lot of inodes.  It would be best to fix up
the lock hold times rather than reducing the cached inode count because the
lock hold times are sucky.

That being said, you may get some joy by greatly increasing
/proc/sys/vm/vfs_cache_pressure. Try 10000.

