Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTJHC6V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 22:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTJHC6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 22:58:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:40339 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261226AbTJHC6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 22:58:20 -0400
Date: Tue, 7 Oct 2003 19:57:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Robert White <rwhite@casabyte.com>
cc: "'Albert Cahalan'" <albert@users.sourceforge.net>,
       "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Who changed /proc/<pid>/ in 2.6.0-test5-bk9? (SIGPIPE?)
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAp904CFg3kEGlG8vIGe/66QEAAAAA@casabyte.com>
Message-ID: <Pine.LNX.4.44.0310071954520.32358-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Oct 2003, Robert White wrote:
> 
> If all the CLONE_THREAD members of a process (automatically) have the same
> signal handling code/context but not the same list of file descriptors, what
> happens when a file descriptor posts SIGPIPE or SIGIO (etc.) to a process?

You have to explicitly _ask_ for SIGIO. If you do so, and you don't share
file descriptors, that's _your_ problem.

But it does indeed have perfectly valid semantics - the signal may well
just wake up a thread: and in fact, as most IO is illegal in signal
handler context anyway, it usually has to. 

Clearly, if you have per-thread file descriptors, you have to keep track 
of which thread is doing what. 

		Linus

