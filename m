Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUF1Vz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUF1Vz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUF1Vz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:55:59 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:48854 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265230AbUF1Vz6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:55:58 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Jun 2004 14:55:55 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] signal handler defaulting fix ...
In-Reply-To: <Pine.LNX.4.58.0406281446460.28764@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0406281453250.18879@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0406281430470.18879@bigblue.dev.mdolabs.com>
 <20040628144003.40c151ff.akpm@osdl.org> <Pine.LNX.4.58.0406281446460.28764@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004, Linus Torvalds wrote:

> On Mon, 28 Jun 2004, Andrew Morton wrote:
> >
> > Davide Libenzi <davidel@xmailserver.org> wrote:
> > >
> > > 
> > > Following up from the other thread (2.6.x signal handler bug) this bring 
> > > 2.4 behaviour in 2.6.
> > > 
> > 
> > Pity the poor person who tries to understand this change in a year's time. 
> > Could we have a real changelog please?
> 
> Also, do we really care? The 2.6.x behaviour is nicer in that it tends to
> kill programs more abruptly, while 2.4.x will just let a blocked signal
> through - possibly letting the program continue, but causing "impossible"  
> bugs in user space.
> 
> I don't think we've had any complaints about the 2.6.x behaviour apart
> from the initial discussion a few months ago. I'd much rather have a
> debuggable "kill a program that tries to block a synchronous interrupt",
> than a potentially totally un-debuggable "let the signal through".

It's not that the program try to block the signal. It's the kernel that 
during the delivery disables the signal. Then when the signal handler 
longjmp(), the signal remains disabled. The next time the signal is raised 
again, the kernel does not honor the existing handler, but it reset to 
SIG_DFL.



- Davide

