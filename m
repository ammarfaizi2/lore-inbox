Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbUERBEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUERBEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 21:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUERBEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 21:04:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:12196 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261862AbUERBEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 21:04:08 -0400
Date: Mon, 17 May 2004 18:03:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: stock@stokkie.net, linux-kernel@vger.kernel.org
Subject: Re: ramdisk driver in 2.6.6 has a severe bug
Message-Id: <20040517180312.4560e6da.akpm@osdl.org>
In-Reply-To: <20040518005042.GW17014@parcelfarce.linux.theplanet.co.uk>
References: <20040517161943.37d826a3.akpm@osdl.org>
	<Pine.LNX.4.44.0405180132240.21480-100000@hubble.stokkie.net>
	<20040517170433.0311c2e9.akpm@osdl.org>
	<20040518005042.GW17014@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> > Well in that case perhaps something else broke.  I've seen no such reports
>  > of recent regressions in the ramdisk driver.
>  > 
>  > The two problems of which I am aware are:
>  > 
>  > a) It loses its brains across umount.  Seems that it's very rare that
>  >    anyone actually cares about this, which is why it has not been fixed in
>  >    well over a year.
> 
>  Details, please.  The only case I'm aware of is when you have fs-set
>  block size different from the one we had before mount(2).  And in that
>  case it would lose its brains when the blocksize had been flipped in
>  the first place.  Which would tend to fail mount(2) anyway.

Oh, it's nothing to do with that.  Problem is that files backed by ramdisks
are marked "memory backed" so the writeback code doesn't write them to the
ramdisk inode.  So it's presently functioning as ramfs with ext2 metadata
in the blockdev inode.

I'll fix it up.
