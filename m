Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264322AbTLOXEz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 18:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbTLOXEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 18:04:55 -0500
Received: from mail4.speakeasy.net ([216.254.0.204]:26001 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S264322AbTLOXEx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 18:04:53 -0500
Date: Mon, 15 Dec 2003 15:04:48 -0800
Message-Id: <200312152304.hBFN4mxq024943@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: Linus Torvalds's message of  Sunday, 14 December 2003 14:32:55 -0800 <Pine.LNX.4.58.0312141420070.1481@home.osdl.org>
X-Fcc: ~/Mail/linus
Emacs: well, why *shouldn't* you pay property taxes on your editor?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 14 Dec 2003, Ingo Molnar wrote:
> >
> > are you sure this can happen? eligible_child() does this:
> 
> Interesting. That code should have been enough, but we've later on added
> extra code into wait_task_zombie to check _exactly_ the same case because
> we saw problems.
> 
> Hmm.. Maybe that was to protect against concurrent wait4()'ers (which can
> happen - the wait case only takes the read lock). Threads can wait for
> each others children, after all.

My recollection about the wait_task_* changes was that they were mostly to
address races between concurrent wait4 calls.
