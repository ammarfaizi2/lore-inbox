Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132533AbRDNT16>; Sat, 14 Apr 2001 15:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132535AbRDNT1s>; Sat, 14 Apr 2001 15:27:48 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:37382 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132533AbRDNT1m>; Sat, 14 Apr 2001 15:27:42 -0400
Date: Sat, 14 Apr 2001 16:27:33 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Christoph Rohland <cr@sap.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: shmem_getpage_locked() / swapin_readahead() race in 2.4.4-pre3
In-Reply-To: <Pine.LNX.4.21.0104141244510.1786-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0104141625200.9455-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Apr 2001, Marcelo Tosatti wrote:

> There is a nasty race between shmem_getpage_locked() and
> swapin_readahead() with the new shmem code (introduced in
> 2.4.3-ac3 and merged in the main tree in 2.4.4-pre3):

> I don't see any clean fix for this one.
> Suggestions ?

As we discussed with Alan on irc, we could remove the (physical)
swapin_readahead() and get 2.4 stable. Once 2.4 is stable we
could (if needed) introduce a virtual address based readahead
strategy for swap-backed things ... most of that code has been
ready for months thanks to Ben LaHaise.

A virtual-address based readahead not only makes much more sense
from a performance POV, it also cleanly gets the ugly locking
issues out of the way.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

