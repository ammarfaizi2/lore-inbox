Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133046AbRANTDt>; Sun, 14 Jan 2001 14:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133094AbRANTDj>; Sun, 14 Jan 2001 14:03:39 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:63912 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S133046AbRANTD3>;
	Sun, 14 Jan 2001 14:03:29 -0500
Date: Sun, 14 Jan 2001 14:02:40 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.30.0101141945520.3103-100000@e2>
Message-ID: <Pine.GSO.4.30.0101141356050.12354-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Jan 2001, Ingo Molnar wrote:

>
> i believe what you are seeing here is the overhead of the pagecache. When
> using sendmsg() only, you do not read() the file every time, right? Is

In that case just a user space buffer is sent i.e no file association.

> ttcp using multiple threads?

Only a single thread, single flow setup. Very primitive but simple.

> In that case if the sendfile() is using the
> *same* file all the time, creating SMP locking overhead.
>
> if this is the case, what result do you get if you use a separate,
> isolated file per process? (And i bet that with DaveM's pagecache
> scalability patch the situation would also get much better - the global
> pagecache_lock hurts.)
>

Already doing the single file, single process. However, i do run by time
which means i could read the file from the begining(offset 0) to the end
then re-do it for as many times as 15secs would allow. Does this affect
it? I tried one 1.5 GB file, it was oopsing and given my setup right now i
cant trace it. So i am using about 170M which is read about 8 times in
the 15 secs

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
