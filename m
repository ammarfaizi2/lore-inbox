Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268634AbRGZS3v>; Thu, 26 Jul 2001 14:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268644AbRGZS3n>; Thu, 26 Jul 2001 14:29:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20242 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268634AbRGZS3h>; Thu, 26 Jul 2001 14:29:37 -0400
Date: Thu, 26 Jul 2001 20:28:44 +0200
From: Jan Hubicka <jh@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Chris Friesen <cfriesen@nortelnetworks.com>,
        Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user <user-mode-linux-user@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: user-mode port 0.44-2.4.7
Message-ID: <20010726202844.K9601@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010724020413.A29561@athlon.random> <Pine.LNX.4.33.0107240849240.29354-100000@penguin.transmeta.com> <20010726004957.F32148@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010726004957.F32148@athlon.random>; from andrea@suse.de on Thu, Jul 26, 2001 at 12:49:57AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Honza? Do you assure me that? In case you don't, could you suggest
> another way besides volatile and spinlocks around the access to the
> variable to avoid gcc to get confused?
Looking at the code, it really looks as perfect candidate for volatile.
GCC has definitly right to assume that the memory location won't change
and use it for optimization.  On the other hand, from usual usage of
time I guess gcc won't be able to do so, at least not today.

Basically most optimizations comes from that compiler recognizes that
value is equivalent to something (constant) at given code path and
promotes it futher.

So it is probably up to kernel folks if you want to follow C standard
and blame gcc developers for breaking it, or stay in the unsafe ground
and fix kernel each time gcc will introduce new nasty optimizations.
This may become tricky later - for instance as making kernel codebase
-fstrict-aliasing ready.

Honza
