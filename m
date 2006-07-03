Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWGCOGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWGCOGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 10:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWGCOGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 10:06:12 -0400
Received: from thunk.org ([69.25.196.29]:14555 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751056AbWGCOGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 10:06:11 -0400
Date: Mon, 3 Jul 2006 10:05:52 -0400
From: Theodore Tso <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 6/8] inode-diet: Move i_cindex from struct inode to struct file
Message-ID: <20060703140552.GB8099@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060703005333.706556000@candygram.thunk.org> <20060703010023.430751000@candygram.thunk.org> <20060703090532.GA8242@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703090532.GA8242@infradead.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 10:05:32AM +0100, Christoph Hellwig wrote:
> On Sun, Jul 02, 2006 at 08:53:39PM -0400, Theodore Ts'o wrote:
> > inode.i_cindex isn't initialized until the character device is opened
> > anyway, and there are far more struct inodes in memory than there are
> > struct file.  So move the cindex field to file.f_cindex, and change
> > the one(!) user of cindex to use file pointer, which is in fact simpler.
> 
> I think you got a pretty clear NACK from Al on this one.
> 

I explained my reasoning to him --- that inode.i_cindex isn't
initialized until after the VFS-specific char-open is called, so you
can never depend on index.i_cindex being valid except in char device
driver's open method --- and that function gets passed a file pointer
as well as an index pointer.  So the clean up that Al wants to do can
just as easily be done by having the device drivers use file->f_cindex
instead of inode->i_cindex.

						- Ted
