Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUH3XFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUH3XFn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 19:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUH3XFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 19:05:43 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:4044 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265195AbUH3XFb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 19:05:31 -0400
Subject: RE: [PATCH] Allow cluster-wide flock
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ken Preslan <kpreslan@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       sfrench@samba.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093907129.8729.148.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 30 Aug 2004 19:05:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I missed Ken's original mail this morning, so apologies for breaking the
thread...

So I have 2 comments:

Firstly, it would be nice to throw out the existing wait loop in
sys_flock(), and replace it with a call to this new
flock_lock_file_wait(). I suppose that can be done in a separate cleanup
patch, though...


More importantly, though, I'm concerned that the overloading of
f_op->lock() may break behaviour on NFS and CIFS.
NFS currently has a test in nfs_lock() that causes it to return -ENOLCK
if the argument is not a posix lock. I'm planning on changing that by
implementing a proper flock(), but we need an interim solution that
doesn't change existing behaviour for people.

Any comment on the effects on CIFS, Steven?


One solution that I've already suggested to Ken & co is to use a
separate f_op->flock() call. That would be my preference, since the
filesystems have to treat flock and posix locks differently anyway.

Alternatively, we're going to have to fix up NFS at least (CIFS?) before
this patch can be applied to the mainline kernel.

Cheers,
  Trond
