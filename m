Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUEJWrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUEJWrL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUEJWpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:45:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:52913 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262459AbUEJWof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:44:35 -0400
Date: Mon, 10 May 2004 15:47:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-Id: <20040510154706.6291e264.akpm@osdl.org>
In-Reply-To: <20040510232038.A8331@infradead.org>
References: <20040510024506.1a9023b6.akpm@osdl.org>
	<20040510223755.A7773@infradead.org>
	<20040510150203.3257ccac.akpm@osdl.org>
	<20040510230558.A8159@infradead.org>
	<20040510151554.49965f1d.akpm@osdl.org>
	<20040510232038.A8331@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, May 10, 2004 at 03:15:54PM -0700, Andrew Morton wrote:
> > It beats the alternatives which are floating about, which includes a sysctl
> > which defeats CAP_SYS_MLOCK system-wide.
> 
> That one might not be nice, but at least it doesn't randomly change
> the meaning of a group id.

If you don't set the sysctl there is no change in system behaviour.

> So yeah, although it's a hack too it's
> much much better than the junk that just went into Linus tree.

Untrue.  With the system-wide thing unprivileged local users can
trivially DoS the database.
 
> Why btw do we have a staging tree if such sensitive patches go into
> mainline without proper review after just one day?

It was discussed on lkml, then later was dicussed extensively off-list
and I lost track of how long it had been in -mm.  Sorry.

> > >  What happened to the patch rick promised
> > > to make mlock an rlimit?  This is the right approach and could be easily
> > > extended to hugetlb pages.
> > 
> > rlimits don't work for this.  shm segments persist after process exit and
> > aren't associated with a particular user.
> 
> When did shm segments come into the play?  I know we bolted hugetlb
> support onto the back of the already horrible sysv shm interface, but
> if people want additional interfaces ontop of that they should use
> the proper mmap api.

Rewriting Oracle isn't a practical alternative.
