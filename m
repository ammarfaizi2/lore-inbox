Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263263AbTJKCzI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 22:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTJKCzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 22:55:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:12974 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263263AbTJKCzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 22:55:05 -0400
Date: Fri, 10 Oct 2003 19:53:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: trond.myklebust@fys.uio.no
Cc: torvalds@osdl.org, Joel.Becker@oracle.com, cfriesen@nortelnetworks.com,
       jamie@shareable.org, linux-kernel@vger.kernel.org
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-Id: <20031010195343.6e821192.akpm@osdl.org>
In-Reply-To: <16262.62026.603149.157026@charged.uio.no>
References: <20031010172001.GA29301@ca-server1.us.oracle.com>
	<Pine.LNX.4.44.0310101024200.20420-100000@home.osdl.org>
	<16262.62026.603149.157026@charged.uio.no>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> It does nothing for the case Joel mentioned where 2 different nodes
> are writing to the same device, and you need to force a read in order
> to resynchronize the page cache.
> Apart from O_DIRECT, we have nothing in the kernel as it stands that
> will allow userland to deal with this case.

Applications may use fadvise(POSIX_FADV_DONTNEED) to invalidate sections of
a file's pagecache.

It is not designed to be 100% reliable though: mmapped pages will be
retained, and dirty pages are skipped.

For the dirty pages it might be useful to add a new mode to fadvise which
syncs a section of a file's pages; -mm has the necessary infrastructure for
that.

POSIX does not define the fadvise() semantics very clearly, so it is largely
up to us to decide what makes sense.  There are a number of things which we
can do quite easily in there - it's mainly a matter of working out exactly
what we want to do.

