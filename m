Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVAYQ12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVAYQ12 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVAYQ11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:27:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:34796 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261982AbVAYQ1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:27:24 -0500
Date: Tue, 25 Jan 2005 08:27:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Bill Davidsen <davidsen@tmr.com>, Greg KH <greg@kroah.com>,
       Jirka Kosina <jikos@jikos.cz>, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix bad locking in drivers/base/driver.c
In-Reply-To: <41F66F86.4000609@sun.com>
Message-ID: <Pine.LNX.4.58.0501250817430.2342@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501241921310.5857@twin.jikos.cz>
 <20050125055651.GA1987@kroah.com> <41F5F623.5090903@sun.com> <41F64E87.8040501@tmr.com>
 <41F66F86.4000609@sun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hmm.. I certainly like the "use completions" patch, since it makes it a
lot more obvious what is going on (and it is what completions were
designed for).

However, since it does change semantics very subtly: if you call
"driver_unregister()" twice (which is wrong, but looking at the code it
looks like it would just silently have worked), the old code would just
ignore it. The new code will block on the second one.

Now, I don't mind the blocking (it's a bug to call it twice, and blocking
should even give a nice callback when you do the "show tasks"  sysrq, so
it's a good way to _find_ the bug), but together with Mike's comment about
"Compile-tested only", I'd really like somebody (Greg?) to say "trying to
doubly remove the driver is so illegal that we don't care, and btw, I
tested it and it's all ok".

		Linus
