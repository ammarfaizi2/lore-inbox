Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266022AbUBQFie (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 00:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbUBQFie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 00:38:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:52890 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266022AbUBQFic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 00:38:32 -0500
Date: Mon, 16 Feb 2004 21:38:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, Linux-MM@kvack.org
Subject: Re: [PATCH] mremap NULL pointer dereference fix
In-Reply-To: <Pine.SOL.4.44.0402162331580.20215-100000@blue.engin.umich.edu>
Message-ID: <Pine.LNX.4.58.0402162127220.30742@home.osdl.org>
References: <Pine.SOL.4.44.0402162331580.20215-100000@blue.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Feb 2004, Rajesh Venkatasubramanian wrote:
> 
> This path fixes a NULL pointer dereference bug in mremap. In
> move_one_page we need to re-check the src because an allocation
> for the dst page table can drop page_table_lock, and somebody
> else can invalidate the src.

Ugly, but yes. The "!page_table_present(mm, new_addr))" code just before
the "alloc_one_pte_map()" should already have done this, but while the 
page tables themselves are safe due to us holding the mm semaphore, the 
pte entry itself at "src" is not.

I hate that code, and your patch makes it even uglier. This code could do 
with a real clean-up, but for now I think your patch will do.

Thanks,

		Linus
