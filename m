Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbTHYUB3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 16:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbTHYUB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 16:01:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:29418 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262232AbTHYUBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 16:01:24 -0400
Date: Mon, 25 Aug 2003 12:45:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@oss.sgi.com
Subject: Re: [BUG] 2.6.0-test4-mm1: NFS+XFS=data corruption
Message-Id: <20030825124543.413187a5.akpm@osdl.org>
In-Reply-To: <20030825193717.GC3562@ip68-4-255-84.oc.oc.cox.net>
References: <20030824171318.4acf1182.akpm@osdl.org>
	<20030825193717.GC3562@ip68-4-255-84.oc.oc.cox.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Barry K. Nathan" <barryn@pobox.com> wrote:
>
> I'm really short on time right now, so this bug report might be vague,
> but it's important enough for me to try:
> 
> I have an NFS fileserver (running 2.6.0-test4-mm1) exporting stuff from
> three filesystems: ReiserFS, ext3, and XFS. I'm seeing no problems with
> my ReiserFS and ext3 filesystems. XFS is a different story.
> 
> My client machine is running 2.4.21bkn1 (my own kernel, not released to
> the public; the differences from vanilla 2.4.21 are XFS and Win4Lin). 
> 
> If I use my client machine to sign RPM packages (rpm --addsign ...),
> using rpm-4.2-16mdk, and the packages are on the XFS partition on the
> NFS server, about half of the packages are truncated by a couple hundred
> bytes afterwards (and GPG sig verification fails on those packages).
> 
> It's always the same packages that get truncated by the same amounts of
> data. This is 100% reproducible. It doesn't matter whether I compile the
> kernel with gcc 2.95.3 or 3.1.1. If I perform the operation on my non-XFS
> filesystem the problem doesn't happen. If I run 2.6.0-test4-bk2 instead of
> test4-mm1 on the NFS server, the problem goes away. (I have never run
> any previous -mm kernels on this server.)
> 
> Hmmm... If I sign the packages on the NFS server itself, even with
> test4-mm1 on the XFS partition, I can't reproduce the problem.
> *However*, that's a different version of RPM (4.0.4).
> 
> Is this enough information to help find the cause of the bug? If not,
> it might be several days (if I'm unlucky, maybe even a week or two)
> before I have time to do anything more...
> 

-mm kernels have O_DIRECT-for-NFS patches in them.  And some versions of
RPM use O_DIRECT.  Whether O_DIRECT makes any difference at the server end
I do not know, but it would be useful if you could repeat the test on stock
2.6.0-test4.

Alternatively, run

	export LD_ASSUME_KERNEL=2.2.5

before running RPM.  I think that should tell RPM to not try O_DIRECT.

