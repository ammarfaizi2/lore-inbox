Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030561AbVLWPRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030561AbVLWPRO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 10:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030560AbVLWPRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 10:17:14 -0500
Received: from 217-133-42-200.b2b.tiscali.it ([217.133.42.200]:41027 "EHLO
	opteron.random") by vger.kernel.org with ESMTP id S1030370AbVLWPRN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 10:17:13 -0500
Date: Fri, 23 Dec 2005 16:17:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: nfs invalidates lose pte dirty bits
Message-ID: <20051223151711.GA9576@opteron.random>
References: <20051222175550.GT9576@opteron.random> <1135294250.3685.16.camel@lade.trondhjem.org> <20051223023603.GY9576@opteron.random> <1135327315.8167.11.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135327315.8167.11.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 09:41:55AM +0100, Trond Myklebust wrote:
> On Fri, 2005-12-23 at 03:36 +0100, Andrea Arcangeli wrote:
> > On Thu, Dec 22, 2005 at 06:30:49PM -0500, Trond Myklebust wrote:
> > > See the latest git release where we introduce the nfs_sync_mapping()
> > > helper.
> > 
> > So you also still break completely with threaded programs, did you
> > consider that while fixing the most obvious problem? Isn't that a
> > problem too? What about my suggestion of invalidate_inode_clean_pages?
> 
> It is only a problem when doing mmap writes. In the case of ordinary

Yes, those changes are all about mmap writes.

> However if the user is doing mmap writes while the file is in the
> process of being modified on the server, then they are doing something
> wrong anyway. The small race between nfs_sync_mapping() and
> invalidate_inode_pages2() is the least of their problems.

I'm talking about spurious revalidates, I don't think the testcase I'm
dealing with is really needing an invalidate, it's a spurious one
(perhaps triggered by flock), but I'm lucky it's single threaded so
current fix will work for them.
