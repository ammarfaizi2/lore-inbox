Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264626AbTIDE7E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 00:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264666AbTIDE7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 00:59:04 -0400
Received: from rth.ninka.net ([216.101.162.244]:36296 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264626AbTIDE7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 00:59:01 -0400
Date: Wed, 3 Sep 2003 21:58:50 -0700
From: "David S. Miller" <davem@redhat.com>
To: Larry McVoy <lm@bitmover.com>
Cc: phillips@arcor.de, lm@bitmover.com, mbligh@aracnet.com,
       piggin@cyberone.com.au, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-Id: <20030903215850.0827c589.davem@redhat.com>
In-Reply-To: <20030904024608.GH5227@work.bitmover.com>
References: <20030903040327.GA10257@work.bitmover.com>
	<31190000.1062604245@[10.10.2.4]>
	<20030904004943.GB5227@work.bitmover.com>
	<200309040421.16939.phillips@arcor.de>
	<20030904024608.GH5227@work.bitmover.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003 19:46:08 -0700
Larry McVoy <lm@bitmover.com> wrote:

> Here's the litmus test: list all the locks in the kernel and the locking
> hierarchy.  If you, a self claimed genius, can't do it, how can the rest
> of us mortals possibly do it?  Quick.  You have 30 seconds, I want a list.
> A complete list with the locking hierarchy, no silly awk scripts.  You have
> to show which locks can deadlock, from memory.
> 
> No list?  Cool, you just proved my point.

No point Larry, asking the same question about how the I/O
path works sans the locks will give you the same blank stare.

I absolutely do not accept the complexity argument.  We have a fully
scalable kernel now.  Do you know why?  It's not because we have some
weird genius trolls writing the code, it's because of our insanely
huge testing base.

People give a lot of credit to the people writing the code in the
Linux kernel which actually belongs to the people running the
code. :-)

That's where the other systems failed, all the in-house stress
testing in the world is not going to find the bugs we do find in
Linux.  That's why Solaris goes out buggy and with all kinds of
SMP deadlocks, their tester base is just too small to hit all
the important bugs.

FWIW, I actually can list all the locks taken for the primary paths in
the networking, and that's about as finely locked as we can make it.
As can Alexey Kuznetsov...

So again, if you're going to argue against huge SMP (at least to me),
don't use the locking complexity argument.  Not only have we basically
conquered it, we've along the way found some amazing ways to find
locking bugs both at runtime and at compile time.  You can even debug
them on uniprocessor systems.  And this doesn't even count the
potential things we can do with Linus's sparse tool.
