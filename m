Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262530AbREZBoi>; Fri, 25 May 2001 21:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262535AbREZBo3>; Fri, 25 May 2001 21:44:29 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:26119 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262526AbREZBoL>;
	Fri, 25 May 2001 21:44:11 -0400
Date: Fri, 25 May 2001 22:43:48 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ben LaHaise <bcrl@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <20010526024230.K9634@athlon.random>
Message-ID: <Pine.LNX.4.21.0105252241550.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Andrea Arcangeli wrote:

> Please merge this one in 2.4 for now (originally from Ingo, I only
> improved it), this is a real definitive fix

With the only minor detail being that it DOESN'T WORK.

You're not solving the problems of GFP_BUFFER allocators
looping forever in __alloc_pages(), the deadlock can still
happen.

You've only solved the 1 specific case of highmem.c getting
a page for bounce buffers, but you'll happily let the thing
deadlock while trying to get buffer heads for a normal low
memory page!

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

