Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263456AbTJLLuc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 07:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbTJLLuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 07:50:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:24022 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263456AbTJLLub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 07:50:31 -0400
Date: Sun, 12 Oct 2003 04:53:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] invalidate_mmap_range() misses
 remap_file_pages()-affected targets
Message-Id: <20031012045332.4a8ac459.akpm@osdl.org>
In-Reply-To: <20031012084842.GB765@holomorphy.com>
References: <20031012084842.GB765@holomorphy.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> invalidate_mmap_range(), and hence vmtruncate(), can miss its targets
>  due to remap_file_pages() disturbing the former invariant of file
>  offsets only being mapped within vmas tagged as mapping file offset
>  ranges containing them.

I was going to just not bother about this wart.  After all, we get to write
the standard on remap_file_pages(), and we can say "the
truncate-causes-SIGBUS thing doesn't work".  After all, it is not very
useful.

But I wonder if this effect could be used maliciously.  Say, user A has
read-only access to user B's file, and uses that access to set up a
nonlinear mapping thereby causing user B's truncate to not behave
correctly.  But this example is OK, isn't it?  User A will just receive an
anonymous page for his troubles.

Can you think of any stability or security scenario which says that we
_should_ implement the conventional truncate behaviour?

