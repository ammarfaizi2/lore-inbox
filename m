Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbVKOCD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVKOCD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 21:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVKOCD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 21:03:26 -0500
Received: from pat.uio.no ([129.240.130.16]:54657 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932270AbVKOCDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 21:03:25 -0500
Subject: Re: [PATCH ] Fix some problems with truncate and mtime semantics.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1051115020002.9459@suse.de>
References: <20051115125657.9403.patches@notabene>
	 <1051115020002.9459@suse.de>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 21:03:10 -0500
Message-Id: <1132020190.8802.28.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.866, required 12,
	autolearn=disabled, AWL 1.95, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 13:00 +1100, NeilBrown wrote:
> Resubmitting this patch to fix truncate/mtime semantics.  
> 
> It is against 2.6.14-mm2 and is probably suitable for 2.6.15, but can
> be held over to 2.6.16 if you are feeling cautious.
> 
> NeilBrown
> 
> ### Comments for Changeset
> 
> SUS requires that when truncating a file to the size that it currently
> is:
>   truncate and ftruncate should NOT modify ctime or mtime
>   O_EXCL SHOULD modify ctime and mtime.
    ^^^^^ O_CREAT ;-)

> Currently mtime and ctime are always modified on most local
> filesystems (side effect of ->truncate) or never modified (on NFS).
> 
> With this patch:
>   ATTR_CTIME|ATTR_MTIME are sent with ATTR_SIZE precisely when 
>     an update of these times is required whether size changes or not 
>     (via a new argument to do_truncate).  This allows NFS to do
>     the right thing for O_EXCL.
                          ^^^^^

Cheers,
  Trond

