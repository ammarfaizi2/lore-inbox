Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129997AbQL1Oqm>; Thu, 28 Dec 2000 09:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130329AbQL1Oqc>; Thu, 28 Dec 2000 09:46:32 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:35822 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129997AbQL1OqT>; Thu, 28 Dec 2000 09:46:19 -0500
Date: Thu, 28 Dec 2000 12:14:52 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dan Aloni <karrde@callisto.yi.org>, Zlatko Calusic <zlatko@iskon.hr>,
        "Marco d'Itri" <md@Linux.IT>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <Pine.LNX.4.10.10012271537260.10485-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012281210480.14052-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Dec 2000, Linus Torvalds wrote:
> On Wed, 27 Dec 2000, Rik van Riel wrote:
> > 
> > The (trivial) patch below should fix this problem.
> 
> It must be wrong.
> 
> If we have a dirty page on the LRU lists, that page _must_ have
> a mapping.

Hmm, last I looked buffercache pages didn't have
page->mapping set ...

And before anyone gets afraid that pure buffercache
pages get skipped ... they're caught by page_launder()
just fine, in the `if (page->buffers)' code below the
dirty page writeout code.

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
