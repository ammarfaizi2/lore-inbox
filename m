Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265199AbUFROXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265199AbUFROXX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 10:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUFROXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 10:23:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49821 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265199AbUFROWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 10:22:09 -0400
Date: Fri, 18 Jun 2004 15:22:07 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Chris Mason <mason@suse.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] __bd_forget should wait for inodes using the mapping
Message-ID: <20040618142207.GW12308@parcelfarce.linux.theplanet.co.uk>
References: <1087523668.8002.103.camel@watt.suse.com> <20040618021043.GV12308@parcelfarce.linux.theplanet.co.uk> <1087563810.8002.116.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087563810.8002.116.camel@watt.suse.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 09:03:31AM -0400, Chris Mason wrote:
> sync_sb_inodes, the filesystem block device inode ends up on some dirty
> list, and under memory pressure balance_dirty_pages_ratelimited will
> trigger writeback on it.  
> 
> There's nothing to write back of course, the real block device address
> space has no dirty pages at all.  But, writeback is looking through the
> mapping and __bd_forget can't drop it until writeback has finished
> checking it.

So WTF does writeback bother with that?  _That_ is the real bug here -
the only kind of bdev inodes that can have accesses to ->i_mapping
is fs/block_dev.c-created stuff.
