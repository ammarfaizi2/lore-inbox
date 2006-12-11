Return-Path: <linux-kernel-owner+w=401wt.eu-S1760363AbWLKJVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760363AbWLKJVf (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762680AbWLKJVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:21:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56917 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760363AbWLKJVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:21:34 -0500
Date: Mon, 11 Dec 2006 09:21:30 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Linus Torvalds orton <akpm@osdl.org>" <torvalds@osdl.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
Message-ID: <20061211092130.GB4587@ftp.linux.org.uk>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com> <20061211005557.04643a75.akpm@osdl.org> <20061211011327.f9478117.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211011327.f9478117.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 01:13:27AM -0800, Andrew Morton wrote:
> On Mon, 11 Dec 2006 00:55:57 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > I think the bug really is the running of populate_rootfs() before running
> > the initcalls, in init/main.c:init().  It's just more sensible to start
> > running userspace after the initcalls have been run.  Statically-linked
> > drivers which want to load firmware files will lose.  To fix that we'd need
> > a new callback.  It could be with a new linker section or perhaps simply a
> > notifier chain.
> 
> hm, actually...  Add two new initcall levels, one for populate_rootfs() and
> one for things which want to come after it (ie: drivers which want to
> access the filesytem):

IMO we should just call pipe (and socket) initialization directly at
the same level as slab, task, dcache, etc.

This is basic stuff needed to get operational kernel.  We could try
to put that on an additional initcall level, but then we ought to
take the rest of basic setup there as well.
