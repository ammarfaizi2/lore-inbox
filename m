Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266018AbUFVUuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266018AbUFVUuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266021AbUFVUtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:49:35 -0400
Received: from cantor.suse.de ([195.135.220.2]:60128 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266018AbUFVUlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:41:03 -0400
Subject: Re: deadlocks caused by ext3/reiser dirty_inode calls during
	do_mmap_pgoff
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040622120540.1bc8b6e3.akpm@osdl.org>
References: <1087837153.1512.176.camel@watt.suse.com>
	 <20040621171337.44d1b636.akpm@osdl.org>
	 <1087915399.1512.267.camel@watt.suse.com>
	 <20040622120540.1bc8b6e3.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1087936915.1512.284.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 16:41:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-22 at 15:05, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:

> > Oh, just realized this will break our data=ordered setup.  prepare_write
> > is going to do things like allocating blocks in the file etc etc.  If we
> > close the transaction via commit_write(0 size) and crash, we'll leak.
> 
> OK, then just zero the pagecache page between `from' and `to' and call
> ->commit_write() with unmodified `from' and `to'?
> 
> > We might need to do prefault + pin on the user pages.
> 
> That's always been the correct way to fix these problems, but it involves a
> pagetable walk, which requires page_table_lock.  Not a popular thing to be
> doing on the write() fastpath.

Fair enough, zeroing between from and to should do it.

-chris


