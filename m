Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSKXRjU>; Sun, 24 Nov 2002 12:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbSKXRjT>; Sun, 24 Nov 2002 12:39:19 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:28684 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id <S261492AbSKXRjT>;
	Sun, 24 Nov 2002 12:39:19 -0500
Date: Sun, 24 Nov 2002 18:46:35 +0100
From: Felix von Leitner <felix-kerel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: epoll_wait conflicts with man page
Message-ID: <20021124174635.GB16255@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just implemented epoll_create, epoll_ctl and epoll_wait for the diet
libc and found that epoll_wait in 2.5.59 does not expect struct
epoll_event* as second argument but actually struct pollfd*.

That makes it more useful in one sense because porting old poll programs
is easier this way.  On the other hand, it makes the whole API less
useful because the epoll_ctl call is documented to use struct
epoll_event which contains opaque user data to enlist a file descriptor.
This data can now not be passed back to user space because it does not
fit in struct pollfd.

By the way: the epoll API looks great!  I especially like the opaque
user specified data thing, however making it a union is not so smart
because strace can't meaningfully display it.  Also, I would move the
"int fd" out of the union because it is universally useful to know the
file descriptor without having to save it in the opaque data.

Felix

PS: I noticed that the epoll syscall numbers are not #defined on several
platforms, for example sparc and mips.
