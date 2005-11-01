Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbVKAAkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbVKAAkh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 19:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVKAAkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 19:40:37 -0500
Received: from pat.uio.no ([129.240.130.16]:17919 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751353AbVKAAkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 19:40:36 -0500
Subject: Re: [PATCH against 2.6.14] truncate() or ftruncate shouldn't
	change mtime if size doesn't change.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <17254.41056.197429.949418@cse.unsw.edu.au>
References: <20051031173358.9566.patches@notabene>
	 <1051031063444.9586@suse.de> <1130763105.8802.23.camel@lade.trondhjem.org>
	 <17254.41056.197429.949418@cse.unsw.edu.au>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 19:40:19 -0500
Message-Id: <1130805619.8812.24.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.69, required 12,
	autolearn=disabled, AWL 1.12, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 09:53 +1100, Neil Brown wrote:
> On Monday October 31, trond.myklebust@fys.uio.no wrote:
> > 
> > What we can, however, do is to ensure that truncate() and ftruncate()
> > only set ATTR_SIZE, but ensure that may_open() sets ATTR_MTIME|
> > ATTR_CTIME as well.
> 
> Thanks.  This makes lots of sense, in that it gives power to the
> filesystem.  We should keep the optimisations in placed where the
> filesystem can over-ride them, just as inode_setattr.
> 
> So, here is a revised patch.
> Comment?

Just one. Don't most of the inode->i_op->truncate() methods on local
filesystems call mark_inode_dirty()?
If so, then the call at the end of inode_setattr() will be superfluous
for the case where ia_valid==ATTR_SIZE, since vmtruncate() will dirty
the inode for us.

Otherwise, this patch looks great!

Cheers,
  Trond

