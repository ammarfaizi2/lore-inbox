Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751646AbVLFEkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbVLFEkw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 23:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbVLFEkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 23:40:52 -0500
Received: from pat.uio.no ([129.240.130.16]:14584 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751646AbVLFEkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 23:40:51 -0500
Subject: Re: nfs unhappiness with memory pressure
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051206143641.3feadaea.akpm@osdl.org>
References: <20051205210442.17357.qmail@web34106.mail.mud.yahoo.com>
	 <1133822367.8003.5.camel@lade.trondhjem.org>
	 <20051206143641.3feadaea.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 23:40:26 -0500
Message-Id: <1133844026.8007.36.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.071, required 12,
	autolearn=disabled, AWL 1.74, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 14:36 +1100, Andrew Morton wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> >
> > Argh... Not sure entirely how to deal with that... We definitely don't
> >  want the thing futzing around inside throttle_vm_writeout(), 'cos
> >  writeout isn't going to happen while the socket blocks.
> > 
> 
> As far as the core VM is concerned, these pages are really "dirty", only it
> happens to be a different flavour of dirtiness.  So perhaps we should
> continue to mark these pages as dirty and let NFS internally take care
> of which end of the wire they're dirty at.
> 
> Presumably calling writepage() a second time won't be very useful.  Or will
> it?  Perhaps when NFS sees writepage against a PageDirty && PageUnstable
> page it can recognise that as a hint to kick off a server-side write.

Calling writepages() would actually be better. That will do the right
thing, and trigger a commit if there are unstable writes.

Cheers,
  Trond

