Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVAaVIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVAaVIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 16:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVAaVFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 16:05:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:27036 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261367AbVAaVBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 16:01:09 -0500
Date: Mon, 31 Jan 2005 13:01:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: timur.tabi@ammasso.com, roland@topspin.com
Subject: Re: Correct way to release get_user_pages()?
Message-Id: <20050131130104.4ac732e5.akpm@osdl.org>
In-Reply-To: <41FE53EA.4010101@ammasso.com>
References: <52pszqw917.fsf@topspin.com>
	<41FA7AE2.10209@ammasso.com>
	<20050130021017.7ef1c764.akpm@osdl.org>
	<41FE53EA.4010101@ammasso.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi <timur.tabi@ammasso.com> wrote:
>
> Andrew Morton wrote:
> 
> > no...  You should only dirty the page if it was modified, and then use
> > set_page_dirty() or set_page_dirty_lock().
> 
> If the page was modified, then shouldn't it already be marked dirty?

If the page is modified by a DMA transfer or by the CPU via the kernel's
page mappings then there is no record of its having been altered.  Which is
why we must do it in software.

> Also, should I always use set_page_dirty_lock() if I haven't already 
> locked the page?

If you don't have a reference on the page's inode, yes, you should use
set_page_dirty_lock().  If the page came from get_user_pages() then surely
you don't have a ref on the inode.
