Return-Path: <linux-kernel-owner+w=401wt.eu-S1762713AbWLKKDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762713AbWLKKDH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762711AbWLKKDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:03:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54623 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762709AbWLKKDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:03:06 -0500
Date: Mon, 11 Dec 2006 10:03:01 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Linus Torvalds orton <akpm@osdl.org>" <torvalds@osdl.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
Message-ID: <20061211100301.GD4587@ftp.linux.org.uk>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com> <20061211005557.04643a75.akpm@osdl.org> <20061211011327.f9478117.akpm@osdl.org> <20061211092130.GB4587@ftp.linux.org.uk> <20061211012545.ed945cbd.akpm@osdl.org> <20061211093314.GC4587@ftp.linux.org.uk> <20061211014727.21c4ab25.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211014727.21c4ab25.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 01:47:27AM -0800, Andrew Morton wrote:
> - populate_rootfs() puts stuff into the filesystem
> 
> - we then run initcalls.
> 
> - an initcall runs /sbin/hotplug.
> 
> We're now running userspace before all the initcalls have been executed. 
> Hence we're trying to run userspace when potentially none of "grep
> _initcall */*.c" has been executed.  It isn't a kernel yet...

That's... arguable.  We certainly don't need lots and lots of initcalls
to be able to run userland code.  Which ones are missing in your opinion?

As for that example, I'd love to see specifics - which driver triggers
hotplug?  Presumably it happens from an initcall, so we also have something
fishy here...

Said that, I think that pipes should be initialized early.
