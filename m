Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWG3QMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWG3QMf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWG3QMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:12:35 -0400
Received: from pat.uio.no ([129.240.10.4]:56784 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932343AbWG3QMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:12:35 -0400
Subject: Re: [PATCH for 2.6.18] [8/8] MM: Remove rogue readahead printk
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: nate.diller@gmail.com, ak@suse.de, torvalds@osdl.org, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060729232625.c8bcac66.akpm@osdl.org>
References: <44cbba3f.mPUieUe31/EOZ6FZ%ak@suse.de>
	 <1154207668.5784.35.camel@localhost>
	 <5c49b0ed0607291804j28193807t83d8237cad8d5ecd@mail.gmail.com>
	 <1154233334.5784.93.camel@localhost>
	 <20060729232625.c8bcac66.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 30 Jul 2006 12:12:21 -0400
Message-Id: <1154275941.5784.131.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.279, required 12,
	autolearn=disabled, AWL 0.21, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-29 at 23:26 -0700, Andrew Morton wrote:
> On Sun, 30 Jul 2006 00:22:14 -0400
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > > of course, it could be that some quirk of the NFS client VFS interface
> > > causes "spurious" -EIO returns.  either way, i'd rather see it fixed
> > > rather than the printk removed, since it is useful to point out that
> > > some performance degradation is occuring.
> > 
> > We have no way of telling. That printk doesn't give us any useful
> > information whatsoever for debugging that sort of problem. It should
> > either be replaced with something that does, or it should be thrown out.
> 
> err, the printk has found a probable bug in NFS.  That was pretty useful
> of it.

Not necessarily. AFAICS, the spam could be triggered by perfectly
legitimate activity. For instance, someone on the server may have
revoked your read permissions to the file, or may have deleted it.

> Do we know why nfs's readpage isn't bringing the page up to date?

It may be that other lurking issues were also triggering the printk. For
instance I know of a couple of corner cases in the krb5 privacy code
that could result in readpage failing. Those issues are being looked
into.

Cheers,
  Trond

