Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbUCVUEO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 15:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUCVUEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 15:04:14 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:27847
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262374AbUCVUEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 15:04:13 -0500
Date: Mon, 22 Mar 2004 21:05:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: VMA_MERGING_FIXUP and patch
Message-ID: <20040322200505.GB22639@dualathlon.random>
References: <Pine.LNX.4.44.0403221640230.11645-100000@localhost.localdomain> <20040322115734.064f24f4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322115734.064f24f4.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 11:57:34AM -0800, Andrew Morton wrote:
> set_page_dirty() takes ->tree_lock and inode_lock.  tree_lock surely is OK
> and while I cannot think of any deadlocks which could occur with taking
> inode_lock inside the rmap lock, it doesn't sound very nice.
> 
> It would of course be best if we could avoid adding a new ranking
> relationship between these locks.

agreed. the inode_lock especially is more a vfs thing than a mm thing,
so it lives quite far away. (btw, in my last email I only mentioned
the mapping tree_lock because I was thinking at the swapcache, with
filebacked pagecache and the inode_lock it gets worse, probably still ok
today though)
