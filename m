Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030669AbVIBDwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030669AbVIBDwk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 23:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030670AbVIBDwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 23:52:40 -0400
Received: from pat.uio.no ([129.240.130.16]:33197 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030669AbVIBDwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 23:52:40 -0400
Subject: Re: Change in NFS client behavior
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml-z@robsims.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050901204520.58f07230.akpm@osdl.org>
References: <20050831145545.GA8426@robsims.com>
	 <1125617897.7627.14.camel@lade.trondhjem.org>
	 <1125632597.8635.9.camel@lade.trondhjem.org>
	 <20050901204520.58f07230.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 01 Sep 2005 23:52:25 -0400
Message-Id: <1125633145.8635.11.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.599, required 12,
	autolearn=disabled, AWL 2.21, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 01.09.2005 Klokka 20:45 (-0700) skreiv Andrew Morton:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> >
> >  +static inline int do_posix_truncate(struct dentry *dentry, loff_t length)
> >  +{
> >  +	/* In SuS/Posix lore, truncate to the current file size is a no-op */
> >  +	if (length == i_size_read(dentry->d_inode))
> >  +		return 0;
> >  +	return do_truncate(dentry, length);
> >  +}
> 
> We have the same optimisation in inode_setattr()...

Look again. The two are NOT the same.

The code in inode_setattr() will cause truncate() to erroneously update
the ctime/mtime.

Cheers,
  Trond

