Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265948AbTFWFWt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 01:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbTFWFWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 01:22:49 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:19922 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S265948AbTFWFWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 01:22:48 -0400
Date: Mon, 23 Jun 2003 06:38:11 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page cache readahead implemented?
In-Reply-To: <20030622160431.3e94369b.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0306230631240.1330-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jun 2003, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> > 
> > No prize for guessing it was tmpfs I found the problem with.
> 
> Yeah, the usual blot on the kernelscape.

Now, now, tmpfs is there to keep you honest!

> > Am I reading alloc_inode correctly, that the default it gives is
> > an empty_aops with NULL readpage, but a backing_dev_info with non-0
> > ra_pages?  How does your do_mmap_pgoff fare on a PROT_EXEC mapping
> > of one of those mmaping device drivers?
> 
> Probably explodes?  I'm not particularly serious about that change - it
> can be done in userspace.

You mean, by MADV_WILLNEED...?

> Is the do_mmap_pgoff() hack the only offender?  If so it would be better to
> localise the test in there too.

No, it's not quite the only (see original comments): I've not tried it,
but madvise_willneed (looks like it) suffers from the same assumption.

Hugh

