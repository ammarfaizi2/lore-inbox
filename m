Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264184AbUD0PsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264184AbUD0PsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 11:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264191AbUD0PsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 11:48:05 -0400
Received: from ns.suse.de ([195.135.220.2]:50361 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264184AbUD0PsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 11:48:02 -0400
Subject: Re: [PATCH 6/11] nfsacl-lazy-alloc
From: Andreas Gruenbacher <agruen@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1083011918.15282.24.camel@lade.trondhjem.org>
References: <1082975192.3295.76.camel@winden.suse.de>
	 <1083011918.15282.24.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1083080881.19655.151.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 27 Apr 2004 17:48:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-26 at 22:38, Trond Myklebust wrote:
> On Mon, 2004-04-26 at 06:28, Andreas Gruenbacher wrote:
> > Allow to allocate pages in the receive buffers lazily
> > 
> > Patch from Olaf Kirch <okir@suse.de>: Replies to the GETACL remote
> > procedure call can become quite big, yet in the common case replies will
> > be very small.  This patch checks of argument pages have already been
> > allocated, and allocates pages up to the maximum length of the xdr_buf
> > when this is not the case.
> 
> AFAICS, there is nothing to stop xdr_partial_copy_from_skb() from
> writing beyond the end of xdr->pages[]. How do you propose to prevent
> this?

xdr->page_len determines the maximum length. The pages array must
contain enough entries to hold that many pages; this is no different
from pre-allocating the pages.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

