Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265931AbUFVUrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbUFVUrG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbUFVUqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:46:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:34776 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265931AbUFVUbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:31:43 -0400
Subject: Re: deadlocks caused by ext3/reiser dirty_inode calls during
	do_mmap_pgoff
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040622115748.396badfe.akpm@osdl.org>
References: <1087837153.1512.176.camel@watt.suse.com>
	 <20040621171337.44d1b636.akpm@osdl.org>
	 <1087913598.1512.264.camel@watt.suse.com>
	 <20040622115748.396badfe.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1087936354.1512.276.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 16:32:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-22 at 14:57, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:
> >
> > Hmmm, reiserfs_file_write does fault_in_pages_readable after the
> >  transaction is started.
> 
> That nests down_read(mmap_sem) inside transaction start, vastly increasing
> the deadlock probability.

Yup

> 
> >  I can at least make the window smaller for now
> >  by moving that before the transaction is started.
> 
> Much smaller.
> 
> We need to decide what the ranking is and stick with it.  I think that's
> "transaction start nests inside mmap_sem", agree?

Agreed.

-chris

