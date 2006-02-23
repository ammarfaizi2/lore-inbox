Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWBWE66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWBWE66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 23:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWBWE66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 23:58:58 -0500
Received: from thunk.org ([69.25.196.29]:34507 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750933AbWBWE65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 23:58:57 -0500
Date: Wed, 22 Feb 2006 23:58:36 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: question about possibility of data loss in Ext2/3 file system
Message-ID: <20060223045836.GC9645@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Xin Zhao <uszhaoxin@gmail.com>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <4ae3c140602221356x15015171h5aa4a3d7bb6034e0@mail.gmail.com> <1140645651.2979.79.camel@laptopd505.fenrus.org> <4ae3c140602221434v6ec583a7yf04df5fa7a4948fc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140602221434v6ec583a7yf04df5fa7a4948fc@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 05:34:33PM -0500, Xin Zhao wrote:
> Apparently the scheme you described helps improve the file integrity.
> But still not good enough. For example, if all data blocks are
> flushed, then you will update the metadata. But right after you update
> the block bitmap and before you update the inode, you lose power. You
> will get some dead blocks.  Right? Do you know how ext2/3 deal with
> this situation?

Ext3 uses the journal to guarantee that the bitmap blocks are
consistent with the inode.  Ext2 will require that e2fsck be run to
fix the consistency problem.

> Also, the scheme you mentioned is just for new file creation. What
> will happen if I want to update an existing file? Say, I open file A,
> seek to offset 5000, write 4096 bytes, and then close. Do you know how
> ext2/3 handle this situation?

If you have a power failure right after the close, the data could be
lost.  This is true for pretty much all Unix filesystems, for
performance reasons.  If you care about the data hitting disk, the
application must use fsync().  

Regards,

						- Ted
