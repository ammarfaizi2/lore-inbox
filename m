Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbTLOXHE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 18:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTLOXHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 18:07:04 -0500
Received: from mail1.speakeasy.net ([216.254.0.201]:54491 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S264155AbTLOXHA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 18:07:00 -0500
Date: Mon, 15 Dec 2003 15:06:53 -0800
Message-Id: <200312152306.hBFN6riq024958@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: Linus Torvalds's message of  Sunday, 14 December 2003 12:38:15 -0800 <Pine.LNX.4.58.0312141228170.1478@home.osdl.org>
X-Fcc: ~/Mail/linus
X-Windows: even your dog won't like it.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Or is that case impossible to trigger? Looks a bit like that. But if it
> _is_ impossible to trigger (ie exit_signal cannot be -1 for a thread
> leader), then why does the current code test for "&& leader->exit_signal
> != -1)" at all?

I think that most of the logic testing exit_signal was written when
CLONE_DETACHED could be used independent of CLONE_THREAD.  We concluded
that was unworkable due to some related races and changed clone so that the
situation of a (live) thread group leader with exit_signal == -1 is now
impossible.
