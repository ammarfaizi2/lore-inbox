Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132218AbQLHS6F>; Fri, 8 Dec 2000 13:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130146AbQLHS5z>; Fri, 8 Dec 2000 13:57:55 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:63753 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129669AbQLHS5p>; Fri, 8 Dec 2000 13:57:45 -0500
Date: Fri, 8 Dec 2000 10:26:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Rohland <cr@sap.com>
cc: linux-kernel@vger.kernel.org, ch.rohland@gmx.net
Subject: Re: [PATCH,preliminary] cleanup shm handling
In-Reply-To: <qwwu28fkpxh.fsf@sap.com>
Message-ID: <Pine.LNX.4.10.10012081023170.11302-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 Dec 2000, Christoph Rohland wrote:
> 
> here is my first shot for cleaning up the shm handling. It did survive
> some basic testing but is not ready for inclusion. 

The only comment I have right now is that you probably should not mark the
page dirty in "nopage" - theoretically somebody might have a sparse
mapping and depend on zero pages for the ones that aren't touched. It's
better to delay the dirty marking until swapout() (and write(), when that
is implemented), so that we don't needlessly create swap entries for zero
pages.

(No, probably nobody does this for traditional shared memory, but I could
well imagine mmap() on /dev/zero with most of the pages being read-only).

Other than that the approach at least looks reasonable. And cleaner than
what we currently have.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
