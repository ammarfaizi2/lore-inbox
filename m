Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264813AbSJPCnz>; Tue, 15 Oct 2002 22:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264827AbSJPCnz>; Tue, 15 Oct 2002 22:43:55 -0400
Received: from dp.samba.org ([66.70.73.150]:10376 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264813AbSJPCny>;
	Tue, 15 Oct 2002 22:43:54 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] futex-2.5.42-A2 
In-reply-to: Your message of "Tue, 15 Oct 2002 22:17:11 +0200."
             <Pine.LNX.4.44.0210152157001.21066-100000@localhost.localdomain> 
Date: Wed, 16 Oct 2002 12:26:02 +1000
Message-Id: <20021016024951.490F42C0DE@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0210152157001.21066-100000@localhost.localdomain> you
 write:
>  - simplified alignment check in sys_futex. (Martin Wirth)

Um, this test existed for a reason:

> -	/* Must be "naturally" aligned, and not on page boundary. */
> -	if ((pos_in_page % __alignof__(int)) != 0
> -	    || pos_in_page + sizeof(int) > PAGE_SIZE)
> +	/* Must be "naturally" aligned */
> +	if (pos_in_page % sizeof(int))
>  		return -EINVAL;

If you do this, *please* add:
	/* Above check not sufficient if align of int < size.  Break link. */
	if (__alignof__(int) < sizeof(int)) {
		extern void __error_small_int_align();
		__error_small_int_align();
	}

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
