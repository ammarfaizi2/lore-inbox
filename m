Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVACBmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVACBmQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 20:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVACBmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 20:42:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:44235 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261357AbVACBmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 20:42:13 -0500
Date: Sun, 2 Jan 2005 17:41:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org, davidel@xmailserver.org, mh@codeweavers.com,
       the3dfxdude@gmail.com
Subject: Re: [PATCH] Fix typo in i386 single step changes
In-Reply-To: <20050103000130.GA74276@muc.de>
Message-ID: <Pine.LNX.4.58.0501021717330.2280@ppc970.osdl.org>
References: <m1brc7xv98.fsf@muc.de> <20050102234155.GA29453@nevyn.them.org>
 <20050103000130.GA74276@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Jan 2005, Andi Kleen wrote:
> 
> Also looking at the code more closely the comment above doesn't 
> match what the code does. I fixed that too.

The comment is slightly stale, but yours perpetuates the staleness, and 
doesn't fix the first comment which also talks about staleness.

Back when we were really broken with TF handling, we also used to set TF
when we started single-stepping, but we never cleared it until we got a
stale DR_STEP event. In fact, we could have the debugger detach from the
process, and leave TF set. That's not true any more, and I don't think it
was true even before the latest changes - the code (and comment) has been
stale for quite a while.

So the whole "lazy TF" thing is really incorrect, and these days it's
about the user setting TF on its own.

And the _code_ was corrupted too (and working, but only because it could
never trigger anyway).

I'll remove it and fix up the comments.

		Linus
