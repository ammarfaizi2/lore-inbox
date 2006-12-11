Return-Path: <linux-kernel-owner+w=401wt.eu-S1762774AbWLKKeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762774AbWLKKeu (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762775AbWLKKeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:34:50 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39130 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762774AbWLKKet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:34:49 -0500
Date: Mon, 11 Dec 2006 02:34:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Linus Torvalds orton <akpm@osdl.org>" <torvalds@osdl.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
Message-Id: <20061211023436.258bb3ea.akpm@osdl.org>
In-Reply-To: <20061211102207.GE4587@ftp.linux.org.uk>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com>
	<20061211005557.04643a75.akpm@osdl.org>
	<20061211011327.f9478117.akpm@osdl.org>
	<20061211092130.GB4587@ftp.linux.org.uk>
	<20061211012545.ed945cbd.akpm@osdl.org>
	<20061211093314.GC4587@ftp.linux.org.uk>
	<20061211014727.21c4ab25.akpm@osdl.org>
	<20061211100301.GD4587@ftp.linux.org.uk>
	<20061211021718.a6954106.akpm@osdl.org>
	<20061211102207.GE4587@ftp.linux.org.uk>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 10:22:07 +0000
Al Viro <viro@ftp.linux.org.uk> wrote:

> On Mon, Dec 11, 2006 at 02:17:18AM -0800, Andrew Morton wrote:
> > I think we should aim to have as many subsystems ready to go as possible -
> > ideally all of them.  Right now we can potentially run userspace before
> > AIO, posix-timers, message-queues, BIO, networking, etc are ready to run.
> > 
> > It looks to be pretty easy to fix...
> > 
> > > As for that example, I'd love to see specifics - which driver triggers
> > > hotplug?  Presumably it happens from an initcall, so we also have something
> > > fishy here...
> > 
> > I don't know in this case - but firmware loading from a statically-linked
> > driver is a legit thing to do.
> 
> Umm... statically linked driver that might want firmware shouldn't precede
> the subsystems unless something is seriously wrong with priorities...

There are plenty of drivers in there using subsys_initcall, arch_initcall,
postcore_initcall, core_initcall and even one pure_initcall.

Heaven knows why.  They're drivers :(

> IOW, I still wonder what's really going on - pipes are fs_initcall() and
> any hardware stuff ought to be simple module_init().  So something fishy
> is going on, regardless of anything else.

A heck of a lot of things can trigger an /sbin/hotplug run.  It could well
be that Andrew's driver didn't want to run hotplug at all, but the kernel
did it anwyay.  But as soon as the script appeared at /sbin/hotplug, and it
happened to use foo|bar: boom.


