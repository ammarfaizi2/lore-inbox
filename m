Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTJMLFQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 07:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbTJMLFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 07:05:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:49062 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261681AbTJMLFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 07:05:11 -0400
Date: Mon, 13 Oct 2003 04:08:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: kk@sw.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Invalidate_inodes can be very slow
Message-Id: <20031013040821.19b3745e.akpm@osdl.org>
In-Reply-To: <20031013095347.GF16158@holomorphy.com>
References: <200310131318.09234.kk@sw.ru>
	<20031013095347.GF16158@holomorphy.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> Untested brute-force forward port to 2.6.0-test7-bk4. No idea if the
>  locking is correct or if list movement is done in all needed places.

My preferred approach to this would be to move all the global inode lists
into the superblock so both they and inode_lock become per-sb.

It is a big change though.  And, amazingly, nobody has yet hit sufficient
inode_lock contention to warrant it.

Yes, I bet that this search will hurt like hell on a really big box which
has thousands of auto-expiring NFS mounts.  Please test your patch and I'll
queue it up while we think about it some more.


