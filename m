Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTLCUgB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTLCUgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:36:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:40852 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261460AbTLCUfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:35:54 -0500
Date: Wed, 3 Dec 2003 21:35:58 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Raj <raju@mailandnews.com>,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: kernel BUG at kernel/exit.c:792!
In-Reply-To: <Pine.LNX.4.58.0312031203430.7406@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312032126490.6831@earth>
References: <20031203153858.C14999@in.ibm.com> <3FCDCEA3.1020209@mailandnews.com>
 <20031203182319.D14999@in.ibm.com> <Pine.LNX.4.58.0312032059040.4438@earth>
 <Pine.LNX.4.58.0312031203430.7406@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Dec 2003, Linus Torvalds wrote:

> This is one reason I hate some assert() with a passion. I've seen this
> way too often: somebody added an assert for something he thought was a
> bug, and then people are too damn afraid to just admit that it wasn't a
> bug at all, and just get rid of the f-ing assert. So instead, you add
> code to avoid the assert. And that code itself is non-obvious and
> broken.

i share your concern wrt. the abuse of asserts, but a few strategic
BUG_ON()s and WARN_ON()s have done wonders to 2.6 quality already. There
are certain types of bugs that are very hairy to detect if not caught
early enough. Stale thread pointers are one such thing.

in this specific case i doubt we'd be in a better position by not having
this assert. get_tid_list() would not crash the way it asserts now,
because task structs are not cleared after freeing. It might even lead to
incorrect thread lists being generated, if the task struct got reused for
another process. Or if it's reused for something else then we'd get much
rarer crashes in get_tid_list().

i think i'd rather like to see a few bad rounds of attempted fixes than
(much-) harder to reproduce bugs.

	Ingo
