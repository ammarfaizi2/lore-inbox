Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUCVT5g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUCVT5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:57:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:2439 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262353AbUCVT5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:57:35 -0500
Date: Mon, 22 Mar 2004 11:57:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: VMA_MERGING_FIXUP and patch
Message-Id: <20040322115734.064f24f4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0403221640230.11645-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0403221640230.11645-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> Hmm, I wonder, is that safe to be calling set_page_dirty
>  from inside the page rmap lock?  Andrew?

set_page_dirty() takes ->tree_lock and inode_lock.  tree_lock surely is OK
and while I cannot think of any deadlocks which could occur with taking
inode_lock inside the rmap lock, it doesn't sound very nice.

It would of course be best if we could avoid adding a new ranking
relationship between these locks.
