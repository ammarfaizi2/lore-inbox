Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbTJIXZS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 19:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTJIXZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 19:25:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:40339 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262669AbTJIXZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 19:25:15 -0400
Date: Thu, 9 Oct 2003 16:24:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <20031009171652.K1593@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.44.0310091619530.20936-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 9 Oct 2003, Andreas Dilger wrote:
> 
> It would be nice if we could know in advance if we are returning values
> for sys_statfs() or sys_statfs64() (e.g. by sys_statfs64() calling an
> optional sb->s_op->statfs64() method if available) so we didn't have to
> do this munging.  We can't just assume 64-bit results, or callers of
> sys_statfs() will get EOVERFLOW instead of slightly innacurate results.

This is something that sys_statfs() could do on its own. It's probably 
always better to try to scale the block size up than to return EOVERFLOW.

(Some things can't be scaled up, of course, like f_ffree etc. But it 
should be trivial to just do a "try to shift to make it fit" in the 
vfs_statfs_native() function in fs/open.c).

		Linus

