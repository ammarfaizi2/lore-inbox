Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265315AbUF2BYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUF2BYv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 21:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUF2BYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 21:24:51 -0400
Received: from mail.gmx.de ([213.165.64.20]:38808 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265315AbUF2BYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 21:24:49 -0400
X-Authenticated: #271361
Date: Tue, 29 Jun 2004 03:24:41 +0200
From: Edgar Toernig <froese@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] signal handler defaulting fix ...
Message-Id: <20040629032441.403163dd.froese@gmx.de>
In-Reply-To: <Pine.LNX.4.58.0406281507090.28764@ppc970.osdl.org>
References: <Pine.LNX.4.58.0406281430470.18879@bigblue.dev.mdolabs.com>
	<20040628144003.40c151ff.akpm@osdl.org>
	<Pine.LNX.4.58.0406281446460.28764@ppc970.osdl.org>
	<Pine.LNX.4.58.0406281453250.18879@bigblue.dev.mdolabs.com>
	<Pine.LNX.4.58.0406281507090.28764@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 28 Jun 2004, Davide Libenzi wrote:
> > 
> > It's not that the program try to block the signal. It's the kernel that 
> > during the delivery disables the signal. Then when the signal handler 
> > longjmp(), the signal remains disabled. The next time the signal is raised 
> > again, the kernel does not honor the existing handler, but it reset to 
> > SIG_DFL.
> 
> So? That program is buggy.

Not the signal part.  It was written for libc5.  There, signals set
with signal(2) were reset when raised (SysV-style).  Leaving such a
signal handler with longjmp was perfectly valid.

Glibc2 changed the rules: signals set with signal(2) are not reset
but blocked during delivery (BSD-style).  It worked for a while
because the kernel ignored the sigmask for some signals.

So, if one is to blame then glibc2 by breaking compatibility.

With Davide's patch the kernel would be a little bit more tolerant to
old code by keeping the 2.4 behaviour.  The current strict behaviour
becomes OK when signal(2) is no longer part of glibc...

Ciao, ET.
