Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315842AbSETK7Z>; Mon, 20 May 2002 06:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315858AbSETK7Y>; Mon, 20 May 2002 06:59:24 -0400
Received: from ns.suse.de ([213.95.15.193]:17927 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315842AbSETK7Y>;
	Mon, 20 May 2002 06:59:24 -0400
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
In-Reply-To: <Pine.LNX.4.44.0205191951460.22433-100000@home.transmeta.com.suse.lists.linux.kernel> <E179fAd-0005vs-00@wagner.rustcorp.com.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 May 2002 12:59:23 +0200
Message-ID: <p73r8k7xeyc.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> In message <Pine.LNX.4.44.0205191951460.22433-100000@home.transmeta.com> you wr
> ite:
> > 	ret = copy_from_user(xxx);
> > 	if (ret)
> > 		return ret;
> > 
> > which is apparently your suggestion.
> 
> Not quite:
> 	copy_from_user(xxx);
> 
> Is my suggestion.  No error return.

I don't think it is a good idea. Consider a driver that does lots 
of small copy_from_user() from user space for a longer write (e.g. TCP
to a small MSS) If xxx was faulting it would eat a lot of cycles with 
faulting again and again.

-Andi

