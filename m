Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030930AbWKOTYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030930AbWKOTYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030931AbWKOTYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:24:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4288 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030922AbWKOTYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:24:40 -0500
Date: Wed, 15 Nov 2006 11:24:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Charles Edward Lever <chucklever@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Yet another borken page_count() check in
 invalidate_inode_pages2()....
Message-Id: <20061115112426.84e5417c.akpm@osdl.org>
In-Reply-To: <1163613913.5691.215.camel@lade.trondhjem.org>
References: <1163568819.5645.8.camel@lade.trondhjem.org>
	<1163596689.5691.40.camel@lade.trondhjem.org>
	<20061115084641.827494be.akpm@osdl.org>
	<1163613913.5691.215.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 13:05:13 -0500
Trond Myklebust <Trond.Myklebust@netapp.com> wrote:

> On Wed, 2006-11-15 at 08:46 -0800, Andrew Morton wrote:
> 
> > but nobody could have started another writeback after the "..." because they
> > couldn't have got the lock_page(), and lock_page() is required for
> > ->writepage()?
> 
> Nothing can have called writepage(), but something may be calling
> ->writepages(). That may call set_page_writeback without taking the page
> lock.
> 

The protocol is

	lock_page()
	set_page_writeback()
	->writepage()

and there are various places which assume that nobody will start new
writeout of a locked page.  But I forget where they are - things have always
been this way.

If NFS is running set_page_writeback() against an unlocked page then I
don't know what will break.  I didn't know it was doing that.

