Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755911AbWKTLHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911AbWKTLHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 06:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755924AbWKTLHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 06:07:52 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:51881 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S1755911AbWKTLHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 06:07:52 -0500
Date: Mon, 20 Nov 2006 12:07:50 +0100
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: NFSROOT with NFS Version 3
Message-Id: <20061120120750.1b1688e8.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <1163780417.5709.34.camel@lade.trondhjem.org>
References: <20061117164021.03b2cc24.Christoph.Pleger@uni-dortmund.de>
	<1163780417.5709.34.camel@lade.trondhjem.org>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; sparc-sun-solaris2.8)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 17 Nov 2006 11:20:17 -0500
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> On Fri, 2006-11-17 at 16:40 +0100, Christoph Pleger wrote:
> > Hello,
> > 
> > I tried to switch an NFSROOT-Environment from NFS version 2 to NFS
> > version 3, but unfortunately my test client machine now hangs every
> > time after booting as soon as some bigger file system activity
> > should occur. I tried Kernel 2.6.14.7 and Kernel 2.6.16.32.
> > 
> > The problem did not occur with NFS version 2.
> > 
> > Does anybody know the problem and/or a solution?
> 
> That is almost always due to the difference in r/wsize that the Linux
> NFS server advertises for v2 and v3 combined with using UDP. If you
> have poor networking, then don't use UDP, and certainly not with 32k
> r/wsize.
> 
> IOW: try either setting the mount options "rsize=8192,wsize=8192", or
> the option "proto=tcp"

No, that was not the problem. I tried it, bit it did not help.

Later, I noticed the following message that appeared during the boot
process:

Warning: Unable to open an initial console

So, on the NFS server, I made a copy of the NFSROOT-Directory, exported
the copy read-write (the original is exported read-only) and used the
copy as NFSROOT for the client. And now the client works well.

But now I have two questions:

1. Why did the problem not occur with NFS version 2? On the client,
/dev/console should have been read-only with version 2 as well.
2. What can I do to get a "real" solution? Exporting the original
NFSROOT read-write is not possible for me.

Regards
  Christoph Pleger
