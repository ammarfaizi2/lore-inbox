Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVD1TVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVD1TVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 15:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVD1TVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 15:21:17 -0400
Received: from mail.shareable.org ([81.29.64.88]:39850 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262220AbVD1TVJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 15:21:09 -0400
Date: Thu, 28 Apr 2005 20:20:48 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050428192048.GA2895@mail.shareable.org>
References: <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <20050424213822.GB9304@mail.shareable.org> <20050425152049.GB2508@elf.ucw.cz> <20050425190734.GB28294@mail.shareable.org> <20050426092924.GA4175@elf.ucw.cz> <20050426140715.GA10833@mail.shareable.org> <a4e6962a050428064774e88f4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e6962a050428064774e88f4a@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Van Hensbergen wrote:
> > It's called /proc/NNN/root.
> > 
> > So no new system calls are needed.  A daemon to hand out per-user
> > namespaces (or any other policy) can be written using existing
> > kernels, and those namespaces can be joined using chroot.
> > 
> > That's the theory anyway.  It's always possible I misread the code (as
> > I don't use namespaces and don't have tools handy to try them).
> > 
> 
> Should have checked myself before posting my previous reply -- but
> this doesn't seem to work.  /proc/NNN/root is represented as a
> symlink, but when you CLONE_NS and then try to look at another one of
> your process' /proc/NNN/root the link doesn't seem to have a target
> and you get permission denied on all accesses.

I've looked at the code.  Look in fs/proc/base.c (Linux 2.6.10),
proc_root_link().

I don't see anything there to prevent you from traversing to the
mounts in the other namespace.

So why is it failing?  Any idea?

> I haven't looked at the underlying procfs code, but adapting procfs
> for this sort of purpose feels wrong.

Having a file/directory which represents namespaces held by another
process makes much more sense to me than new system calls and
inventing yet another id space to represent namespaces.

And, given that you can look at the filesystems another process can
see by doing ptrace on it, it might as well be accessible in a more
natural way.

-- Jamie
