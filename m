Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130897AbRACQjz>; Wed, 3 Jan 2001 11:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131230AbRACQjp>; Wed, 3 Jan 2001 11:39:45 -0500
Received: from [62.172.234.2] ([62.172.234.2]:20122 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130897AbRACQjg>; Wed, 3 Jan 2001 11:39:36 -0500
Date: Wed, 3 Jan 2001 16:07:36 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
cc: Gerold Jury <geroldj@grips.com>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, dl8bcu@gmx.net,
        Maik.Zumstrull@gmx.de
Subject: Re: Happy new year^H^H^H^Hkernel..
In-Reply-To: <Pine.LNX.4.30.0101022348550.1202-100000@vaio>
Message-ID: <Pine.LNX.4.21.0101031539200.1427-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Kai Germaschewski wrote:

> I think the problem was that we relied on divert_if being initialized to
> zero automatically, which didn't happen because it was not declared static
> and therefore not in .bss (*is this true?*).

This is true in this particular case, and your added "static" is good.
But you seem to miss the root of the problem, that isdn_common.c declares
an "isdn_divert_if *divert_if", and divert/divert_init.c declares
an "isdn_divert_if divert_if" (initialized non-zero).  When the two .os
were linked, you got a single "divert_if" (initialized non-zero in .data).
Wouldn't it be best to (keep the "static" but also) change the name of the
pointer in isdn_common.c?

Hugh

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
