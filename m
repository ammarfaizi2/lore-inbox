Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUFEUpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUFEUpq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 16:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUFEUpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 16:45:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:53670 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261925AbUFEUpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 16:45:44 -0400
Date: Sat, 5 Jun 2004 13:45:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell Leighton <russ@elegant-software.com>,
       Arjan van de Ven <arjanv@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
In-Reply-To: <40C1E6A9.3010307@elegant-software.com>
Message-ID: <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
References: <40C1E6A9.3010307@elegant-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Jun 2004, Russell Leighton wrote:
> 
> I have a test program (see attached) that shows what looks like a bug in 
> 2.6.5-1.358 (FedoraCore2)...and breaks my program :(
> 
> In summary, I am doing:
> 
>  clone(run_thread, stack + sizeof(stack) -1,
>             CLONE_FS|CLONE_FILES|CLONE_VM|SIGCHLD, NULL))
> 
> According to the man page the child process should have its own pid as 
> returned by getpid()...much like fork().
> 
> In 2.6 the child receives the parent's pid from getpid(), while 2.4 
> works as documented:
> 
> In 2.4 the test program does:
>  parent pid: 26647
>  clone returned pid: 26648
>  thread reported pid: 26648
> 
> In 2.6 the test program does:
>  parent pid: 16665
>  thread reported pid: 16665
>  clone returned pid: 16666

Hmm.. The above is the correct behaviour if you use CLONE_THREAD 
("getpid()" will then return the _thread_ ID), but it shouldn't happen 
without that. And clearly you don't have it set.

And indeed, it doesn't happen for me on my system:

	parent pid: 13552
	thread reported pid: 13553
	clone returned pid: 13553

so I wonder if either the Fedora libc always adds that CLONE_THREAD thing
to the clone() calls, or whether the FC2 kernel is buggy.

Arjan?

		Linus
