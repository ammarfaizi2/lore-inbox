Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVELPTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVELPTA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 11:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVELPS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 11:18:59 -0400
Received: from mail.shareable.org ([81.29.64.88]:45009 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262012AbVELPRM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 11:17:12 -0400
Date: Thu, 12 May 2005 16:16:31 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Ram <linuxram@us.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>,
       7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050512151631.GA16310@mail.shareable.org>
References: <20050511170700.GC2141@mail.shareable.org> <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu> <1115840139.6248.181.camel@localhost> <20050511212810.GD5093@mail.shareable.org> <1115851333.6248.225.camel@localhost> <a4e6962a0505111558337dd903@mail.gmail.com> <20050512010215.GB8457@mail.shareable.org> <a4e6962a05051119181e53634e@mail.gmail.com> <20050512064514.GA12315@mail.shareable.org> <a4e6962a0505120623645c0947@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e6962a0505120623645c0947@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Van Hensbergen wrote:
> I'm not sure passing directory file descriptors is the right semantic
> we want - but at least it provides a point of explicit control (in
> much the same way as a bind).  Are you sure the clone + open("/") +
> pass-to-parent scenario you allows the parent to traverse the child's
> private name space through that fd?

Pretty sure.

> That seems as bad as accessing pid name space via the /proc file
> system.

Or good, depending on your point of view :)

Don't think of "namespaces".  Think "set of mounts".
Then what Linux does makes more sense.

Don't forget that if you couldn't do this, you could still use ptrace
to traverse the child's namespace by tracing it.

> In Plan 9, file descriptors are passed between name spaces, but the
> only use of such a facility (described in fork(2) [plan9man]) is to
> pass channels to file servers which can then be mounted in a blank
> name space.  exportfs(4)[plan9man] seems to provide a much nicer
> semantic for this sort of name space sharing.

> c) Get the unshare system call adopted as it seems to be generally useful

I'm not convinced the functionality is all that useful.  It doesn't
address the need which arose in this thread, which is roughly
equivalent to per-user namespaces (the precise meaning determined by
userspace policy).  So what applicatins is it useful for?  Do we have
examples, or is it just a nice idea?

-- Jamie
