Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbTLNWdD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 17:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTLNWdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 17:33:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:20458 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262745AbTLNWdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 17:33:01 -0500
Date: Sun, 14 Dec 2003 14:32:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: <Pine.LNX.4.58.0312142314200.14841@earth>
Message-ID: <Pine.LNX.4.58.0312141420070.1481@home.osdl.org>
References: <20031214052516.GA313@vana.vc.cvut.cz> <Pine.LNX.4.58.0312142032310.9900@earth>
 <Pine.LNX.4.58.0312141228170.1478@home.osdl.org> <Pine.LNX.4.58.0312142205050.13533@earth>
 <Pine.LNX.4.58.0312141353220.1586@home.osdl.org> <Pine.LNX.4.58.0312142314200.14841@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Dec 2003, Ingo Molnar wrote:
>
> are you sure this can happen? eligible_child() does this:

Interesting. That code should have been enough, but we've later on added
extra code into wait_task_zombie to check _exactly_ the same case because
we saw problems.

Hmm.. Maybe that was to protect against concurrent wait4()'ers (which can
happen - the wait case only takes the read lock). Threads can wait for
each others children, after all.

		Linus
