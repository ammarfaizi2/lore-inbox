Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265940AbUFYAH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265940AbUFYAH0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 20:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbUFYAH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 20:07:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58847 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265940AbUFYAHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 20:07:24 -0400
Date: Thu, 24 Jun 2004 19:07:20 -0500
From: Ken Preslan <kpreslan@redhat.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch to allow distributed flock
Message-ID: <20040625000720.GA13755@potassium.msp.redhat.com>
References: <20040624231057.GA13033@potassium.msp.redhat.com> <1088121132.8906.29.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088121132.8906.29.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 07:52:12PM -0400, Trond Myklebust wrote:
> If you defer updating the VFS until after the ->lock() call returns,
> then it makes it difficult to protect yourself against races (as I
> argued about the POSIX lock interface on the list yesterday).
> 
> If you have the underlying filesystem call flock_lock_file() itself,
> then that gives it the freedom to implement its own locking scheme
> around that call.
> For instance NFS has a thread that is supposed to reclaim locks if the
> server reboots. We take a non-exclusive lock on an rwsem to ensure that
> we block it while there are outstanding locking RPC calls, however that
> rwsem has to be released before we return from the ->lock() call, and so
> there exists a race after the rwsem was released until the
> inode->i_flock list is updated.

Ah, good idea.

Something else I've been wondering:

If the FS is managing the posix locks and/or flocks, is there really a
reason to acquire the VFS versions of the locks too?  As long as there is
some bit set that tells the VFS to call down into the FS to unlock the
locks on process exit, keeping both sets of locks seems wasteful.
What am I missing?

-- 
Ken Preslan <kpreslan@redhat.com>

