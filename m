Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277127AbRJJVZm>; Wed, 10 Oct 2001 17:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277410AbRJJVZc>; Wed, 10 Oct 2001 17:25:32 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:43272 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277127AbRJJVZS>; Wed, 10 Oct 2001 17:25:18 -0400
Date: Wed, 10 Oct 2001 18:25:27 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: <kernelnewbies@nl.linux.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [CFT][PATCH] smoother VM for -ac
In-Reply-To: <20011010164823.A17860@redhat.com>
Message-ID: <Pine.LNX.4.33L.0110101815140.26495-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001, Benjamin LaHaise wrote:
> On Wed, Oct 10, 2001 at 05:25:30PM -0300, Rik van Riel wrote:
> > 4) in page_alloc.c, the "slowdown" reschedule has been
> >    made stronger by turning it into a try_to_free_pages(),

> There's a small problem with this one: I know that during
> testing of earlier 2.4 kernels we saw a livelock which was
> caused by the vm subsystem spinning without scheduling.  This
> can happen in a couple of cases like NFS where another task has
> to be allowed to run in order to make progress in clearing
> pages.

OK, I'll add back the reschedule() to fix this case.

I don't like it too much, but I wouldn't know of an
easier way to fix the NFS thing. I guess we could delay
it to the zone->pages_min point though ... should cut
down on the number of reschedules ;)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

