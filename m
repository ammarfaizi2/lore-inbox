Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129100AbQKHQha>; Wed, 8 Nov 2000 11:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129111AbQKHQhU>; Wed, 8 Nov 2000 11:37:20 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:15123 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129102AbQKHQhB>; Wed, 8 Nov 2000 11:37:01 -0500
Date: Wed, 8 Nov 2000 17:36:40 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Rik van Riel <riel@conectiva.com.br>
cc: Szabolcs Szakacsits <szaka@f-secure.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@transmeta.com>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: Looking for better VM
In-Reply-To: <Pine.LNX.4.05.10011081450320.3666-100000@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.3.96.1001108172338.7153A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> > I also didn't say non-overcommit should be used as default and a
> > patch http://www.cs.helsinki.fi/linux/linux-kernel/2000-13/1208.html,
> > developed for 2.3.99-pre3 by Eduardo Horvath and unfortunately was
> > ignored completely, implemented it this way. 
> 
> OK. This is a lot more reasonable. I'm actually looking
> into putting non-overcommit as a configurable option in
> the kernel.
> 
> However, this does not save you from the fact that the
> system is essentially deadlocked when nothing can get
> more memory and nothing goes away. Non-overcommit won't
> give you any extra reliability unless your applications
> are very well behaved ... in which case you don't need
> non-overcommit.

BTW. Why does your OOM killer in 2.4 try to kill process that mmaped most
memory? mmap is hamrless. mmap on files can't eat memory and swap.

Imagine a case: you have database server that mmaps the whole 2G file but
doesn't have too much anonymous memory. You have an offending process that
does while (1) malloc(1000) and fills up 512M swap. Your OOM killer would
kill the server first...

Mikulas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
