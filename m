Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbUKOWz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbUKOWz0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbUKOWzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:55:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25750 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261533AbUKOWxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:53:22 -0500
Date: Mon, 15 Nov 2004 14:53:08 -0800
Message-Id: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Mike Hearn <mh@codeweavers.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Eric Pouech <pouech-eric@wanadoo.fr>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: Linus Torvalds's message of  Monday, 15 November 2004 14:41:31 -0800 <Pine.LNX.4.58.0411151439270.2222@ppc970.osdl.org>
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, TIF_SINGLESTEP gets set even when the _user_ set TF. It is just a flag
> saying that we should re-enable TF when we get back to user space.
> 
> So TIF_SINGLESTEP in no way implies that TF was set by a debugger.

Ok, whatever.  I'm not really sure its use for the single-step stuff in
Davide Libenzi's changes doesn't change the expected behavior for the
nondebugger case, but it's too early in the morning to think hard about that.

Your change hit only one spot of three in arch/i386/kernel/signal.c where
PT_PTRACED is now tested and it should be a "is PTRACE_SINGLESTEP in effect?"
test.  Also the same spots in native and 32-bit emul for x86-64.


Thanks,
Roland
