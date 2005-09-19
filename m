Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbVISTPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbVISTPX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVISTPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:15:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57572 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932593AbVISTPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:15:22 -0400
Date: Mon, 19 Sep 2005 12:14:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc1 wait()/SIG_CHILD bevahiour
In-Reply-To: <1127151573.1586.14.camel@dyn9047017102.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0509191206040.2553@g5.osdl.org>
References: <1127151573.1586.14.camel@dyn9047017102.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Sep 2005, Badari Pulavarty wrote:
> 
> I can easily reproduce the problem on my AMD64 machine. 
> Any thoughts on why this is happening ? Any known issues/fixes ?

Interesting.

I don't think it is SIGCHLD, because you can "strace" the waiter in one 
window, and send it a SIGCHLD _by_hand_ in the other window, and it will 
do a new "wait4()", but still not pick up its zombie children.

So it looks like wait() itself is broken, and doesn't pick up the children 
for some reason. It just returns 0.

Ingo, Roland - Badari included a test-program in his post on lkml, and I
can trigger the behaviour on ppc64, even if I can't see what's wrong yet.  
Mind taking a look?

			Linus
