Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVD1Tj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVD1Tj7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 15:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVD1Tj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 15:39:59 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:8104 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262252AbVD1Tjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 15:39:48 -0400
Subject: Re: [PATCH] private mounts
From: Ram <linuxram@us.ibm.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Eric Van Hensbergen <ericvh@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050428192048.GA2895@mail.shareable.org>
References: <E1DPo3I-0000V0-00@localhost>
	 <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk>
	 <E1DPoCg-0000W0-00@localhost>
	 <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk>
	 <20050424213822.GB9304@mail.shareable.org>
	 <20050425152049.GB2508@elf.ucw.cz>
	 <20050425190734.GB28294@mail.shareable.org>
	 <20050426092924.GA4175@elf.ucw.cz>
	 <20050426140715.GA10833@mail.shareable.org>
	 <a4e6962a050428064774e88f4a@mail.gmail.com>
	 <20050428192048.GA2895@mail.shareable.org>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1114717183.4180.718.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 28 Apr 2005 12:39:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 12:20, Jamie Lokier wrote:
> Eric Van Hensbergen wrote:
> > > It's called /proc/NNN/root.
> > > 
> > > So no new system calls are needed.  A daemon to hand out per-user
> > > namespaces (or any other policy) can be written using existing
> > > kernels, and those namespaces can be joined using chroot.
> > > 
> > > That's the theory anyway.  It's always possible I misread the code (as
> > > I don't use namespaces and don't have tools handy to try them).
> > > 
> > 
> > Should have checked myself before posting my previous reply -- but
> > this doesn't seem to work.  /proc/NNN/root is represented as a
> > symlink, but when you CLONE_NS and then try to look at another one of
> > your process' /proc/NNN/root the link doesn't seem to have a target
> > and you get permission denied on all accesses.
> 
> I've looked at the code.  Look in fs/proc/base.c (Linux 2.6.10),
> proc_root_link().
> 
> I don't see anything there to prevent you from traversing to the
> mounts in the other namespace.
> 
> So why is it failing?  Any idea?

Since you are traversing a symlink, you will be traversing the symlink
in the context of traversing process's namespace. 

If process 'x' is traversing /proc/y/root , the lookup for the root
dentry will happen in the context of process x's  namespace, and not
process y's namespace. Hence process 'x' wont really get into
the namespace of the process y.

RP

