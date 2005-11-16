Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbVKPTKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbVKPTKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbVKPTKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:10:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56767 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751493AbVKPTKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:10:02 -0500
Date: Wed, 16 Nov 2005 11:09:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: mmap over nfs leads to excessive system load
Message-Id: <20051116110938.1bf54339.akpm@osdl.org>
In-Reply-To: <1132166062.8811.30.camel@lade.trondhjem.org>
References: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
	<1132163057.8811.15.camel@lade.trondhjem.org>
	<20051116100053.44d81ae2.akpm@osdl.org>
	<1132166062.8811.30.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> On Wed, 2005-11-16 at 10:00 -0800, Andrew Morton wrote:
> 
> > That will fix it, but the PageWriteback accounting is still wrong.
> > 
> > Is it not possible to use set_page_writeback()/end_page_writeback()?
> 
> Not really. The pages aren't flushed at this time. We the point is to
> gather several pages and coalesce them into one over-the-wire RPC call.
> That means we cannot really do it from inside ->writepage().
> 

I still don't get it.

Once nfs_writepage() has been called, the page is conceptually "under
writeback", yes?  In that, at some point in the future, it will be written
to backing store.

Hence it's perfectly appropriate to run set_page_writepage() within
nfs_writepage().  It's a matter of finding the right place for the
end_page_writeback().

