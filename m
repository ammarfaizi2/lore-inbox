Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUHBALN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUHBALN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 20:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266210AbUHBAKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 20:10:50 -0400
Received: from the-village.bc.nu ([81.2.110.252]:17074 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266227AbUHBAKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 20:10:38 -0400
Subject: Re: secure computing for 2.6.7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: chris@scary.beasts.org, Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040801231047.GI6295@dualathlon.random>
References: <20040704173903.GE7281@dualathlon.random>
	 <40EC4E96.9090800@namesys.com> <20040801102231.GB6295@dualathlon.random>
	 <Pine.LNX.4.58.0408011248040.1368@sphinx.mythic-beasts.com>
	 <20040801150119.GE6295@dualathlon.random>
	 <Pine.LNX.4.58.0408011801260.1368@sphinx.mythic-beasts.com>
	 <1091393114.31139.5.camel@localhost.localdomain>
	 <20040801231047.GI6295@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091401677.31405.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 02 Aug 2004 00:08:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-02 at 00:10, Andrea Arcangeli wrote:
> On Sun, Aug 01, 2004 at 09:45:14PM +0100, Alan Cox wrote:
> > You can already do all of this using several user space applications
> > that manage it via ptrace. They do have a performance hit however.
> 
> the tracer can be killed by oom due some other random app in the
> machine, plus SIGCHLD may confuse the tracer, then it needs to know
> about arch details again (like the bitmap), and the whole ptrace
> infastructure is a lot more complicate and in turn less secure. syscall
> performance is the last worry (at least for my usage).

syscall performance is something the other 99.99% of users not using the
feature will care about however. 

One of the things that you can sensibly do I think which will also avoid
a performance hit is to use the same kernel path as strace and friends
do for syscall tracing but capture and verify the syscall in kernel mode
rather than trapping back out. That will at least keep the usual fast
path unharmed by the security toys.


