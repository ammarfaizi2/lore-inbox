Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318503AbSIPBaz>; Sun, 15 Sep 2002 21:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318599AbSIPBaz>; Sun, 15 Sep 2002 21:30:55 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:41468
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318503AbSIPBay>; Sun, 15 Sep 2002 21:30:54 -0400
Subject: Re: [patch] thread-exec-2.5.34-B1, BK-curr
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209151137490.10830-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0209151137490.10830-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 16 Sep 2002 02:37:56 +0100
Message-Id: <1032140276.27001.27.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-15 at 19:38, Linus Torvalds wrote:
> 
> On Sun, 15 Sep 2002, Ingo Molnar wrote:
> > 
> > i dont like those semantics either - will verify whether thread-specific
> > exec() works via a helper thread (or vfork) - it really should.
> 
> As long as it works with something sane (and vfork() is sane), I'm happy 
> with the posix behaviour by default. After all, the execve() really _does_ 
> need to "de-thread" anyway, and if we need to make that explicit (with the 
> vfork()) then that's fine.

An execve can be setuid code so it really represents a whole new
security domain. Thats why the thread signal protection refuses to let
strange child exit signals cross it.

There is code that depends on clone()/exec() not killing other threads
in the group - some threaded web servers for example.

