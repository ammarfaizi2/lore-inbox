Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265026AbUELNht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265026AbUELNht (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 09:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUELNe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 09:34:59 -0400
Received: from radius8.csd.net ([204.151.43.208]:24218 "EHLO
	bastille.tuells.org") by vger.kernel.org with ESMTP id S265048AbUELNdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 09:33:21 -0400
Date: Wed, 12 May 2004 07:33:29 -0600
From: marcus hall <marcus@tuells.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Block device swamping disk cache
Message-ID: <20040512133329.GA20030@bastille.tuells.org>
References: <20040511191124.GA16014@bastille.tuells.org> <20040511201936.A19384@infradead.org> <20040511172643.36df7c94.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511172643.36df7c94.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 05:26:43PM -0700, Andrew Morton wrote:
> no, sorry, it'll still happen.  I haven't fixed the ramdisk driver yet.
> 
> The problem is that ->memory_backed means both "doesn't contribute
> to dirty memory" and also "doesn't need writeback".
> 
> These concepts need to be split apart for the ramdisk driver.  I'll do it
> for 2.6.7, promise.

Well, I believe that the inodes that are marked as memory_backed are
for the ramdisk, and that isn't really a problem.  The block device
that I am writing to is a compact flash, so it's going through the ide-disk
device.  I do not see this inode show up on any superblock's dirty queue
(since it doesn't appear that mark_inode_dirty() is being called for
it).  So the question I am asking is, what strategy is *supposed* to be
in place to flush the blocks out?  (Or is this a hole that isn't plugged?)

Marcus Hall
marcus@tuells.org
