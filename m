Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263280AbSLBBuZ>; Sun, 1 Dec 2002 20:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSLBBuZ>; Sun, 1 Dec 2002 20:50:25 -0500
Received: from dp.samba.org ([66.70.73.150]:660 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263280AbSLBBuW>;
	Sun, 1 Dec 2002 20:50:22 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Matt Reppert <arashi@arashi.yi.org>, linux-kernel@vger.kernel.org
Subject: Re: Fwd: [PATCH] Unsafe MODULE_ usage in crc32.c 
In-reply-to: Your message of "Sun, 01 Dec 2002 01:27:17 BST."
             <20021201002717.GB2869@ppc.vc.cvut.cz> 
Date: Mon, 02 Dec 2002 12:56:43 +1100
Message-Id: <20021202015750.CA9C72C0CA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021201002717.GB2869@ppc.vc.cvut.cz> you write:
> Sorry, I forgot 'm' in your email address. BTW, I thought that this is
> fixed in 2.5.50, isn't?
> 							Petr

Since SMP was introduced in the kernel, MOD_INC_USE_COUNT; has never
been reliable, and since preempt was introduced, it doesn't work on UP
either[1].

It's the caller's responsibility to grab a reference.  And that's OK,
because this is done automatically for you when a module is loaded
which references one of your symbols (it's the handing out of function
pointers that you have to be careful with).

In summary, the correct solution is (and always was) to delete the
MOD_INC_USE_COUNT; and MOD_DEC_USE_COUNT; in crc32.c

Looks like someone was thinking too hard 8)

Hope this helps?
Rusty.

[1] Well, theoretically it could work if you were not preemptible, but
  since you can't be removed while not preemptible, there's usually no
  reason to bump your own refcount anyway.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
