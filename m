Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030464AbVLWImI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbVLWImI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 03:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030465AbVLWImI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 03:42:08 -0500
Received: from pat.uio.no ([129.240.130.16]:16008 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030464AbVLWImH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 03:42:07 -0500
Subject: Re: nfs invalidates lose pte dirty bits
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051223023603.GY9576@opteron.random>
References: <20051222175550.GT9576@opteron.random>
	 <1135294250.3685.16.camel@lade.trondhjem.org>
	 <20051223023603.GY9576@opteron.random>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 09:41:55 +0100
Message-Id: <1135327315.8167.11.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.019, required 12,
	autolearn=disabled, AWL 1.93, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 03:36 +0100, Andrea Arcangeli wrote:
> On Thu, Dec 22, 2005 at 06:30:49PM -0500, Trond Myklebust wrote:
> > See the latest git release where we introduce the nfs_sync_mapping()
> > helper.
> 
> So you also still break completely with threaded programs, did you
> consider that while fixing the most obvious problem? Isn't that a
> problem too? What about my suggestion of invalidate_inode_clean_pages?

It is only a problem when doing mmap writes. In the case of ordinary
writes, NFS has to do its own tracking of dirty pages, and so it can
ensure that no race exists.

However if the user is doing mmap writes while the file is in the
process of being modified on the server, then they are doing something
wrong anyway. The small race between nfs_sync_mapping() and
invalidate_inode_pages2() is the least of their problems.

Cheers,
  Trond

