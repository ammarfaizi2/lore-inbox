Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbTLOWzt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 17:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTLOWzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 17:55:49 -0500
Received: from mail3.speakeasy.net ([216.254.0.203]:37523 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S264285AbTLOWzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 17:55:46 -0500
Date: Mon, 15 Dec 2003 14:55:38 -0800
Message-Id: <200312152255.hBFMtcEZ024917@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: arjanv@redhat.com
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: Arjan van de Ven's message of  Monday, 15 December 2003 09:54:16 +0100 <1071478455.5223.0.camel@laptop.fenrus.com>
Emacs: or perhaps you'd prefer Russian Roulette, after all?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 2003-12-14 at 23:10, Linus Torvalds wrote:
> 
> > Even though the parent ignores SIGCHLD it _can_ be running on another CPU
> > in "wait4()".
> 
> which fwiw is a case of illegal behavior in the program ... of course
> the kernel shouldn't die if it happens.

No, it is legal to call wait* when ignoring SIGCHLD--and it is required to
return ECHILD for the dead ones.  For example, using waitpid with WNOHANG
is a valid way to poll for the liveness of a child (though there is no good
reason why an application wouldn't just use kill(,0) for that).  It's not a
method that has anything to recommend it, but it is perfectly valid and the
range of permissible results is well-specified.
