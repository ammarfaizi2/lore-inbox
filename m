Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbTHYTho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 15:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbTHYTho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 15:37:44 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:1159 "EHLO fed1mtao02.cox.net")
	by vger.kernel.org with ESMTP id S262160AbTHYThU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 15:37:20 -0400
Date: Mon, 25 Aug 2003 12:37:17 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [BUG] 2.6.0-test4-mm1: NFS+XFS=data corruption
Message-ID: <20030825193717.GC3562@ip68-4-255-84.oc.oc.cox.net>
References: <20030824171318.4acf1182.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030824171318.4acf1182.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm really short on time right now, so this bug report might be vague,
but it's important enough for me to try:

I have an NFS fileserver (running 2.6.0-test4-mm1) exporting stuff from
three filesystems: ReiserFS, ext3, and XFS. I'm seeing no problems with
my ReiserFS and ext3 filesystems. XFS is a different story.

My client machine is running 2.4.21bkn1 (my own kernel, not released to
the public; the differences from vanilla 2.4.21 are XFS and Win4Lin). 

If I use my client machine to sign RPM packages (rpm --addsign ...),
using rpm-4.2-16mdk, and the packages are on the XFS partition on the
NFS server, about half of the packages are truncated by a couple hundred
bytes afterwards (and GPG sig verification fails on those packages).

It's always the same packages that get truncated by the same amounts of
data. This is 100% reproducible. It doesn't matter whether I compile the
kernel with gcc 2.95.3 or 3.1.1. If I perform the operation on my non-XFS
filesystem the problem doesn't happen. If I run 2.6.0-test4-bk2 instead of
test4-mm1 on the NFS server, the problem goes away. (I have never run
any previous -mm kernels on this server.)

Hmmm... If I sign the packages on the NFS server itself, even with
test4-mm1 on the XFS partition, I can't reproduce the problem.
*However*, that's a different version of RPM (4.0.4).

Is this enough information to help find the cause of the bug? If not,
it might be several days (if I'm unlucky, maybe even a week or two)
before I have time to do anything more...

-Barry K. Nathan <barryn@pobox.com>
