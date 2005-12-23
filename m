Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbVLWVDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbVLWVDO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 16:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbVLWVDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 16:03:14 -0500
Received: from pat.uio.no ([129.240.130.16]:58345 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161053AbVLWVDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 16:03:13 -0500
Subject: Re: nfs invalidates lose pte dirty bits
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051223151711.GA9576@opteron.random>
References: <20051222175550.GT9576@opteron.random>
	 <1135294250.3685.16.camel@lade.trondhjem.org>
	 <20051223023603.GY9576@opteron.random>
	 <1135327315.8167.11.camel@lade.trondhjem.org>
	 <20051223151711.GA9576@opteron.random>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 22:02:59 +0100
Message-Id: <1135371779.8555.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.101, required 12,
	autolearn=disabled, AWL 1.85, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 16:17 +0100, Andrea Arcangeli wrote:
> > However if the user is doing mmap writes while the file is in the
> > process of being modified on the server, then they are doing something
> > wrong anyway. The small race between nfs_sync_mapping() and
> > invalidate_inode_pages2() is the least of their problems.
> 
> I'm talking about spurious revalidates, I don't think the testcase I'm
> dealing with is really needing an invalidate, it's a spurious one
> (perhaps triggered by flock), but I'm lucky it's single threaded so
> current fix will work for them.

We should perhaps think of setting up an
"unmap_write_dirty_and_invalidate" helper in order to deal with this
sort of race. As long as we have to first unmap all the pages, then
write the dirty ones, then invalidate them, we will be open to races.

Cheers,
  Trond

