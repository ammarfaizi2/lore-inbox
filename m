Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262555AbSI0R2X>; Fri, 27 Sep 2002 13:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262556AbSI0R2X>; Fri, 27 Sep 2002 13:28:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:7611 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262555AbSI0R2V>;
	Fri, 27 Sep 2002 13:28:21 -0400
Date: Fri, 27 Sep 2002 19:42:33 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'virtual => physical page mapping cache', vcache-2.5.38-B8
In-Reply-To: <Pine.LNX.4.44.0209271029290.14685-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209271941210.16693-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i'd love to do this, but:

> 	spin_lock(&futex_lock);
> 
> >         q.page = NULL;
> >         attach_vcache(&q.vcache, uaddr, current->mm, futex_vcache_callback);
> > 
> >         page = pin_page(uaddr - offset);

            [ LOCKUP ]

pin_page() calls get_user_pages(), which might block in handle_mm_fault().

	Ingo

