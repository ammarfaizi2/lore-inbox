Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbUEJXUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUEJXUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUEJXTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:19:39 -0400
Received: from waste.org ([209.173.204.2]:11497 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262961AbUEJXQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:16:54 -0400
Date: Mon, 10 May 2004 18:16:27 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040510231627.GN5414@waste.org>
References: <20040510024506.1a9023b6.akpm@osdl.org> <20040510223755.A7773@infradead.org> <20040510150203.3257ccac.akpm@osdl.org> <20040510230558.A8159@infradead.org> <20040510151554.49965f1d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510151554.49965f1d.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 03:15:54PM -0700, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > > Capabilities are broken and don't work.  Nobody has a clue how to provide
> > > the required services with SELinux and nobody has any code and we need the
> > > feature *now* before vendors go shipping even more ghastly stuff.
> > 
> > The thing is special privilegues for a group don't fit into any of the
> > various privilegues schemes we have (capabilities, selinux, etc..),
> > it's really a horrible hack.
> 
> It beats the alternatives which are floating about, which includes a sysctl
> which defeats CAP_SYS_MLOCK system-wide.
> 
> >  What happened to the patch rick promised
> > to make mlock an rlimit?  This is the right approach and could be easily
> > extended to hugetlb pages.
> 
> rlimits don't work for this.  shm segments persist after process exit and
> aren't associated with a particular user.

The answer here is probably to make quotas work for shmfs, tmpfs,
hugetlbfs, etc. This shouldn't be too bad except for quotactl(2)
insists on having a block special device to manipulate quotas. Adding
an fquotactl(file descriptor, ...) should deal with that.

The mlock rlimits probably still make sense even once this is in place.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
