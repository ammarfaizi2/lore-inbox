Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263565AbUD2FaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbUD2FaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 01:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUD2FaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 01:30:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:9649 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263565AbUD2FaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 01:30:10 -0400
Date: Wed, 28 Apr 2004 22:29:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: busterbcook@yahoo.com, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
Message-Id: <20040428222950.6406a9f0.akpm@osdl.org>
In-Reply-To: <20040428214741.7d5b3ae1.akpm@osdl.org>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
	<20040427230203.1e4693ac.akpm@osdl.org>
	<Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
	<20040428124809.418e005d.akpm@osdl.org>
	<Pine.LNX.4.58.0404281534110.3044@ozma.hauschen>
	<20040428182443.6747e34b.akpm@osdl.org>
	<Pine.LNX.4.58.0404282244280.13311@ozma.hauschen>
	<20040428210214.31efe911.akpm@osdl.org>
	<Pine.LNX.4.58.0404282330390.13783@ozma.hauschen>
	<20040428214741.7d5b3ae1.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Now, that redirtying of the inode _should_ have moved the inode off the
>  s_io list and onto the s_dirty list.  But for some reason it looks like it
>  didn't, so we get stuck in a loop.  I need to think about it a bit more.

OK, it looks like nfs_writepages() might have been encountered the
congested flag and it baled out without doing anything - the inode is still
on the temporary s_io list, and no pages were redirtied, hence the inode
wasn't redirtied, hence it remains stuck on the s_io list.  The patch I
sent will fix that up.

