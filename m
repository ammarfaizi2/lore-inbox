Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261938AbSIYIJY>; Wed, 25 Sep 2002 04:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261939AbSIYIJY>; Wed, 25 Sep 2002 04:09:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:3273 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261938AbSIYIJY>;
	Wed, 25 Sep 2002 04:09:24 -0400
Date: Wed, 25 Sep 2002 10:23:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: alfred@leakybucket.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2 futex questions
In-Reply-To: <20020925003353.GA15418@closet.leakybucket.org>
Message-ID: <Pine.LNX.4.44.0209251015320.4690-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Sep 2002 alfred@leakybucket.org wrote:

> 1) There's a comment in sys_futex(...) that says pos_in_page must not be
> on a page boundary. Could someone explain why?

what it wants to say: 'the futex word must not overflow into the next
page', ie. the futex word needs to be on a single page.

> 2) How is this ever true:
> 	pos_in_page + sizeof(int) > PAGE_SIZE
> when checking if pos_in_page is valid?

the full test is this:

        pos_in_page = ((unsigned long)uaddr) % PAGE_SIZE;

        if ((pos_in_page % __alignof__(int)) != 0
            || pos_in_page + sizeof(int) > PAGE_SIZE)
                return -EINVAL;

what it says: 'uaddr must be naturally aligned, and the word must be on a
single page'. In theory it's possible that __alignof__(int) !=
sizeof(int).

	Ingo

