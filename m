Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLGHnJ>; Thu, 7 Dec 2000 02:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQLGHnA>; Thu, 7 Dec 2000 02:43:00 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:11027 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129226AbQLGHmi>; Thu, 7 Dec 2000 02:42:38 -0500
Date: Wed, 6 Dec 2000 23:10:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Miles Lane <miles@megapathdsl.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: The horrible hack from hell called A20
In-Reply-To: <3A2F3174.60205@megapathdsl.net>
Message-ID: <Pine.LNX.4.10.10012062307280.1221-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2000, Miles Lane wrote:
> 
> I have also just tried a test pass with 3c59x built in and
> USB built as modules.  I booted with only the 3c575 inserted.
> I got eth0 running and then loaded usb-ohci (with the enable
> bus mastering change added).  This resulted in modprobe hanging
> again.

I bet you're hanging on the rtnl_semaphore due to having a /sbin/hotplug
policy.

Miles, mind trying out a really simple change in the
____call_usermodehelper() function in kernel/kmod.c? 

Change: #if 0 out the whole block that says "if (retval >= 0)" and does
the waiting for the child. We shouldn't wait for the user mode helper:
that's just going to cause nasty deadlocks. Deadlocks like the one you
seem to be seeing, in fact.

Does your ifconfig problem go away with that fix?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
