Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbTESUeP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 16:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTESUeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 16:34:15 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:65228 "EHLO
	vagabond.cybernet.cz") by vger.kernel.org with ESMTP
	id S262855AbTESUeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 16:34:13 -0400
Date: Mon, 19 May 2003 22:47:02 +0200
From: Jan Hudec <bulb@ucw.cz>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
Message-ID: <20030519204701.GE944@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	"Peter T. Breuer" <ptb@it.uc3m.es>,
	Davide Libenzi <davidel@xmailserver.org>,
	linux-kernel@vger.kernel.org
References: <20030518182010$0541@gated-at.bofh.it> <200305181909.h4IJ9sK02186@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305181909.h4IJ9sK02186@oboe.it.uc3m.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 09:09:54PM +0200, Peter T. Breuer wrote:
> In article <20030518182010$0541@gated-at.bofh.it> you wrote:
> > On Sun, 18 May 2003, Peter T. Breuer wrote:
> >> Here's a before-breakfast implementation of a recursive spinlock. That
> 
> > A looong time ago I gave to someone a recursive spinlock implementation
> > that they integrated in the USB code. I don't see it in the latest
> > kernels, so I have to guess that they found a better solution to do their
> > things. I'm biased to say that it must not be necessary to have the thing
> > if you structure your code correctly.
> 
> Well, you can get rid of anything that way. The question is if the
> interface is an appropriate one to use or not - i.e. if it makes for
> better code in general, or if it make errors of programming less
> likely.

I dare to disagree. It makes for more messy code in general and might
result in the obvious bugs to be replaced by subtle ones that are far
harder to debug.

> I would argue that the latter is undoubtedly true - merely that
> userspace flock/fcntl works that way would argue for it, but there
> are a couple of other reasons too. 

No ;-) Only fcntl does.

> Going against is the point that it may be slower.  Can you dig out your
> implementation and show me it?  I wasn't going for assembler in my hasty

It's also a waste of memory. There are many structures that have a lock
per instance and four extra bytes (for the owner) would be noticeable.
Not that memory is so precious resource, but cachelines may be.

> example.  I just wanted to establish that it's easy, so that it becomes
> known that its easy, and folks therefore aren't afraid of it.  That both
> you and I have had to write it implies that it's not obvious code to
> everyone.

It's not about weather it's easy. It's about weather it's useful.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
