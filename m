Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWG3EW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWG3EW0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 00:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWG3EW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 00:22:26 -0400
Received: from pat.uio.no ([129.240.10.4]:51345 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751105AbWG3EW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 00:22:26 -0400
Subject: Re: [PATCH for 2.6.18] [8/8] MM: Remove rogue readahead printk
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Nate Diller <nate.diller@gmail.com>
Cc: Andi Kleen <ak@suse.de>, torvalds@osdl.org, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <5c49b0ed0607291804j28193807t83d8237cad8d5ecd@mail.gmail.com>
References: <44cbba3f.mPUieUe31/EOZ6FZ%ak@suse.de>
	 <1154207668.5784.35.camel@localhost>
	 <5c49b0ed0607291804j28193807t83d8237cad8d5ecd@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 30 Jul 2006 00:22:14 -0400
Message-Id: <1154233334.5784.93.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.75, required 12,
	autolearn=disabled, AWL 1.25, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-29 at 18:04 -0700, Nate Diller wrote:
> On 7/29/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > On Sat, 2006-07-29 at 21:42 +0200, Andi Kleen wrote:
> > > For some reason it triggers always with NFS root and spams the kernel
> > > logs of my nfs root boxes a lot.
> > >
> > > Cc: trond.myklebust@fys.uio.no
> > > Signed-off-by: Andi Kleen <ak@suse.de>
> >
> > Big ACK! I never really understood why we needed this printk, and yes,
> > it does spam the syslog heavily on all NFS clients...
> 
> not an NFS user, but it seems like this is indicating an actual
> performance problem.  the printk was introduced by an attempt to
> reduce retries after -EIO on scratched CDs/DVDs, and is intended to
> curb pathological behavior when one disk sector consitently cannot be
> read.
>
> for some reason (maybe just busy networks, dunno), you're getting I/O
> errors on NFS, and the readahead window is being reduced.  IMO, the
> proper behavior in this case would be to keep it large, or even
> increase it, since that would enable the network to more efficiently
> transfer data.
> 
> of course, it could be that some quirk of the NFS client VFS interface
> causes "spurious" -EIO returns.  either way, i'd rather see it fixed
> rather than the printk removed, since it is useful to point out that
> some performance degradation is occuring.

We have no way of telling. That printk doesn't give us any useful
information whatsoever for debugging that sort of problem. It should
either be replaced with something that does, or it should be thrown out.

  Trond

