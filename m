Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263384AbTIGR3i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 13:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbTIGR3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 13:29:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:55020 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263384AbTIGR3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 13:29:34 -0400
Date: Sun, 7 Sep 2003 10:29:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Schwab <schwab@suse.de>
cc: Matthew Wilcox <willy@debian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
In-Reply-To: <jefzj8lf3l.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.44.0309071024010.2977-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 7 Sep 2003, Andreas Schwab wrote:
> 
> Here is a patch that enforces the use of types in the third argument.  It
> requires gcc >= 3.1 for the check to work, I couldn't find a method for
> previous versions.

Ehh, what's wrong with the obvious approach: declare a dummy variable. If 
it's not a type, then the declaration won't work.

Ie, change the (sizeof(x)) to something like

	({ x __dummy; sizeof(__dummy); })

which should work with all compiler versions.

Anything that requires a new compiler is always a big dodgy as a sanity 
check. People who don't have the new compiler won't be testing it, so 
they'll just continually break it for people who _do_. Aggravation 
nightmare.

		Linus

