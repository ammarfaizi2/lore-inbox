Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270818AbRHNUkX>; Tue, 14 Aug 2001 16:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270824AbRHNUkD>; Tue, 14 Aug 2001 16:40:03 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8709 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270818AbRHNUj4>; Tue, 14 Aug 2001 16:39:56 -0400
Subject: Re: DoS tmpfs,ramfs, malloc, saga continues
To: iive@yahoo.com (Ivan Kalvatchev)
Date: Tue, 14 Aug 2001 21:42:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (kernelbug)
In-Reply-To: <no.id> from "Ivan Kalvatchev" at Aug 14, 2001 06:29:56 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Wl1I-0001ua-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Good job for Alan Cox, with his patch i could run the
> sample program 20 times before it crashed the system.
> I cannot belive that instead of keeping this
> masskiller for deathlocks, no way out situation, and
> as last resort, You The Great Kernel Hackers use it
> for every day and every body solution. Is it so hard
> to make more memory checks for user level malloc?
> Windows does. Every other OS does. Why linux doesn't? 
> Fix it in the next kernel!

ROTFL

If you cant crash windows nt by running out of memory you aren't doing the
right things.  Just for example feed the Nvidia direct X an infinite number
of objects to draw.

The basic answer is "Set resource limits". The default ones fit typical
usage of a system well but not your case. The more complex answer is to
provide the option for very precise group based resource accounting (aka
the beancounter patch). That is for those who want to pay the probable 2%
or so system penalty for being able to precisely manage a system resource
set. With the beancounter infrastructure you can then get to the point where
student processes are being OOM killed while the admins quake session is
unharmed.

Somewhere in the middle there is address space accounting, where you never 
allow the total address space to violate

	(read-only-pages +
		foreach writeable page
			number of extant copies +
				numer of COW potential copies
	) - kernel fudge factor (space the kernel might need)
	
			>

		    ram + swap


That is much more lightweight and covers all the general cases. However
nobody wants it much as is evident by the fact nobody has either contributed
code or paid for the work to be done

Alan
