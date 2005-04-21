Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVDUKwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVDUKwW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 06:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVDUKwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 06:52:22 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:51922 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261277AbVDUKwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 06:52:18 -0400
Subject: Re: [PATCH] Bad rounding in timeval_to_jiffies [was: Re: Odd Timer
	behavior in 2.6 vs 2.4  (1 extra tick)]
From: Steven Rostedt <rostedt@goodmis.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: jdavis@accessline.com, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050421095109.A25431@flint.arm.linux.org.uk>
References: <E29E71BB437ED411B12A0008C7CF755B2BC9BE@mail.accessline.com>
	 <1114052315.5058.13.camel@localhost.localdomain>
	 <1114054816.5996.10.camel@localhost.localdomain>
	 <20050421095109.A25431@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 21 Apr 2005 06:51:48 -0400
Message-Id: <1114080708.5996.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-21 at 09:51 +0100, Russell King wrote:
[...]
> The problem is that when you add a timer, you don't have any idea
> which point you're going to be starting your timer at.
> 
> This is why we always round up to the next jiffy when we convert
> times to jiffies - this ensures that you will get at _least_ the
> timeout you requested, which is in itself a very important
> guarantee.
> 

Thanks, I forgot about the guarantee of "at least" the time requested.
I took this on because I noticed this in a driver I wrote. With the user
passing in a timeval for a periodic condition. I noticed that this would
drift quite a bit. I guess I need to write my own timeval_to_jiffies
conversion so that i remove the added jiffy. For this case, I actually
want a true rounded value to the closest jiffy.

Thanks again,

-- Steve


