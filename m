Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSETBfo>; Sun, 19 May 2002 21:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315679AbSETBfn>; Sun, 19 May 2002 21:35:43 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:48399 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315629AbSETBfm>; Sun, 19 May 2002 21:35:42 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: AUDIT of 2.5.15 copy_to/from_user 
In-Reply-To: Your message of "Sun, 19 May 2002 12:44:30 +0100."
             <E179P70-0003dg-00@the-village.bc.nu> 
Date: Mon, 20 May 2002 11:38:32 +1000
Message-Id: <E179c88-0004HH-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E179P70-0003dg-00@the-village.bc.nu> you write:
> Looking at 2.4.1x which has the same signal code
> 
> > arch/i386/kernel/signal.c:37:		return __copy_to_user(to, from,
 sizeof(siginfo_t));
> 
> not a bug

Disagree.  May not cause problems at the moment, but a function which
does:

	if (!access_ok (VERIFY_WRITE, to, sizeof(siginfo_t)))
		return -EFAULT;
	if (from->si_code < 0)
		return __copy_to_user(to, from, sizeof(siginfo_t));

Is clearly wrong,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
