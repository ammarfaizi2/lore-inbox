Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289109AbSAGD7Q>; Sun, 6 Jan 2002 22:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289108AbSAGD7G>; Sun, 6 Jan 2002 22:59:06 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:13408 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289113AbSAGD64>; Sun, 6 Jan 2002 22:58:56 -0500
Date: Mon, 7 Jan 2002 04:58:57 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] truncate fixes
Message-ID: <20020107045857.K1561@athlon.random>
In-Reply-To: <3C36DEA9.AEA2A402@zip.com.au>, <3C36DEA9.AEA2A402@zip.com.au>; <20020107034654.G1561@athlon.random> <3C3911F1.63E55E90@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C3911F1.63E55E90@zip.com.au>; from akpm@zip.com.au on Sun, Jan 06, 2002 at 07:11:45PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 07:11:45PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > I prefer my fix that simply recalls the ->truncate callback if -ENOSPC
> > is returned by prepare_write. vmtruncate seems way overkill,
> 
> Actually, vmtruncate will trim the page off the inode as well as the
> blocks from the file.  I don't think there's necessarily a problem
> with having a page wholly outside i_size, but..

agreed, a truncate_inode_pages before ->truncate is needed, or after an
extension the old bh could be still there mapped to random in the
leftover page. But still the whole vmtruncate looks overkill, there
cannot be vm mappings in the way of our truncate because in
prepare_write we worked after the i_size if truncate will later do
something. pages in the middle if i_size cannot be mapped either, so if
it was a partial write that still couldn't be mapped.

Andrea
