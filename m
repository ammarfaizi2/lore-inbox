Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbUDBBel (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUDBBel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:34:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:44170 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263502AbUDBBej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:34:39 -0500
Date: Thu, 1 Apr 2004 17:36:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap
 complexity fix
Message-Id: <20040401173649.22f734cd.akpm@osdl.org>
In-Reply-To: <20040402011627.GK18585@dualathlon.random>
References: <20040402001535.GG18585@dualathlon.random>
	<Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain>
	<20040402011627.GK18585@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> > it isn't doing anything useful for rw_swap_page_sync, just getting you
> > into memory allocation difficulties.  No need for add_to_page_cache or
> > add_to_swap_cache there at all.  As I say, I haven't tested this path,
> 
> I wouldn't need to call add_to_page_cache either, it's just Andrew
> prefers it.

Well all of this is to avoid a fairly arbitrary BUG_ON in the radix-tree
code.  If I hadn't added that, we'd all be happy.

The code is well-tested and has been thrashed to death in the userspace
radix-tree test harness.
(http://www.zip.com.au/~akpm/linux/patches/stuff/rtth.tar.gz).  Let's
remove the BUG_ON.
