Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265240AbUEYVOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265240AbUEYVOJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265236AbUEYVOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:14:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:54486 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265235AbUEYVNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:13:54 -0400
Date: Tue, 25 May 2004 14:16:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: andrea@suse.de, mingo@elte.hu, torvalds@osdl.org, phyprabab@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: 4g/4g for 2.6.6
Message-Id: <20040525141622.49e86eb9.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com>
	<Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> On Tue, 25 May 2004, Rik van Riel wrote:
> 
> > The point is, people like to run bigger workloads on
> > bigger systems. Otherwise they wouldn't bother buying
> > those bigger systems.
> 
> Btw, you're right about the VMAs.  Looking through customer
> stuff a bit more the more common issues are low memory being
> eaten by dentry / inode cache - which you can't always reclaim
> due to files being open, and don't always _want_ to reclaim
> because that could well be a bigger performance hit than the
> 4:4 split.

I did some testing a year or two back with the normal zone wound down to a
few hundred megs - filesytem benchmarks were *severely* impacted by the
increased turnover rate of fs metadata pagecache and VFS caches.  I forget
the details, but it was "wow".

> The primary impact of the dentry / inode cache using memory
> isn't lowmem exhaustion, btw.  It's lowmem fragmentation.
> 
> Fragmentation causes fork trouble (gone with the 4k stacks)
> and trouble for the network layer and kiobuf allocation,
> which still do need higher order allocations.

I'm suspecting we'll end up needing mempools (or something) of 1- and
2-order pages to support large-frame networking.  I'm surprised there isn't
more pressure to do something about this.  Maybe people are increasing
min_free_kbytes.

