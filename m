Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265309AbUFHUST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265309AbUFHUST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 16:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265310AbUFHUST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 16:18:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:52377 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265309AbUFHUSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 16:18:17 -0400
Subject: Re: [PATCH] writeback_inodes can race with unmount
From: Chris Mason <mason@suse.com>
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <40C61A20.4000906@kolumbus.fi>
References: <1086722523.10973.157.camel@watt.suse.com>
	 <40C61A20.4000906@kolumbus.fi>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1086725926.10973.161.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 08 Jun 2004 16:18:47 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-08 at 15:57, Mika Penttilä wrote:
> Chris Mason wrote:
> 
> >There's a small window where the filesystem can be unmounted during
> >writeback_inodes.  The end result is the iput done by sync_sb_inodes
> >could be done after the FS put_super and and the super has been removed
> >from all lists.
> >  
> >
> 
> Why don't we have the same race in the sync() path as well? Moving the 
> locking to sync_sb_inodes() itself would fix it also.

In the sync() path we're already taking a read lock on s_umount sem. 
Moving the locking into sync_sb_inodes would be tricky, it is sometimes
called with the write lock on s_umount_sem held and sometimes with a
read lock.

-chris


