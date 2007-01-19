Return-Path: <linux-kernel-owner+w=401wt.eu-S965034AbXASJgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbXASJgD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 04:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbXASJgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 04:36:03 -0500
Received: from amsfep15-int.chello.nl ([62.179.120.10]:60004 "EHLO
	amsfep15-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S965038AbXASJgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 04:36:00 -0500
Subject: Re: [PATCH] nfs: fix congestion control
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1169135375.6105.15.camel@lade.trondhjem.org>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	 <20070116135325.3441f62b.akpm@osdl.org> <1168985323.5975.53.camel@lappy>
	 <Pine.LNX.4.64.0701171158290.7397@schroedinger.engr.sgi.com>
	 <1169070763.5975.70.camel@lappy>
	 <1169070886.6523.8.camel@lade.trondhjem.org>
	 <1169126868.6197.55.camel@twins>
	 <1169135375.6105.15.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Fri, 19 Jan 2007 10:33:54 +0100
Message-Id: <1169199234.6197.129.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-18 at 10:49 -0500, Trond Myklebust wrote:

> After the dirty page has been written to unstable storage, it marks the
> inode using I_DIRTY_DATASYNC, which should then ensure that the VFS
> calls write_inode() on the next pass through __sync_single_inode.

> I'd rather like to see fs/fs-writeback.c do this correctly (assuming
> that it is incorrect now).

balance_dirty_pages()
  wbc.sync_mode = WB_SYNC_NONE;
  writeback_inodes()
    sync_sb_inodes()
      __writeback_single_inode()
        __sync_single_inode()
          write_inode()
            nfs_write_inode()

Ah, yes, I see. That ought to work.

/me goes verify he didn't mess it up himself...



