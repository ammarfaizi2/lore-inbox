Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbTKZWI4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 17:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264378AbTKZWIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 17:08:55 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:49314 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264373AbTKZWIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 17:08:53 -0500
Subject: Re: Never mind. Re: Signal left blocked after signal handler.
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: bruce@perens.com, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1069883580.723.416.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 Nov 2003 16:53:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One difference in 2.4.x and 2.6.x is the signal blocking
> wrt blocked signals that are _forced_ (ie anything that
> is thread-synchronous, like a SIGSEGV/SIGTRAP/SIGBUS that
> happens as a result of a fault):
>
>  - in 2.4.x they will just punch through the block
>  - in 2.6.x they will refuse to punch through a blocked
>    signal, but since they can't be delivered they will
>    cause the process to be killed.
...
> and in 2.4.x this will cause infinte SIGSEGV's (well,
> they'll be caught by the stack size eventually, but you
> see the problem: do a "strace" to see what's going on).
> In 2.6.x the second SIGSEGV will just kill the program
> immediately.

How about making the process sleep in a killable state?

This is as if the blocking was obeyed, but doesn't
burn CPU time. Only a debugger should be able to
tell the difference.



