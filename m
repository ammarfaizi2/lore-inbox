Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbULAE2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbULAE2F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 23:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbULAE2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 23:28:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:38602 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261232AbULAE2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 23:28:01 -0500
Date: Tue, 30 Nov 2004 20:27:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Joe Korty <kortyads@mindspring.com>
Cc: roland@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: waitid breaks telnet
Message-Id: <20041130202730.6ceab259.akpm@osdl.org>
In-Reply-To: <5.1.0.14.2.20041130225221.009d1340@pop.mindspring.com>
References: <5.1.0.14.2.20041130225221.009d1340@pop.mindspring.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <kortyads@mindspring.com> wrote:
>
> [ 2nd send, this one from my home email account...]
> 
> telnet no longer works:
> 
>      # chkconfig telnet on
>      # telnet localhost
>      Trying 127.0.0.1...
>      Connected to localhost (127.0.0.1).
>      Escape character is '^]'.
>      Red Hat Enterprise Linux WS release 3 (Taroon Update 2)
>      Kernel 2.6.10-rc2 on an i686
>      Connection closed by foreign host.
> 
> A bsearch placed the bug between 2.6.9-rc1-bk[78], another
> bsearch on the changesets showed the problem is caused
> by this patch:
> 
>      roland@redhat.com[torvalds]|ChangeSet|20040831173525|30767
>      [PATCH] waitid system call
> 
> My guess is, something about the new wait4(2) wrapper
> is causing the telnet daemon to declare success before
> its child, /bin/login, exits.

I can reproduce this on 2.6.10-rc2, but it seems to have been fixed in more
recent kernels.  However I cannot think of anything which we did which
would have fixed this.

