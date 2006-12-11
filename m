Return-Path: <linux-kernel-owner+w=401wt.eu-S1762750AbWLKKWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762750AbWLKKWO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762751AbWLKKWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:22:13 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46394 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762750AbWLKKWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:22:13 -0500
Date: Mon, 11 Dec 2006 10:22:07 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Linus Torvalds orton <akpm@osdl.org>" <torvalds@osdl.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
Message-ID: <20061211102207.GE4587@ftp.linux.org.uk>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com> <20061211005557.04643a75.akpm@osdl.org> <20061211011327.f9478117.akpm@osdl.org> <20061211092130.GB4587@ftp.linux.org.uk> <20061211012545.ed945cbd.akpm@osdl.org> <20061211093314.GC4587@ftp.linux.org.uk> <20061211014727.21c4ab25.akpm@osdl.org> <20061211100301.GD4587@ftp.linux.org.uk> <20061211021718.a6954106.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211021718.a6954106.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 02:17:18AM -0800, Andrew Morton wrote:
> I think we should aim to have as many subsystems ready to go as possible -
> ideally all of them.  Right now we can potentially run userspace before
> AIO, posix-timers, message-queues, BIO, networking, etc are ready to run.
> 
> It looks to be pretty easy to fix...
> 
> > As for that example, I'd love to see specifics - which driver triggers
> > hotplug?  Presumably it happens from an initcall, so we also have something
> > fishy here...
> 
> I don't know in this case - but firmware loading from a statically-linked
> driver is a legit thing to do.

Umm... statically linked driver that might want firmware shouldn't precede
the subsystems unless something is seriously wrong with priorities...

IOW, I still wonder what's really going on - pipes are fs_initcall() and
any hardware stuff ought to be simple module_init().  So something fishy
is going on, regardless of anything else.
