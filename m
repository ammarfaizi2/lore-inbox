Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbUCVUdz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 15:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUCVUdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 15:33:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:15518 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262413AbUCVUdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 15:33:54 -0500
Date: Mon, 22 Mar 2004 12:33:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: VMA_MERGING_FIXUP and patch
Message-Id: <20040322123352.660a2edc.akpm@osdl.org>
In-Reply-To: <20040322200505.GB22639@dualathlon.random>
References: <Pine.LNX.4.44.0403221640230.11645-100000@localhost.localdomain>
	<20040322115734.064f24f4.akpm@osdl.org>
	<20040322200505.GB22639@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Mon, Mar 22, 2004 at 11:57:34AM -0800, Andrew Morton wrote:
> > set_page_dirty() takes ->tree_lock and inode_lock.  tree_lock surely is OK
> > and while I cannot think of any deadlocks which could occur with taking
> > inode_lock inside the rmap lock, it doesn't sound very nice.
> > 
> > It would of course be best if we could avoid adding a new ranking
> > relationship between these locks.
> 
> agreed. the inode_lock especially is more a vfs thing than a mm thing,
> so it lives quite far away.

Alas, inode_lock can be taken inside page_table_lock, in zap_pte_range().
That set_page_dirty() in there is the nastiest part of the MM locking.

