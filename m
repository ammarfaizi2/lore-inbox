Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266622AbUFWTaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUFWTaK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 15:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266620AbUFWTaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 15:30:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:36801 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266622AbUFWT3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 15:29:32 -0400
Date: Wed, 23 Jun 2004 12:29:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make POSIX locks compatible with the NPTL thread model
Message-ID: <20040623122930.K22989@build.pdx.osdl.net>
References: <1088010468.5806.52.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1088010468.5806.52.camel@lade.trondhjem.org>; from trond.myklebust@fys.uio.no on Wed, Jun 23, 2004 at 01:07:49PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Trond Myklebust (trond.myklebust@fys.uio.no) wrote:
> At some point in 2.5.x we introduced the NPTL thread model at the kernel
> level, and hence redefined the idea of a process: a process appears
> currently to be defined as one or more threads with the same tgid...
> However we failed to completely update the POSIX locking code to reflect
> that change: currently, the POSIX locking code defines the process to be
> a set of one or more threads with the same tgid and a shared file
> table...
> 
> As a result we end up with abominations like the steal_locks() function
> that is required in order to move the locks from from one file table to
> another on exec etc.

Just ran some quick tests to verify this patch still works fine with
execve() after plain CLONE_FILES as well as full CLONE_THREAD.  Passed
my tests.  Nice to see the steal_locks bit go.  However, without this
patch (only the prior one, I'm getting an oops).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
