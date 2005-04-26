Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVDZLv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVDZLv0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 07:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVDZLv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 07:51:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:19170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261472AbVDZLvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 07:51:20 -0400
Date: Tue, 26 Apr 2005 04:50:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] __block_write_full_page bug
Message-Id: <20050426045039.702d9075.akpm@osdl.org>
In-Reply-To: <426C6A63.80408@yahoo.com.au>
References: <426C6A63.80408@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>  When running
>  	fsstress -v -d $DIR/tmp -n 1000 -p 1000 -l 2
>  on an ext2 filesystem with 1024 byte block size, on SMP i386 with 4096 byte
>  page size over loopback to an image file on a tmpfs filesystem, I would
>  very quickly hit
>  	BUG_ON(!buffer_async_write(bh));
>  in fs/buffer.c:end_buffer_async_write
> 
>  It seems that more than one request would be submitted for a given bh
>  at a time. __block_write_full_page looks like the culprit - with the
>  following patch things are very stable.

What's the bug?  I don't see it.

Was an ENOSPC involved?

Those tests for buffer_async_write(bh) are redundant now, aren't they?
