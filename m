Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265247AbUFRPnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbUFRPnb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUFRPnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:43:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:1439 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265255AbUFRPk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:40:59 -0400
Subject: Re: [PATCH RFC] __bd_forget should wait for inodes using the
	mapping
From: Chris Mason <mason@suse.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040618151558.GX12308@parcelfarce.linux.theplanet.co.uk>
References: <1087523668.8002.103.camel@watt.suse.com>
	 <20040618021043.GV12308@parcelfarce.linux.theplanet.co.uk>
	 <1087563810.8002.116.camel@watt.suse.com>
	 <20040618142207.GW12308@parcelfarce.linux.theplanet.co.uk>
	 <1087570031.8002.153.camel@watt.suse.com>
	 <20040618151558.GX12308@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1087573303.8002.172.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 11:41:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 11:15, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Fri, Jun 18, 2004 at 10:47:11AM -0400, Chris Mason wrote:
> > During writeback, we need to answer the question: "are there dirty pages
> > attached to this inode", and the only way to answer it is via the
> > address space.
> > 
> > If bdev inodes don't want other inodes using their address space, they
> > shouldn't be setting the i_mapping on other inodes.  Since they are, the
> > bdev code needs to be aware that someone else might be using it.
> 
> Scheduled for 2.7.1; for now users of ->i_mapping (the fewer of them remain,
> the better) have to be aware of bdev.
> 
> And yes, ->i_mapping flips on "normal" bdev inodes will go away - we set
> ->f_mapping on open directly.

Fair enough, I'll cook up some code to bump the inode->bdev->bd_inode
i_count in __sync_single_inode  It won't be pretty either though, I'll
have to drop the inode_lock so that some function can take the bdev_lock
to safely use inode->i_bdev.

-chris


