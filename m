Return-Path: <linux-kernel-owner+w=401wt.eu-S1762688AbWLKJdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762688AbWLKJdU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762693AbWLKJdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:33:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57496 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762688AbWLKJdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:33:19 -0500
Date: Mon, 11 Dec 2006 09:33:15 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Linus Torvalds orton <akpm@osdl.org>" <torvalds@osdl.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
Message-ID: <20061211093314.GC4587@ftp.linux.org.uk>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com> <20061211005557.04643a75.akpm@osdl.org> <20061211011327.f9478117.akpm@osdl.org> <20061211092130.GB4587@ftp.linux.org.uk> <20061211012545.ed945cbd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211012545.ed945cbd.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 01:25:45AM -0800, Andrew Morton wrote:
> On Mon, 11 Dec 2006 09:21:30 +0000
> Al Viro <viro@ftp.linux.org.uk> wrote:
> 
> > On Mon, Dec 11, 2006 at 01:13:27AM -0800, Andrew Morton wrote:
> > > On Mon, 11 Dec 2006 00:55:57 -0800
> > > Andrew Morton <akpm@osdl.org> wrote:
> > > 
> > > > I think the bug really is the running of populate_rootfs() before running
> > > > the initcalls, in init/main.c:init().  It's just more sensible to start
> > > > running userspace after the initcalls have been run.  Statically-linked
> > > > drivers which want to load firmware files will lose.  To fix that we'd need
> > > > a new callback.  It could be with a new linker section or perhaps simply a
> > > > notifier chain.
> > > 
> > > hm, actually...  Add two new initcall levels, one for populate_rootfs() and
> > > one for things which want to come after it (ie: drivers which want to
> > > access the filesytem):
> > 
> > IMO we should just call pipe (and socket) initialization directly at
> > the same level as slab, task, dcache, etc.
> 
> spose that would work.  But what other initcall-initialised things are not
> yet available when populate_rootfs() runs?
> 
> <does  grep _initcall */*.c>
> <wonders why anything works at all>

Explain, please...
